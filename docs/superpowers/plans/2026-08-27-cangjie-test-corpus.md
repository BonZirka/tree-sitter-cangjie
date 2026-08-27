# Extend test corpus from cangjie_test — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Vendor a classified `.cj` corpus from `~/newrepos/main/cangjie_test` into `test/sources/cangjie_test/` and record golden snapshots for every file through the existing `scripts/golden.py` harness (Approach A — unified golden harness).

**Architecture:** A reproducible stratified sampler (`scripts/sample_cangjie_test.py`) selects files: every `.cj` under syntax-focused dirs (full) + 5% per top-level stratum capped at 300, seed 42. `golden.py` parses each, records a golden (NEW), and `--list-errors` reports the positive (0 ERROR nodes) vs negative (has ERROR/MISSING nodes) split. Classification is implicit in the golden's error count — no separate tool.

**Tech Stack:** Python 3.10+ stdlib (`argparse`, `os`, `random`, `unittest`); tree-sitter CLI 0.25.x; `make golden` harness; GNU coreutils (`install`, `rsync`).

**Spec:** `docs/superpowers/specs/2026-08-27-cangjie-test-corpus-design.md`

---

## File Structure

- **Create:** `scripts/sample_cangjie_test.py` — reproducible stratified sampler. Pure `select()` + CLI (`--output`, `--vendor DIR`, `--root`, `--seed`, `--rate`, `--cap`). One responsibility: decide which files to vendor, optionally copy them.
- **Create:** `scripts/test_sample_cangjie_test.py` — `unittest` suite for `select()` (full-dir inclusion, cap, min-1-per-stratum, determinism, non-`.cj` ignored, unknown dirs ignored).
- **Modify:** `scripts/golden.py:60-63` — append `test/sources/cangjie_test` to `DEFAULT_ROOTS`.
- **Modify:** `test/sources/README.md` — add a `cangjie_test/` row + Apache-2.0 w/ Runtime Library Exception license note.
- **Create (via tooling):** `test/sources/cangjie_test/**/*.cj` — vendored sources.
- **Create (via tooling):** `test/golden/cangjie_test/**/*.cj.golden.gz` — golden snapshots.

Run the Python tests with `python3 -m unittest` (pytest is NOT installed; the repo uses `unittest.TestCase`, see `bindings/python/tests/test_binding.py`).

---

## Task 1: Sampler script (TDD)

**Files:**
- Create: `scripts/sample_cangjie_test.py`
- Create: `scripts/test_sample_cangjie_test.py`

- [ ] **Step 1: Write the failing test**

Create `scripts/test_sample_cangjie_test.py`:

