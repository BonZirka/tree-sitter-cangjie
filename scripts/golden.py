#!/usr/bin/env python3
"""GOLDEN tests for tree-sitter-cangjie.

Parses every `.cj` file found under the reference corpus with this grammar
via the tree-sitter CLI and stores a byte-exact snapshot (full CST down to
anonymous tokens + positions, plus syntax-highlight rendering derived from
queries/highlights.scm) under test/golden/.

Reference corpus
----------------
By default the *vendored* sources under test/sources/ are used (see
test/sources/README.md), so a fresh clone can verify everything. Pass
--roots DIR (repeatable) to scan a local checkout instead, e.g.
~/projects/cangjie-repos/cangjie_stdx; file keys stay identical for both
layouts, so golden snapshots remain valid.

Workflow
--------
* file seen for the first time  -> golden is created (NEW)
* file seen before              -> re-parse and compare against golden
    * identical                 -> OK
    * source changed upstream   -> golden re-recorded (REBASED)
    * dump differs              -> DIFF: you decide per file:
        * accept  (`u`)  -> golden updated to the new state
        * reject  (`k`)  -> kept as REGRESSION -> fix the grammar
* ERROR/MISSING nodes per file are counted; a diff that increases a file's
  error count is reported as an ERROR-REGRESSION, and `--fail-on-error N`
  fails the run when more than N files contain error nodes.
* exit code is non-zero while unresolved regressions exist

The CLI version is pinned (PINNED_CLI); mismatched installs fail loudly
unless --any-cli is given.

Examples
--------
  python3 scripts/golden.py                    # record new + verify all
  python3 scripts/golden.py --ci               # same, never prompts
  python3 scripts/golden.py stdx               # filter files by substring
  python3 scripts/golden.py --diff core.cj     # inspect one failure
  python3 scripts/golden.py --update core.cj   # accept new state per file
  python3 scripts/golden.py --update-all       # accept every pending diff
  python3 scripts/golden.py --prune            # drop goldens w/o sources
  python3 scripts/golden.py --ci --fail-on-error 0   # strict: no ERROR trees
"""

import argparse
import concurrent.futures
import difflib
import gzip
import hashlib
import os
import re
import shutil
import subprocess
import sys

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# Vendored corpus: keys are computed relative to this directory.
DEFAULT_BASE = os.path.join(REPO_ROOT, "test", "sources")
DEFAULT_ROOTS = [
    os.path.join(DEFAULT_BASE, "cangjie_runtime", "stdlib"),
    os.path.join(DEFAULT_BASE, "cangjie_stdx"),
    os.path.join(DEFAULT_BASE, "cangjie_test"),
]
# Legacy local checkouts keep their historical keys via these bases.
LEGACY_BASES = [
    os.path.join(os.path.expanduser("~"), "projects", "cangjie-repos"),
]
GOLDEN_DIR = os.path.join(REPO_ROOT, "test", "golden")
SCOPE = "source.cj"
FORMAT = "goldenv1"
SUMMARY_RE = re.compile(r"^\S+\s+Parse:.*$")
ANSI_RE = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")
HL_ROW_RE = re.compile(
    r"<tr><td class=line-number>\d+</td><td class=line>(.*?)</td></tr>",
    re.DOTALL,
)
TREE_SECTION_MARK = "=== highlights:"
ERROR_NODE_RE = re.compile(r"\((?:ERROR|MISSING)")
# Minor version line of the tree-sitter CLI this harness is validated with.
PINNED_CLI = "0.25"


def find_cli():
    exe = shutil.which("tree-sitter")
    if exe:
        return exe
    fallback = os.path.expanduser("~/.cargo/bin/tree-sitter")
    if os.path.isfile(fallback) and os.access(fallback, os.X_OK):
        return fallback
    sys.exit("error: tree-sitter CLI not found.\n"
             "Install it with:  cargo install tree-sitter-cli")


def cli_version(cli):
    out = subprocess.run([cli, "--version"], capture_output=True, text=True)
    return out.stdout.strip().split()[-1] if out.returncode == 0 else "unknown"


