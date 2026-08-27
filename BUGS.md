# Bug log

Entries found during test expansion. Grammar and scanner were frozen for the
0.1.0 release, so bugs were documented here first and fixed afterwards
(post-freeze). Each entry lists the repro, the root cause, and the fix.

---

## B1. Macro-expression body delimiters are uncolored — FIXED

- **Repro**: highlight `@Deprecated("x")` (any macro expression with a
  parenthesized or bracketed body, e.g. `@Optics({...})`).
- **Observed (before the fix)**: the `@` sigil was `@punctuation.special`
  and the macro name `@function.macro`, but the `(` `)` / `[` `]` delimiters
  of the body received **no capture** and rendered bare.
- **Root cause**: `_macro_input_body` / `_macro_attr_body` used anonymous
  tokens (`$._macro_input_open` etc.) — unlike the quote DSL, they were never
  aliased into named nodes, so queries could not target them.
- **Fix**: the four delimiters are aliased to named nodes
  (`macro_input_open/close`, `macro_attr_open/close`) in grammar.js and
  captured as `@punctuation.special` in highlights.scm — matching the `@`
  sigil so `@Name(...)` reads as one colored unit (per user preference).
  Covered by highlight-test assertions and the expectations script.
- **Status**: fixed (queries + grammar alias; tree shape changed, goldens
  rebased).

---

## B2. Macro expressions fail to parse inside string interpolations — FIXED

- **Repro (minimal)**:
  ```cangjie
  main() { let s = "${@f(1)}" }   // ERROR before the fix
  ```
- **Observed (before the fix)**: inside `${ ... }` the `@` sigil could not be
  lexed and the parse recovered with ERROR nodes swallowing the whole
  interpolation. Real-world trigger: showcase-optics/main.cj
  `show("...", "${@f(...)}")` produced one large ERROR spanning to EOF.
- **Root cause**: the scanner's `CTX_INTERP` dispatch branch offered only
  brace/string/terminator tokens — `MACRO_AT` was never produced inside
  `${ ... }`.
- **Fix**: the `CTX_INTERP`/`CTX_BRACE` branch now dispatches macro body
  opens and `MACRO_AT` (src/scanner.c), so macro expressions parse in
  interpolations exactly like at statement/initializer level.
- **Status**: fixed (scanner change; the corpus `:error` test became a
  positive test, goldens rebased).

---

## B2a. "Macro expression as bare callee argument" — RETRACTED (invalid repro)

- The original B2 repro `f(@f(1))` at **top level** was invalid cangjie: a
  bare call is an *expression statement*, and the top level only admits
  declarations — the parse errors were correct behavior, unrelated to
  macros. Inside function bodies the same shape
  (`main() { f(@f(1)); return 0 }`) always parsed.
- The corpus test was renamed to "bare call statement at top level is not
  cangjie" (`test/corpus/errors.txt`).
