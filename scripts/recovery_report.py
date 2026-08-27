#!/usr/bin/env python3
"""Tree-sitter error-recovery regression report for the Cangjie grammar.

For every `.cj` file in a directory (default: test/recovery), run
`tree-sitter parse`, then measure how *localized* the recovery is:

  * ERROR coverage  -- bytes of the file swallowed by outermost (ERROR ...)
    nodes. Cascading recovery shows up as one ERROR eating the rest of the
    file; good recovery keeps ERROR small and near the actual mistake.
  * MISSING tokens  -- insertions tree-sitter guessed (zero-width; reported
    from the per-file summary line the CLI prints).

Each file is classified:
  localized  -- ERROR coverage < LOCALIZED and not reaching EOF
  partial    -- between LOCALIZED and CASCADING
  cascading  -- coverage >= CASCADING, or an ERROR swallows the rest of the file

Exit code is non-zero if any file is "cascading" (use as a CI gate), unless
--no-fail is passed.

Usage:
  python3 scripts/recovery_report.py                  # test/recovery, default thresholds
  python3 scripts/recovery_report.py --dir test/recovery
  python3 scripts/recovery_report.py --build           # `tree-sitter generate` first
  python3 scripts/recovery_report.py --json            # machine-readable
  python3 scripts/recovery_report.py -v FILE           # show the full parse tree for one file

NOTE on MISSING counts: tree-sitter 0.25's CLI text dump omits zero-width
MISSING children from the tree body, so they are read from the per-file
summary line (one representative token). To count *every* MISSING node
programmatically you'd need the tree_sitter Python binding; this script
flags presence/representative only.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_DIR = REPO_ROOT / "test" / "recovery"

# Verdict thresholds (fraction of file bytes covered by outermost ERROR nodes).
LOCALIZED_MAX = 0.25   # < 25%  -> localized
CASCADING_MIN = 0.60   # >= 60% -> cascading (also forced if an ERROR reaches EOF)

# Regex for an ERROR node opening: (ERROR [r0, c0] - [r1, c1]
ERROR_RE = re.compile(
    r"\(ERROR\s+\[(\d+),\s*(\d+)\]\s*-\s*\[(\d+),\s*(\d+)\]"
)
# Regex for any MISSING mention in the per-file summary line. MISSING can be a
# quoted terminal ("}", ";") or a bare nonterminal (varBindingPattern):
#   (MISSING "}" [r, c] - [r, c])
#   (MISSING varBindingPattern [r, c] - [r, c])
MISSING_RE = re.compile(
    r'\(MISSING\s+(?:"(?P<q>[^"]+)"|(?P<bare>\S+))\s+\[(\d+),\s*(\d+)\]\s*-\s*\[(\d+),\s*(\d+)\]'
)
# The per-file summary line: <path>\tParse: ... ms\t... bytes/ms\t(summary)
SUMMARY_RE = re.compile(r"^(?P<path>\S+)\tParse:\s.*$")


@dataclass
class ErrSpan:
    r0: int
    c0: int
    r1: int
    c1: int


@dataclass
class FileReport:
    path: Path
    bytes_total: int = 0
    errors: list[ErrSpan] = field(default_factory=list)        # outermost ERROR nodes
    error_bytes: int = 0                                      # union of outermost ERROR spans
    coverage: float = 0.0
    missing_token: str | None = None
    missing_loc: tuple[int, int] | None = None
    reaches_eof: bool = False
    verdict: str = "clean"
    parse_ms: float | None = None
    note: str = ""


def run_parse(file: Path, timeout: float) -> tuple[str, str, int]:
    """Run `tree-sitter parse` on one file, return (stdout, stderr, exit)."""
    proc = subprocess.run(
        ["tree-sitter", "parse", str(file)],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
        timeout=timeout,
    )
    return proc.stdout, proc.stderr, proc.returncode


def split_tree_and_summary(stdout: str) -> tuple[str, str]:
    """Separate the S-expression tree from the trailing per-file summary line."""
    summary = ""
    lines = stdout.splitlines()
    # find the last line that looks like a summary
    for line in reversed(lines):
        if SUMMARY_RE.match(line):
            summary = line
            break
    if summary:
        tree = "\n".join(l for l in lines if l is not summary)
    else:
        tree = stdout
    return tree, summary


def outermost_spans(spans: list[ErrSpan]) -> list[ErrSpan]:
    """Keep only ERROR nodes not contained inside another (larger) ERROR."""
    spans = sorted(spans, key=lambda s: (s.r0, s.c0, -s.r1, -s.c1))
    result: list[ErrSpan] = []
    for s in spans:
        if any(
            o.r0 < s.r0 or (o.r0 == s.r0 and o.c0 <= s.c0)
            and (o.r1 > s.r1 or (o.r1 == s.r1 and o.c1 >= s.c1))
            and o is not s
            for o in result
        ):
            continue
        result.append(s)
    return result


def line_offsets(src: bytes) -> list[int]:
    offs = [0]
    for b in src:
        if b == 0x0A:
            offs.append(0)  # placeholder; fix below
    # rebuild properly
    offs = [0]
    for i, b in enumerate(src):
        if b == 0x0A:
            offs.append(i + 1)
    return offs


def rc_to_offset(lo: list[int], r: int, c: int) -> int:
    if r >= len(lo):
        return lo[-1] if lo else 0
    return lo[r] + c


def classify(rep: FileReport, src: bytes, localized_max: float, cascading_min: float) -> None:
    n = len(src)
    if n == 0 or not rep.errors:
        rep.verdict = "clean"
        return
    # byte coverage = union of outermost ERROR spans
    lo = line_offsets(src)
    spans = []
    for e in rep.errors:
        s = rc_to_offset(lo, e.r0, e.c0)
        en = rc_to_offset(lo, e.r1, e.c1)
        spans.append((s, en))
    spans = sorted(spans)
    # union
    union = []
    for s, en in spans:
        if union and s <= union[-1][1]:
            union[-1] = (union[-1][0], max(union[-1][1], en))
        else:
            union.append((s, en))
    rep.error_bytes = sum(en - s for s, en in union)
    rep.coverage = rep.error_bytes / n if n else 0.0
    # EOF-swallow: any outermost ERROR ending at/after last line
    last_line = src.count(b"\n")
    rep.reaches_eof = any(e.r1 >= last_line for e in rep.errors)
    if rep.reaches_eof or rep.coverage >= cascading_min:
        rep.verdict = "cascading"
    elif rep.coverage < localized_max:
        rep.verdict = "localized"
    else:
        rep.verdict = "partial"


def analyze(file: Path, build: bool, timeout: float, localized_max: float, cascading_min: float) -> FileReport:
    rep = FileReport(path=file)
    try:
        src = file.read_bytes()
    except OSError as e:
        rep.verdict = "error"
        rep.note = f"unreadable: {e}"
        return rep
    rep.bytes_total = len(src)
    try:
        stdout, stderr, rc = run_parse(file, timeout)
    except subprocess.TimeoutExpired:
        rep.verdict = "cascading"
        rep.note = "parse timed out"
        return rep
    except FileNotFoundError:
        rep.verdict = "error"
        rep.note = "tree-sitter CLI not found on PATH"
        return rep
    if rc != 0 and not stdout:
        rep.verdict = "error"
        rep.note = (stderr or "").strip().splitlines()[:1] and (stderr or "no stderr").strip()
        return rep
    tree, summary = split_tree_and_summary(stdout)
    # all ERROR spans (incl. nested), then keep outermost
    all_err = [
        ErrSpan(int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4)))
        for m in ERROR_RE.finditer(tree)
    ]
    rep.errors = outermost_spans(all_err)
    # MISSING (from summary line; representative token only)
    mm = MISSING_RE.search(summary)
    if mm:
        rep.missing_token = mm.group("q") or mm.group("bare")
        rep.missing_loc = (int(mm.group(3)), int(mm.group(4)))
    # parse time
    mt = re.search(r"Parse:\s*([\d.]+)\s*ms", summary)
    if mt:
        rep.parse_ms = float(mt.group(1))
    classify(rep, src, localized_max, cascading_min)
    return rep


def fmt_pct(x: float) -> str:
    return f"{x*100:5.1f}%"


def print_table(reps: list[FileReport], verbose_path: Path | None) -> None:
    reps = sorted(reps, key=lambda r: (-r.coverage, r.path.name))
    name_w = max(len(r.path.name) for r in reps) if reps else 8
    hdr = f"{'file'.ljust(name_w)}  {'verdict':9}  {'cov':6}  {'errB':>6}  {'totB':>6}  {'#ERR':>4}  {'MISSING':<14}  parse"
    print(hdr)
    print("-" * len(hdr))
    for r in reps:
        miss = f'"{r.missing_token}" @{r.missing_loc[0]},{r.missing_loc[1]}' if r.missing_token else "-"
        ms = f"{r.parse_ms:.2f}ms" if r.parse_ms is not None else "-"
        print(
            f"{r.path.name.ljust(name_w)}  {r.verdict:9}  "
            f"{fmt_pct(r.coverage)}  {r.error_bytes:6d}  {r.bytes_total:6d}  "
            f"{len(r.errors):4d}  {miss:<14}  {ms}"
        )
        if r.note:
            print(f"  {'':{name_w}}  note: {r.note}")
        if verbose_path and (r.path.resolve() == verbose_path.resolve()):
            # dump the full parse tree for this file
            stdout, _, _ = run_parse(r.path, 30.0)
            tree, _ = split_tree_and_summary(stdout)
            print(f"\n--- parse tree for {r.path.name} ---\n{tree}\n--- end ---")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--dir", type=Path, default=DEFAULT_DIR, help="directory of broken .cj inputs")
    ap.add_argument("--build", action="store_true", help="run `tree-sitter generate` once before parsing")
    ap.add_argument("--localized", type=float, default=LOCALIZED_MAX, help="coverage below this is 'localized'")
    ap.add_argument("--cascading", type=float, default=CASCADING_MIN, help="coverage at/above this is 'cascading'")
    ap.add_argument("--timeout", type=float, default=30.0, help="per-parse timeout in seconds")
    ap.add_argument("--no-fail", action="store_true", help="always exit 0 even if cascading")
    ap.add_argument("--json", action="store_true", help="emit JSON instead of a table")
    ap.add_argument("-v", "--verbose", type=Path, metavar="FILE", help="dump the full parse tree for one file")
    args = ap.parse_args(argv)

    if not args.dir.is_dir():
        print(f"error: {args.dir} is not a directory", file=sys.stderr)
        return 2

    files = sorted(p for p in args.dir.iterdir() if p.suffix in (".cj", ".cangjie"))
    if not files:
        print(f"no .cj files in {args.dir}", file=sys.stderr)
        return 2

    if args.build:
        print("regenerating grammar (tree-sitter generate)...", file=sys.stderr)
        subprocess.run(["tree-sitter", "generate"], cwd=REPO_ROOT, check=False,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=120.0)

    reps = [analyze(f, False, args.timeout, args.localized, args.cascading) for f in files]

    if args.json:
        data = [r.__dict__ for r in reps]
        data = [{**d, "path": str(Path(d["path"]).relative_to(REPO_ROOT))} for d in data]
        print(json.dumps(data, indent=2, default=str))
    else:
        print_table(reps, args.verbose)
        # summary
        from collections import Counter
        c = Counter(r.verdict for r in reps)
        print()
        print(f"total: {len(reps)}  localized={c.get('localized',0)}  "
              f"partial={c.get('partial',0)}  cascading={c.get('cascading',0)}  "
              f"clean={c.get('clean',0)}  error={c.get('error',0)}")
        worst = [r for r in reps if r.verdict == "cascading"]
        if worst:
            print("\ncascading files (worst recovery):")
            for r in sorted(worst, key=lambda x: -x.coverage):
                print(f"  {r.path.name}: {fmt_pct(r.coverage)} coverage"
                      + (" (reaches EOF)" if r.reaches_eof else ""))

    if args.no_fail:
        return 0
    return 1 if any(r.verdict == "cascading" for r in reps) else 0


if __name__ == "__main__":
    sys.exit(main())