```python
#!/usr/bin/env python3
import os
import tempfile
import unittest

from sample_cangjie_test import select


def _touch(path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w"):
        pass


class TestSelect(unittest.TestCase):
    def setUp(self):
        self.root = tempfile.mkdtemp()
        r = self.root
        # Full-syntax dir: all .cj taken verbatim.
        _touch(os.path.join(r, "HLT/API/syntax/a.cj"))
        _touch(os.path.join(r, "HLT/API/syntax/sub/b.cj"))
        # Stratum HLT/compiler: 10 files -> 5% = 0 -> max(1,0) = 1 sample.
        for i in range(10):
            _touch(os.path.join(r, "HLT/compiler/f%d.cj" % i))
        # Stratum LLT/compiler: 40 files -> 5% = 2 samples.
        for i in range(40):
            _touch(os.path.join(r, "LLT/compiler/g%d.cj" % i))
        # Non-.cj is ignored.
        _touch(os.path.join(r, "HLT/compiler/ignore.txt"))
        # Unknown top-level dir is ignored.
        _touch(os.path.join(r, "Other/x.cj"))

    def test_full_dir_files_all_selected(self):
        sel = select(self.root)
        self.assertIn("HLT/API/syntax/a.cj", sel)
        self.assertIn("HLT/API/syntax/sub/b.cj", sel)

    def test_stratum_sample_size_min_one(self):
        sel = select(self.root, rate=0.05, cap=300)
        hlt = [p for p in sel if p.startswith("HLT/compiler/")]
        llt = [p for p in sel if p.startswith("LLT/compiler/")]
        self.assertEqual(len(hlt), 1)   # 10*0.05=0 -> max(1)=1
        self.assertEqual(len(llt), 2)   # 40*0.05=2

    def test_cap_applied(self):
        # rate high enough that cap binds: 10 files, cap=3 -> 3
        sel = select(self.root, rate=1.0, cap=3)
        hlt = [p for p in sel if p.startswith("HLT/compiler/")]
        self.assertEqual(len(hlt), 3)

    def test_deterministic_with_seed(self):
        a = select(self.root, seed=42)
        b = select(self.root, seed=42)
        self.assertEqual(a, b)
        c = select(self.root, seed=7)
        self.assertNotEqual(a, c)

    def test_non_cj_ignored(self):
        sel = select(self.root)
        self.assertFalse(any(p.endswith(".txt") for p in sel))

    def test_unknown_dirs_ignored(self):
        sel = select(self.root)
        self.assertFalse(any(p.startswith("Other/") for p in sel))


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 -m unittest scripts.test_sample_cangjie_test -v`
Expected: FAIL with `ModuleNotFoundError: No module named 'sample_cangjie_test'` (the sampler does not exist yet).

- [ ] **Step 3: Write minimal implementation**

Create `scripts/sample_cangjie_test.py`:

