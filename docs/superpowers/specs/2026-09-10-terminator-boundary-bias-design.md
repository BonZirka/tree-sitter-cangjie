# Design: Terminator route normalization + boundary bias (Approach B)

Date: 2026-09-10
Status: approved for planning
Baseline: commit 88017dd0 (6,017 ok / 0 REGRESSION / 1,073 error nodes in 777 files / 20 declared conflicts)

## Motivation

User goals: **parse speed** and **maintainability**. Two empirical studies motivated this design:

1. **`;`-substitution experiment** (termprobe.py + cjcprobe.py): inserting a literal `;`
   before every scanner-emitted TERMINATOR produced identical parses on 179/200 sampled
   corpus files, *better* parses on 2 (five residual `None<V>` glue sites in
   concurrent_hash_map.cj resolved to clean declarations; a `@PropGetter` macro-attach
   ERROR resolved), and the real compiler (`cjc` 1.2.0) accepted the substitution in
   **19/19** cross-tabulated files. Conclusion: the ties the scanner leaves open should
   resolve to the statement-boundary reading, and doing so is legal Cangjie.

2. **Precedent survey** (grammar sources of tree-sitter javascript/kotlin/scala/go/python):
   every grammar that models statement separation uses dual-identity newlines
   (`\n` in extras **and** an external terminator token in slots) with next-line-peek
   suppression and no lookbehind. Single-identity newlines (Go) exist only by dropping
   statement boundaries from the tree. Kotlin's grammar is nearly identical to ours.
   Consequence: dual identity is mainstream and stays; approaches A (char-lookbehind —
   provably blind to `a >\nb` vs `a<T>\n` ) and C (single identity — anti-precedent,
   editor-unfriendly) are rejected.

## Root mechanism (why the glue survives)

`\n` has dual identity: matched by `/\s/` extras (consumed silently by any GLR branch
not demanding a terminator) and emitted as the external TERMINATOR (consumed by
boundary states). Two branches disagreeing about `None<V>` crossing a newline both
survive — one via extras, one via token — and the tie resolves late by tree
comparison, picking the glue. A literal `;` cannot be swallowed by extras, so the
glue branch must either consume it at a boundary state (ending the expression) or
die. B2 transfers that outcome into the grammar without touching token flow.

## Change 1 — B1: terminator route normalization

- Audit every `terminator($)` / `token(';')` consumption site in grammar.js.
- For each boundary shape (`;` after import, `;` between top-level items, `;` after
  package declaration, blank-line runs), run `cjc` to establish legality.
- Normalize so exactly one route consumes each position, keeping:
  - rule-internal `terminator($)` as the standard idiom;
  - `token(';')` slots at top level — **never** `terminator($)` there: making the
    external TERMINATOR valid at top-level item boundaries kills the
    macro-prefix→`import` attachment (E1 experiment, reverted; the attach branch
    needs the newline to remain an extra until `IMPORT`).
- Expected outcome: the `import std.random.*;` absorption tie disappears; grammar.js
  has one consumption idiom per position.
- Open decision (arbitrated by the audit): for `;` immediately after the last import —
  the one position where the import-internal route and the top-level slot overlap —
  either (a) imports keep `terminator($)` and the tie is killed because cjc proves
  `;` between top-level items illegal (top-level slot removed entirely), or
  (b) the slot stays and the overlap is biased. Both keep the E1 constraint; the
  audit decides.

## Change 2 — B2: targeted boundary bias

- Add negative `prec.dynamic` to the empirically glue-prone rules only:
  `binary_expression` first; `assignment_expression` and `macro_expression` only if
  the corpus shows independent glue ties for them.
- Mechanics: normal parses never tie, so the bias is inert on `a + b`. It matters
  only when a complete-statement reading and a glued-continuation reading both
  survive — the `None<V>\nvar` class — and tips the survivor to the boundary reading.
- **Explicitly rejected**: a blanket `prec.dynamic` on flat-list items. It would flip
  the `foo()\n{ lambda }` tie to "two statements" and break the
  trailing-lambda-across-newline contract (probe k4.cj). The scanner's `{`-suppression
  keeps that tie alive by design; B2 must not fight it.

## Validation gates

Per step (`python3 scripts/tsbuild.py` for all generation):

1. `tree-sitter generate` warning-free; conflict count does not increase.
2. `tree-sitter test`: 16/16.
3. `python3 scripts/golden.py --ci --jobs 8`: 6,017 ok, 0 REGRESSION.
4. Probe suite green: k4 (trailing lambda across newline), att1–att3 (macro attach),
   b9, ue1–ue3 (containment), mx, rune1.
5. Error nodes ≤ 1,073; tree churn confined to tied files (expected: tens, not
   thousands of goldens).

## Success criteria

- The 5 concurrent_hash_map glue sites parse as clean `variable_declaration`s.
- PropGetterOrSetter_01 macro attaches (no ERROR).
- k4 contract preserved; all other probes unchanged.
- Parse speed neutral or better on the top-20 bench sweep (time_one.sh).

## Out of scope

- Scanner changes (scan_terminator, suppression logic).
- Extras changes (dual-identity newlines stay, per precedent).
- Single-identity newlines (approach C, rejected).
- Conflict-count reduction beyond what falls out naturally.
