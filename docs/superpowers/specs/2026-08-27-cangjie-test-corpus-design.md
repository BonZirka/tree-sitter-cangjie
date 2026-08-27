# Extend test corpus from `cangjie_test`

**Date:** 2026-08-27
**Status:** Approved
**Approach:** A — Unified golden harness

## Goal

Grow the tree-sitter-cangjie test corpus by vendoring Cangjie `.cj` files from
`~/newrepos/main/cangjie_test`, classifying each as syntactically-correct
(positive) or syntax-error (negative) via a tree-sitter parse, and recording
golden snapshots for all of them through the existing `scripts/golden.py`
harness.

## Constraints

- **Freshly built tree-sitter.** Regenerate the parser from `grammar.js` and
  rebuild before recording any golden, so snapshots reflect the current grammar.
- **Clean tree-sitter cache before creating the corpus.** Remove
  `~/.cache/tree-sitter/{lib,lock}` so no stale compiled parser is reused.
- The `golden.py` pinned-CLI check (`PINNED_CLI = "0.25"`, installed CLI
  `0.25.10`) must pass; do not use `--any-cli`.

## Scope

### Full — syntax-focused (~3.5k files)

Every `.cj` file under these directories is taken verbatim:

| Path                                  | Files |
|---------------------------------------|-------|
| `testsuites/HLT/API/syntax/`          | 1,061 |
| `testsuites/HLT/regression/`          |   973 |
| `testsuites/LLT/compiler/Parser/`     |       |
| `testsuites/LLT/compiler/Lexer/`      |   604 (Parser + Lexer) |
| `testsuites/LLT/compiler/Diagnose/`   |   862 |

### Stratified sample from the rest (~93k files)

A reproducible sample over the 8 top-level non-syntax buckets, drawn by a
committed script `scripts/sample_cangjie_test.py`:

- 5% per stratum, capped at 300/stratum, deterministic seed `42`.
- Strata (by `testsuites/<bucket>`): `HLT/compiler` (41.7k), `LLT/compiler`
  (20.1k), `HLT/Tools` (10.7k), `HLT/API` (9.7k), `LLT/Tools` (5.2k),
  `LLT/API` (4.1k), `HLT/Runtime` (1.5k), `LLT/Runtime` (255).
- Actual sample: 1750 (only four strata hit the 300 cap; the rest sample below
  it). Combined with the 3500 full-syntax files, the corpus is **5250 files**.
- The script writes the selected relative paths to a manifest so the sample can
  be re-vendored identically after an upstream refresh.

## Classification

By tree-sitter parse, automated inside `golden.py`:

- **Positive** = parse produces 0 `ERROR`/`MISSING` nodes.
- **Negative** = parse contains `(ERROR ...)` / `(MISSING ...)` nodes.

No separate classifier binary: `golden.py --list-errors cangjie_test` prints
every file whose parse has error nodes plus the per-file count, giving the
negative list; every other file is positive.

## Output layout

- Vendored into `test/sources/cangjie_test/`, preserving each file's
  `testsuites/...` relative path, so golden keys (relative to
  `test/sources/`) are `cangjie_test/<bucket>/.../<name>.cj`.
- This matches the existing convention (`cangjie_runtime/...`,
  `cangjie_stdx/...`).
- Only `*.cj` files are vendored (skip `*.cj.macrocall`, configs, `testlist`).

## Wiring (do this before recording goldens)

- Add `test/sources/cangjie_test` to `DEFAULT_ROOTS` in `scripts/golden.py` so
  `make golden` / `make golden-ci` include the new corpus by default. (This must
  precede the golden-recording step or the new dir is not scanned.)
- Add `scripts/sample_cangjie_test.py` (the reproducible sampler).
- Update `test/sources/README.md`: new row for `cangjie_test/` (upstream path,
  seed/ratios), license note, refresh instructions.

## Workflow

1. **Pre-flight**
   - `rm -rf ~/.cache/tree-sitter/lib ~/.cache/tree-sitter/lock`
   - `tree-sitter generate` (rebuild `src/grammar.json` + `src/parser.c`)
   - Smoke-verify: parse one file; confirm `golden.py` CLI check passes.
2. **Wiring** — apply the `DEFAULT_ROOTS` change, add the sampler script, update
   the README (see *Wiring* above).
3. **Sample** — run `scripts/sample_cangjie_test.py` to emit the manifest.
4. **Vendor** — copy the full syntax-focused set + manifest-listed sample into
   `test/sources/cangjie_test/` (same relative paths).
5. **Record goldens** — `make golden` (the updated `DEFAULT_ROOTS` now scans the
   new dir; new files are recorded as NEW, existing goldens are verified).
6. **Report** — `python3 scripts/golden.py --list-errors cangjie_test` to
   produce the positive/negative classification summary.

## Regression behavior (unchanged from existing harness)

- New file → golden created (NEW).
- Upstream source changed → golden rebased (REBASED).
- Dump differs, user decides per file (accept/keep as regression).
- Error-count increase → flagged `ERROR-REGRESSION`; `--fail-on-error N`
  fails the run when more than N files contain error nodes.

## Out of scope

- The existing `test/recovery/` directory is untouched (per user direction).
- No tree-sitter native `test/corpus/` (`=== ===`) format is introduced.
- No per-negative expected-ERROR-shape assertions; only error *presence/count*
  is tracked (keeps negatives stable across grammar edits).
