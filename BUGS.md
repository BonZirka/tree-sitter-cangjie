# Known bugs (0.1.0 publishing preparations)

Grammar and scanner are frozen for the 0.1.0 release: bugs found during
test expansion are **documented here, not fixed**. Each entry lists the
repro, the observed and expected behavior, and the impact.

---

## B1. Macro-expression body delimiters are uncolored

- **Repro**: highlight `@Deprecated("x")` (any macro expression with a
  parenthesized body, e.g. `@Optics({...})`).
- **Observed**: the `@` sigil is `@punctuation.special`, the macro name is
  `@function.macro`, the string argument colors normally — but the `(` and
  `)` delimiters of the `macro_call_body` receive **no capture** and render
  bare.
- **Expected**: the body delimiters should carry a punctuation-ish capture
  (e.g. `@punctuation.special` to match the sigil), or at minimum the same
  treatment as the quote DSL delimiters, which are aliased named nodes
  (`quote_close`, `quote_paren`) precisely so queries can color them.
- **Root cause (for the future fix)**: `macro_call_body` is a single node
  whose delimiters are anonymous tokens inside the rule — unlike the quote
  DSL, they were never aliased into named nodes, so queries cannot target
  them.
- **Impact**: cosmetic (highlighting only); parsing is correct.
- **Status**: documented, not fixed (0.1.0 freeze).

---

## B2. Macro expressions fail to parse in some expression positions

- **Repro** (minimal):
  ```cangjie
  f(@f(1))              // ERROR
  show(@f(1))           // ERROR
  let s = "${@f(1)}"    // ERROR
  ```
- **Works** (for comparison):
  ```cangjie
  @f(1)                          // statement level
  let x = @f(1)                  // initializer
  let y = @f(1) + 2              // binary operand
  let a = [1].map(@f(1))         // method-call argument — parses fully
  ```
- **Observed**: with a *bare-identifier callee* (`f(@f(1))`) or inside a
  string interpolation (`"${@f(1)}"`), the `@` sigil cannot be lexed and
  the parse recovers with ERROR nodes (the whole call/interpolation is
  swallowed). Real-world trigger: showcase-optics/main.cj uses
  `show("...", @f(...))` and `"${@f(...)}"`, producing one large ERROR
  spanning from the first such `main()` statement to EOF.
- **Expected**: `macro_expression` is part of `_primary_expression`
  (grammar.js), so `@name(...)` should parse in every expression position.
- **Root cause candidates (for the future fix)**:
  1. String interpolation: the scanner's `CTX_INTERP` dispatch branch offers
     only brace/string/terminator tokens — `MACRO_AT` is never produced
     inside `${ ... }`.
  2. Bare-callee arguments: the LALR state after a bare call's `(` differs
     from the method-call state (the `_call_tail` lambda fork) and in that
     state the macro reading loses; `prec.dynamic(-1)` on
     `macro_expression` may make it abandon the race entirely.
- **Impact**: real code that passes macro calls as arguments or embeds them
  in interpolations fails to parse; highlighting of the affected region
  breaks with it.
- **Status**: documented, not fixed (0.1.0 freeze).