def check_cli_version(cli, version, allow_any):
    """Fail loudly when the CLI is outside the pinned minor line."""
    if allow_any or version.startswith(PINNED_CLI + "."):
        return
    sys.exit(
        f"error: tree-sitter CLI {version} is outside the pinned line "
        f"{PINNED_CLI}.x; the HTML/parse output this harness snapshots "
        "is not stable across CLI releases.\n"
        f"Install a pinned CLI with:  cargo install tree-sitter-cli --version {PINNED_CLI}.x\n"
        "(or pass --any-ci to skip this check)".replace("--any-ci", "--any-cli"))


def key_for(path, root):
    """Stable file key across vendored and legacy layouts."""
    for base in [DEFAULT_BASE] + LEGACY_BASES:
        if path.startswith(base + os.sep):
            return os.path.relpath(path, base).replace(os.sep, "/")
    return os.path.relpath(path, root).replace(os.sep, "/")


def discover_sources(roots):
    """Return sorted [(key, abs_path)] for every .cj file under roots.

    Keys are relative to the vendored corpus base (or, for external
    checkouts, to the legacy cangjie-repos base) so they stay stable.
    """
    entries = set()
    for root in roots:
        root = os.path.abspath(root)
        if not os.path.isdir(root):
            sys.exit(f"error: reference root does not exist: {root}")
        for dirpath, dirnames, filenames in os.walk(root):
            dirnames[:] = sorted(d for d in dirnames if not d.startswith("."))
            for fn in sorted(filenames):
                if fn.endswith(".cj"):
                    path = os.path.join(dirpath, fn)
                    entries.add((key_for(path, root), path))
    return sorted(entries)


def golden_path(key):
    return os.path.join(GOLDEN_DIR, key + ".golden.gz")


def read_golden(gp):
    with gzip.open(gp, "rt", encoding="utf8") as f:
        return f.read()


def write_golden(gp, text):
    os.makedirs(os.path.dirname(gp), exist_ok=True)
    with gzip.open(gp, "wt", encoding="utf8", compresslevel=9) as f:
        f.write(text)


def run_dump(cli, path):
    """Canonical dump of one source file: CST + highlight rendering."""
    parse = subprocess.run([cli, "parse", "--encoding", "utf8", path],
                           capture_output=True)
    tree = ANSI_RE.sub("", parse.stdout.decode("utf8", errors="replace"))
    tree = "\n".join(ln for ln in tree.splitlines()
                     if not SUMMARY_RE.match(ln.strip())).rstrip("\n")

    hl = subprocess.run(
        [cli, "highlight", "--html", "--css-classes", "--scope", SCOPE, path],
        capture_output=True)
    raw = hl.stdout.decode("utf8", errors="replace")
    rows = HL_ROW_RE.findall(raw)
    hl_body = "\n".join(rows) if rows else raw

    return (f"{FORMAT}\n"
            f"=== tree: tree-sitter parse ===\n{tree}\n"
            f"=== highlights: queries/highlights.scm ===\n{hl_body.rstrip()}\n")


def header(key, path, version):
    sha = hashlib.sha256(open(path, "rb").read()).hexdigest()
    return f"# {FORMAT} | source: {key}\n# cli: {version} | sha256: {sha}\n"


def body_of(text):
    lines = text.splitlines(keepends=True)
    for i, ln in enumerate(lines):
        if ln.startswith("==="):
            return "".join(lines[i:])
    return text


def sha_of(text):
    m = re.search(r"sha256: ([0-9a-f]{64})", text)
    return m.group(1) if m else None


def tree_section_of(text):
    """Just the `tree-sitter parse` half of a dump (before highlights)."""
    idx = text.find(TREE_SECTION_MARK)
    return text[:idx] if idx >= 0 else text


def error_count_of(text):
    """Number of ERROR/MISSING nodes in a dump's tree section."""
    return len(ERROR_NODE_RE.findall(tree_section_of(text)))


def unified_diff(old, new, key, max_lines=60):
    d = list(difflib.unified_diff(old.splitlines(), new.splitlines(),
                                  f"golden/{key}", "current", lineterm=""))
    if len(d) > max_lines:
        d = d[:max_lines] + [f"... ({len(d) - max_lines} more diff lines)"]
    return "\n".join(d)


