# Experiment: arbitrary expressions in macro bodies (`@A[expr](expr)`)

Prototype change: `_macro_body_item` gains `$._expression`, and the scanner
declines raw-content scanning wherever an expression token can start
(`scan_macro_body_content` now only produces content for whitespace/newline
runs when no nested openers are pending).

## Measurements (6k-file golden corpus, jobs 8, tree-sitter CLI 0.25.10)

| metric | baseline | experiment | delta |
|---|---|---|---|
| STATE_COUNT | 5,775 | 13,444 | **2.33x** |
| LARGE_STATE_COUNT | 2,511 | 7,920 | 3.15x |
| SYMBOL_COUNT | 369 | 369 | — |
| generate+build (user) | ~1s | 17.0s | 17x |
| golden run wall | 50.3s | 70.1s | **+39%** |
| golden run user | 285s | 422s | +48% |
| corpus suite (75 tests) | 75/75, 4428 B/ms | 75/75, 4644 B/ms | equal |
| golden regressions | 0 | **1** | — |
| error nodes | 8,704 / 815 files | 8,703 / 814 files | -1 (improved) |

## Notes

- The single "regression" is an improvement:
  `LLT/.../lex_illegal_symbol_in_string_interpolation/case1.cj` previously
  recovered as one large ERROR blob; it now parses a real `main_definition`.
- Existing raw-body macros (`@Deprecated("x")`, `@Optics(...)`) parse
  unchanged (raw content still wins when both readings complete); the
  corpus suite passes with identical trees.
- Mixed bodies resolve raw-first today (`@A[x + 1]` → one `macro_raw_token`
  covering `x + 1`). Making expressions WIN over raw content needs
  precedence work — the state-count and speed numbers above already
  include the full expression machinery, so tuning precedence will not
  change them materially.
- A scanner-decline variant was tried and **reverted**: declining raw
  content at expression-token starts broke 1225 corpus files
  (attr bodies like `@Deprecated[message: "..."]` depend on the raw
  swallow for the `name:` form, and whitespace-entry content swallowed
  operators mid-expression, killing the expression readings it was
  meant to enable).
- Verdict: the state doubling is real but the corpus cost is ~40%; both
  parse time and memory stay comfortably usable. The design is viable for
  coloring macro bodies as real code.

## Scope of the change

- `grammar.js`: `_macro_body_item += $._expression`; conflicts += two
  entries (`_literal`/`_macro_body_item`, `macro_expression`).
- `src/scanner.c`: `scan_macro_body_content` declines outside
  whitespace/newline when no nested openers are pending.
- `src/parser.c` etc.: regenerated.