```python
#!/usr/bin/env python3
"""Reproducible stratified sampler for the cangjie_test corpus.

Selects which `.cj` files to vendor into test/sources/cangjie_test/:

* Full — every `.cj` under SYNTAX_FULL_DIRS (syntax-focused, ~3.5k files).
* Sampled — RATE of each top-level stratum, capped at CAP, drawn with a
  fixed SEED so the manifest is reproducible across runs.

Emits the manifest (one selected path per line, relative to the testsuites
root) to stdout. --output writes to a file; --vendor DIR copies the selected
files into DIR, preserving their testsuites/... relative paths.
"""
import argparse
import os
import random
import shutil
import sys

DEFAULT_ROOT = os.path.expanduser("~/newrepos/main/cangjie_test/testsuites")

# Directories under testsuites/ taken in full (every .cj file).
SYNTAX_FULL_DIRS = [
    "HLT/API/syntax",
    "HLT/regression",
    "LLT/compiler/Parser",
    "LLT/compiler/Lexer",
    "LLT/compiler/Diagnose",
]

# Top-level strata (testsuites/<stratum>) sampled at RATE, capped at CAP.
STRATA = [
    "HLT/compiler",
    "LLT/compiler",
    "HLT/Tools",
    "HLT/API",
    "LLT/Tools",
    "LLT/API",
    "HLT/Runtime",
    "LLT/Runtime",
]

SEED = 42
RATE = 0.05
CAP = 300


def _is_full(rel, full_dirs):
    """True if rel (POSIX, relative to testsuites root) is under a full dir."""
    for d in full_dirs:
        if rel == d or rel.startswith(d + "/"):
            return True
    return False


def _stratum_of(rel, strata):
    """Return the matching stratum prefix (first two components) or None."""
    parts = rel.split("/")
    if len(parts) >= 2:
        prefix = "/".join(parts[:2])
        return prefix if prefix in strata else None
    return None


def select(root, seed=SEED, rate=RATE, cap=CAP,
           full_dirs=SYNTAX_FULL_DIRS, strata=STRATA):
    """Return sorted list of selected POSIX relpaths (relative to root).

    Combines the full-syntax set with a stratified sample of the remainder.
    """
    full = []
    by_stratum = {s: [] for s in strata}
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames.sort()
        for fn in sorted(filenames):
            if not fn.endswith(".cj"):
                continue
            rel = os.path.relpath(
                os.path.join(dirpath, fn), root).replace(os.sep, "/")
            if _is_full(rel, full_dirs):
                full.append(rel)
            else:
                s = _stratum_of(rel, strata)
                if s is not None:
                    by_stratum[s].append(rel)
    rng = random.Random(seed)
    sampled = []
    for s in strata:
        pool = sorted(by_stratum[s])
        n = min(cap, max(1, int(len(pool) * rate))) if pool else 0
        sampled.extend(rng.sample(pool, n) if n else [])
    return sorted(set(full) | set(sampled))


def vendor(root, dest, selected):
    """Copy each selected rel path from root into dest, preserving structure."""
    copied = 0
    for rel in selected:
        src = os.path.join(root, rel)
        dst = os.path.join(dest, rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy2(src, dst)
        copied += 1
    return copied


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--root", default=DEFAULT_ROOT,
                    help="testsuites root (default: %(default)s)")
    ap.add_argument("--output", default="-",
                    help="manifest output path, or '-' for stdout (default: stdout)")
    ap.add_argument("--vendor", metavar="DIR",
                    help="also copy selected files into DIR, preserving paths")
    ap.add_argument("--seed", type=int, default=SEED)
    ap.add_argument("--rate", type=float, default=RATE)
    ap.add_argument("--cap", type=int, default=CAP)
    args = ap.parse_args(argv)
    if not os.path.isdir(args.root):
        sys.exit("error: root not found: %s" % args.root)

    selected = select(args.root, args.seed, args.rate, args.cap)

    if args.vendor:
        if not os.path.isdir(args.vendor):
            os.makedirs(args.vendor, exist_ok=True)
        n = vendor(args.root, args.vendor, selected)
        print("vendored %d files into %s" % (n, args.vendor), file=sys.stderr)

    out = sys.stdout if args.output == "-" else open(args.output, "w")
    try:
        for rel in selected:
            out.write(rel + "\n")
    finally:
        if out is not sys.stdout:
            out.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

- [ ] **Step 4: Run test to verify it passes**

Run: `python3 -m unittest scripts.test_sample_cangjie_test -v`
Expected: PASS — all 6 tests ok.

- [ ] **Step 5: Smoke-test the CLI against the real tree**

Run:
```sh
python3 scripts/sample_cangjie_test.py --output /tmp/cangjie_manifest.txt
wc -l /tmp/cangjie_manifest.txt
```
Expected: manifest line count = **5250** (3500 full syntax-focused + 1750 stratified sample: only `HLT/compiler`, `LLT/compiler`, `HLT/Tools`, `HLT/API` hit the 300 cap; the other four sample below it — `LLT/Tools`=261, `LLT/API`=202, `HLT/Runtime`=75, `LLT/Runtime`=12). Paths are sorted alphabetically, so the first lines are `HLT/API/Regression/...` (capital `R` sorts before lowercase `s` in `HLT/API/syntax/`).

- [ ] **Step 6: Commit**

```sh
git add scripts/sample_cangjie_test.py scripts/test_sample_cangjie_test.py
git commit -m "feat: add reproducible cangjie_test corpus sampler"
```

---

## Task 2: Wire cangjie_test into golden.py DEFAULT_ROOTS

**Files:**
- Modify: `scripts/golden.py:60-63`

- [ ] **Step 1: Update DEFAULT_ROOTS**

In `scripts/golden.py`, change the `DEFAULT_ROOTS` block from:

```python
DEFAULT_ROOTS = [
    os.path.join(DEFAULT_BASE, "cangjie_runtime", "stdlib"),
    os.path.join(DEFAULT_BASE, "cangjie_stdx"),
]
```

to:

```python
DEFAULT_ROOTS = [
    os.path.join(DEFAULT_BASE, "cangjie_runtime", "stdlib"),
    os.path.join(DEFAULT_BASE, "cangjie_stdx"),
    os.path.join(DEFAULT_BASE, "cangjie_test"),
]
```

- [ ] **Step 2: Create the (empty) new root so discover_sources doesn't exit**

`golden.py`'s `discover_sources` calls `sys.exit` if a root is missing on disk.
Create the dir now (it is filled at Task 5):

```sh
mkdir -p test/sources/cangjie_test
```

- [ ] **Step 3: Verify no break against existing goldens**

Run:
```sh
python3 scripts/golden.py --ci 2>&1 | tail -3
```
Expected: summary line `... | 0 REGRESSION ...`. The new `cangjie_test` root
exists but is empty, so it contributes 0 files; the existing `cangjie_runtime`
and `cangjie_stdx` goldens still verify OK (nothing else changed). Exit code 0.

- [ ] **Step 4: Commit**

```sh
git add scripts/golden.py
git commit -m "feat: include cangjie_test in golden DEFAULT_ROOTS"
```

---

## Task 3: Document the vendored corpus in test/sources/README.md

**Files:**
- Modify: `test/sources/README.md`

- [ ] **Step 1: Add the table row + license note**

In `test/sources/README.md`, extend the table and add a license paragraph. Replace the existing table block:

```markdown
| Path                        | Upstream                                        | Pinned commit |
|-----------------------------|-------------------------------------------------|---------------|
| `cangjie_runtime/stdlib/`   | https://gitcode.com/Cangjie/cangjie_runtime | `6761305f`    |
| `cangjie_stdx/`             | https://gitcode.com/Cangjie/cangjie_stdx    | `9581a10`     |
```

with:

```markdown
| Path                        | Upstream                                        | Pinned commit |
|-----------------------------|-------------------------------------------------|---------------|
| `cangjie_runtime/stdlib/`   | https://gitcode.com/Cangjie/cangjie_runtime | `6761305f`    |
| `cangjie_stdx/`             | https://gitcode.com/Cangjie/cangjie_stdx    | `9581a10`     |
| `cangjie_test/`             | local `~/newrepos/main/cangjie_test`        | sampled       |
```

```markdown
The `cangjie_test/` subset is generated by `scripts/sample_cangjie_test.py`
(seed 42, 5% per stratum capped at 300; full syntax-focused dirs). To refresh
the sample and re-vendor:

```sh
python3 scripts/sample_cangjie_test.py --vendor test/sources/cangjie_test
make golden   # record / rebase goldens for the vendored files
```

`cangjie_test/` sources are Apache-2.0 with Runtime Library Exception
(see https://cangjie-lang.cn/pages/LICENSE).
```

- [ ] **Step 2: Commit**

```sh
git add test/sources/README.md
git commit -m "docs: document cangjie_test vendored corpus"
```

---

## Task 4: Pre-flight — clean cache + regenerate parser

**Files:** none (environment state; no commit).

- [ ] **Step 1: Clear the tree-sitter parser cache**

Run:
```sh
rm -rf ~/.cache/tree-sitter/lib ~/.cache/tree-sitter/lock
```
Expected: no output; the two dirs are removed so no stale compiled parser is reused.

- [ ] **Step 2: Regenerate the parser from grammar.js**

Run:
```sh
tree-sitter generate
```
Expected: no output (or a short "Generating..." line); `src/grammar.json` and `src/parser.c` are rewritten with a fresh mtime. Verify with:
```sh
ls -la src/grammar.json src/parser.c
```
Expected: both files exist, mtimes are now.

- [ ] **Step 3: Smoke-verify the parser + CLI pin**

Run:
```sh
tree-sitter --version
tree-sitter parse --quiet test/recovery/01_missing_terminator.cj >/dev/null 2>&1; echo "parse exit: $?"
```
Expected: `tree-sitter 0.25.x` (on the pinned `0.25` line — `golden.py` will reject anything else when Task 6 runs); `parse exit: 0` (a fresh parse runs against the regenerated parser).

---

## Task 5: Vendor the corpus into test/sources/cangjie_test/

**Files:**
- Create: `test/sources/cangjie_test/**/*.cj`

- [ ] **Step 1: Run the sampler to vendor the files**

Run from repo root:
```sh
python3 scripts/sample_cangjie_test.py \
  --vendor test/sources/cangjie_test \
  --output test/sources/cangjie_test/SAMPLE_MANIFEST.txt
```
Expected: stderr line `vendored 5250 files into test/sources/cangjie_test`.

- [ ] **Step 2: Verify the vendored tree**

Run:
```sh
find test/sources/cangjie_test -name '*.cj' | wc -l
find test/sources/cangjie_test -name '*.cj' | grep -v '/HLT/API/syntax/' | grep -v '/HLT/regression/' | grep -v '/LLT/compiler/Parser/' | grep -v '/LLT/compiler/Lexer/' | grep -v '/LLT/compiler/Diagnose/' | wc -l
```
Expected: first count = **5250** (total vendored). Second count = **1750** (the stratified sample from non-syntax dirs).

- [ ] **Step 3: Commit the vendored sources**

```sh
git add test/sources/cangjie_test
git commit -m "feat: vendor cangjie_test corpus (sample + syntax-focused)"
```

Expected commit contains 5250 new `.cj` files + `SAMPLE_MANIFEST.txt`.

---

## Task 6: Record golden snapshots

**Files:**
- Create: `test/golden/cangjie_test/**/*.cj.golden.gz`

- [ ] **Step 1: Run the golden harness (records NEW, verifies existing)**

Run from repo root:
```sh
make golden 2>&1 | tail -5
```
Expected: summary line containing `... | 5250 new | 0 REGRESSION | error nodes in N files ...`. The first run records a golden for every vendored file (all NEW). Exit 0 (no regressions, since there are no prior goldens to differ from).

Note: this takes a few minutes (5250 files, parallelized by `golden.py --jobs`).

- [ ] **Step 2: Verify goldens were written**

Run:
```sh
find test/golden/cangjie_test -name '*.golden.gz' | wc -l
```
Expected: count = **5250**, matching the vendored file count.

- [ ] **Step 3: Commit the goldens**

```sh
git add test/golden/cangjie_test
git commit -m "feat: record goldens for cangjie_test corpus"
```

Expected commit contains 5250 new `.golden.gz` files.

---

## Task 7: Classification report (positive vs negative)

**Files:**
- Create: `test/sources/cangjie_test/CLASSIFICATION.txt`

- [ ] **Step 1: Generate the classification report**

Run:
```sh
python3 scripts/golden.py --list-errors cangjie_test \
  | tee test/sources/cangjie_test/CLASSIFICATION.txt
```
Expected: stdout lists `ERRORS <count>  cangjie_test/...` lines for every file whose parse has ERROR/MISSING nodes (the negatives), sorted by error count descending. Files not listed are positives (0 error nodes).

- [ ] **Step 2: Sanity-check the split**

Run:
```sh
neg=$(grep -c '^ERRORS' test/sources/cangjie_test/CLASSIFICATION.txt)
tot=$(find test/sources/cangjie_test -name '*.cj' | wc -l)
echo "negatives: $neg / total: $tot"
```
Expected: `negatives: <count> / total: 5250`. Record these numbers — they are the initial classification (negatives = files the grammar currently can't parse cleanly; some are genuine syntax-error tests, some are grammar gaps).

- [ ] **Step 3: Commit the report**

```sh
git add test/sources/cangjie_test/CLASSIFICATION.txt
git commit -m "docs: record initial cangjie_test classification (positive/negative)"
```

---

## Done

The corpus is now vendored, snapshotted, and classified. Subsequent runs of `make golden-ci` verify nothing regresses; `make golden` rebases goldens when the grammar or upstream sources change; `--fail-on-error N` can be added to CI to gate on error-count growth once a baseline is agreed.