def accept(gp, key, path, dump, version):
    write_golden(gp, header(key, path, version) + dump)


def main():
    ap = argparse.ArgumentParser(description="GOLDEN regression harness")
    ap.add_argument("filters", nargs="*",
                    help="substring filters on file keys/paths")
    ap.add_argument("--roots", action="append", metavar="DIR",
                    help="reference directory to scan; repeatable "
                         "(default: ~/projects/cangjie-repos/{cangjie_runtime/stdlib,cangjie_stdx})")
    ap.add_argument("--ci", action="store_true",
                    help="non-interactive: print diffs, exit 1 on any mismatch")
    ap.add_argument("--update", nargs="+", metavar="KEY", default=[],
                    help="accept current parse state for matching file(s)")
    ap.add_argument("--update-all", action="store_true",
                    help="accept current parse state for every diff")
    ap.add_argument("--list", action="store_true",
                    help="show per-file state and exit")
    ap.add_argument("--diff", metavar="KEY",
                    help="show unified diff for one file and exit")
    ap.add_argument("--show", metavar="KEY",
                    help="print stored golden and exit")
    ap.add_argument("--dump", metavar="KEY",
                    help="print fresh dump for one file and exit")
    ap.add_argument("--prune", action="store_true",
                    help="delete goldens whose source no longer exists")
    ap.add_argument("--fail-on-error", metavar="N", type=int, default=None,
                    help="exit non-zero when more than N files contain "
                         "ERROR/MISSING nodes")
    ap.add_argument("--list-errors", action="store_true",
                    help="list files whose parse contains ERROR/MISSING nodes")
    ap.add_argument("--any-cli", action="store_true",
                    help=f"skip the pinned CLI check (PINNED_CLI={PINNED_CLI})")
    ap.add_argument("--jobs", type=int, default=max(1, os.cpu_count() or 2))
    args = ap.parse_args()

    roots = args.roots or DEFAULT_ROOTS
    cli = find_cli()
    version = cli_version(cli)
    check_cli_version(cli, version, args.any_cli)

    entries_all = discover_sources(roots)
    if args.filters:
        entries_all = [e for e in entries_all
                       if all(f.lower() in e[0].lower() for f in args.filters)]
    paths_by_key = dict(entries_all)

    def match_one(flag, value):
        exact = [k for k in paths_by_key if k == value]
        hits = exact or [k for k in paths_by_key if value in k]
        if len(hits) != 1:
            sys.exit(f"error: '{value}' matched {len(hits)} files, need exactly 1")
        return hits[0]

    # ---- single-file modes ---------------------------------------------
    if args.show or args.dump:
        key = match_one("--show/--dump", args.show or args.dump)
        if args.dump:
            sys.stdout.write(run_dump(cli, paths_by_key[key]))
        else:
            gp = golden_path(key)
            if not os.path.isfile(gp):
                sys.exit(f"error: no golden for {key}")
            sys.stdout.write(read_golden(gp))
        return

    if args.diff:
        key = match_one("--diff", args.diff)
        gp = golden_path(key)
        if not os.path.isfile(gp):
            sys.exit(f"error: no golden for {key}")
        old = body_of(read_golden(gp))
        new = body_of(run_dump(cli, paths_by_key[key]))
        print(unified_diff(old, new, key, max_lines=10 ** 9))
        return

    # ---- main pass -------------------------------------------------------
    def dump_one(entry):
        key, path = entry
        try:
            return key, run_dump(cli, path), None
        except Exception as e:  # noqa: BLE001
            return key, None, str(e)

    dumps, errors = {}, {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as ex:
        for key, dump, err in ex.map(dump_one, entries_all):
            (errors if err else dumps)[key] = err or dump
    for k in sorted(errors):
        print(f"TOOL-ERROR {k}: {errors[k]}", file=sys.stderr)

    if args.prune:
        removed = 0
        known = set(paths_by_key)
        for dirpath, _, filenames in os.walk(GOLDEN_DIR):
            for fn in filenames:
                if not fn.endswith(".golden.gz"):
                    continue
                key = os.path.relpath(os.path.join(dirpath, fn),
                                      GOLDEN_DIR)[: -len(".golden.gz")]
                if key.replace(os.sep, "/") not in known:
                    os.remove(os.path.join(dirpath, fn))
                    removed += 1
        print(f"pruned {removed} orphaned golden(s)")
        return

    update_keys = set()
    if args.update:
        for v in args.update:
            update_keys.add(match_one("--update", v))

    new = ok = rebased = updated = regression = error_regressions = 0
    pending = []
    files_with_errors = {}

    for key, path in entries_all:
        gp = golden_path(key)
        cur = dumps.get(key)
        if cur is None:
            regression += 1          # tool error counts as failure
            continue
        n_err = error_count_of(cur)
        if n_err:
            files_with_errors[key] = n_err
        src_sha = hashlib.sha256(open(path, "rb").read()).hexdigest()
        if not os.path.isfile(gp):
            accept(gp, key, path, cur, version)
            new += 1
            continue
        try:
            old_text = read_golden(gp)
            corrupt = False
        except Exception:  # noqa: BLE001 — unreadable/corrupt golden
            old_text, corrupt = "", True
        _, old_body = None, body_of(old_text) or ("<unreadable>" if corrupt else "")
        new_body = body_of(cur)
        old_err = error_count_of(old_body) if not corrupt else 0
        if not corrupt and sha_of(old_text) != src_sha:
            accept(gp, key, path, cur, version)     # upstream source changed
            rebased += 1
        elif not corrupt and old_body == new_body:
            ok += 1
        elif key in update_keys or args.update_all:
            accept(gp, key, path, cur, version)
            updated += 1
        elif corrupt:
            pending.append((key, path,
                            "# <golden file is corrupt; run --update to rewrite>",
                            new_body, gp))
        else:
            pending.append((key, path, old_body, new_body, gp))
            if n_err > old_err:
                error_regressions += 1

    interactive = sys.stdin.isatty() and not args.ci
    for key, path, old_body, new_body, gp in pending:
        regression += 1
        err_tag = ""
        if error_count_of(new_body) > error_count_of(old_body):
            err_tag = "  [ERROR-COUNT INCREASED]"
        if not interactive:
            print(f"\nDIFF {key}{err_tag}")
            print(unified_diff(old_body, new_body, key))
            continue
        print("=" * 70)
        print(f"DIFF {key}{err_tag}")
        print(unified_diff(old_body, new_body, key))
        ans = input("[u]pdate golden / [k]eep as regression / "
                    "[a]ccept ALL remaining / [q]uit: ").strip().lower()
        if ans == "u":
            accept(gp, key, path, dumps[key], version)
            regression -= 1
            updated += 1
        elif ans == "a":
            for k2, p2, _, _, g2 in pending[
                pending.index((key, path, old_body, new_body, gp)):]:

                accept(g2, k2, p2, dumps[k2], version)
                updated += 1
            regression -= len(pending) - pending.index(
                (key, path, old_body, new_body, gp))
            break
        elif ans == "q":
            break
        # anything else ('k') => stays a regression

    if args.list_errors:
        for k in sorted(files_with_errors, key=lambda k: -files_with_errors[k]):
            print(f"ERRORS {files_with_errors[k]:3d}  {k}")

    err_total = sum(files_with_errors.values())
    print(f"\nsummary: {len(entries_all)} files | {ok} ok | {new} new | "
          f"{rebased} rebased | {updated} updated | {regression} REGRESSION"
          + (f" | {error_regressions} ERROR-REGRESSION" if error_regressions else "")
          + f" | error nodes in {len(files_with_errors)} files ({err_total} total)"
          + (" | tool errors on stderr" if errors else ""))
    failed = regression > 0 or bool(errors)
    if args.fail_on_error is not None and len(files_with_errors) > args.fail_on_error:
        print(f"--fail-on-error {args.fail_on_error} exceeded: "
              f"{len(files_with_errors)} files contain ERROR/MISSING nodes")
        failed = True
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    try:
        main()
    except BrokenPipeError:
        os.dup2(os.open(os.devnull, os.O_WRONLY), sys.stdout.fileno())
        sys.exit(0)
