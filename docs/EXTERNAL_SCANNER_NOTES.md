# External Scanner Notes

Rationale, structure, and performance characteristics of `src/scanner.c`.
(Fully rewritten 2026-09 to match the stacked-context scanner; the previous
version of this document described the old 7-token scanner and was stale.)

## Inventory

29 external tokens, 701 lines of C, 10 lexer contexts. All context is a
single explicit stack (`Scanner` struct); serialized state is 67–75 bytes:
stack depth + per-frame kind/param/hash fields, plus a bounded macro-bracket
stack (max 8 frames).

### Token groups

| Tokens | Purpose |
|---|---|
| `_terminator` | ASI: newline as statement terminator, with lookahead suppression (below) |
| `_block_comment_content` | Body of nested `/* ... */` comments (nesting counted in C) |
| `_line_string_*`, `_multiline_string_*` | `"` / `'` and `"""` strings: start/content/end split so `${...}` interpolation can nest arbitrary code |
| `_interp_open/close`, `_brace_open/close` | `${` holes and bare `{` groups inside interpolation (if/lambda bodies surface as raw groups) |
| `_raw_string_*` | `#"..."#` raw strings with `$`-interpolation; delimiter length is stateful (`params2`) — regexes cannot count `#`s |
| `_quote_*` | `quote(...)` macro-argument bodies: raw tokens with `(...)` groups and `$(expr)` interpolations |
| `_macro_at`, `_macro_attr_*`, `_macro_input_*`, `_macro_body_content` | `@Name[...]` / `@Name(...)` macro call bodies as raw token streams with bracket matching |
| `_error_sentinel` | Never emitted; validity probe for error recovery (below) |

## The error sentinel (load-bearing)

The scanner never produces `_error_sentinel`. It is referenced by no grammar
rule, so it is valid in **no** normal parse state — the only time
`valid_symbols[ERROR_SENTINEL]` is true is when the parser is in error
recovery, where tree-sitter marks *all* externals valid. `scan()` therefore
starts with:

```c
if (valid_symbols[ERROR_SENTINEL]) {
    return false;
}
```

so no content token (comment bodies, string bodies, macro bodies) is ever
emitted from an error state. Same pattern as tree-sitter-rust
(`src/scanner.c`, `valid_symbols[ERROR_SENTINEL]` guard).

This is not theoretical. Without the guard, the error version of a failing
parse receives `valid_symbols[_block_comment_content] = true` at an arbitrary
position, `scan_block_comment_content` consumes to `*/`/EOF, and the "blob"
error version races ahead at ~1 cost unit/char — vetoing every localized
repair (`ts_parser__better_version_exists`). Measured on a probe with a
missing `=>` in a match arm:

* before: `skip_token symbol:_block_comment_content, size:20` in the debug
  trace; whole construct swallowed by one `(ERROR [0,0] - [EOF])`
* after: `(ERROR [3,8] - [3,16])` — one line

The full `test/recovery` gate went from 4/12 cascading to 0/12 (7 localized,
5 clean) from this one guard; the four formerly cascading cases were
missing-comma-in-params, two-identifiers-in-a-row, misspelled keyword, and
missing match `=>`.

## Context stack

`scan()` dispatches on the top of an explicit context stack
(`CTX_LINE_STRING`, `CTX_INTERP`, `CTX_QUOTE`, `CTX_MACRO_BODY`, ...). Start
tokens push; end tokens pop. Interpolation holes and quote/macro bodies nest
through the same stack (max depth 32, then silently capped — deeply nested
strings degrade to flat content rather than crashing).

`scan_terminator` implements Cangjie's newline sensitivity: skip trailing
spaces, consume the newline, then peek past blank lines and comments:

* `else` / `catch` / `finally` / `where` on the next line never terminate
  (continuation keywords, like Kotlin's ASI keyword lookahead);
* `.`, `?`, `|`, `&`, `~>` on the next line never terminate
  (operator continuation);
* a next-line `{` suppresses the terminator so it attaches to the pending
  construct (function body, match/lambda brace).

## Comparison with other grammars

| Grammar | external tokens | what they scan |
|---|---|---|
| cangjie (ours) | 29 | strings+interpolation, raw strings, nested comments, quote/macro raw bodies, ASI, error sentinel |
| rust | 11 | string content/close, raw strings, float disambiguation (`1..2` vs `1.f`), doc comment markers, error sentinel |
| kotlin (fwcd) | 10 | ASI engine, multiline comments, string start/end/content, interpolation starts, import dot |
| python, go, java, c, cpp, js | 0–6 | js: template-string pieces; the rest need none |

Honest verdict: ours is the **highest** external-token count of the group —
the opposite of the old document's claim. It is forced by the combination of
`$`-interpolated raw strings, `quote(...)`/`@Name[...]` raw token streams, and
newline sensitivity, each of which drives separate external groups. The cost
is a 29-wide dispatch in every lex call plus a hand-maintained context stack;
the mitigation is that all contexts share one push/pop discipline and the
sentinel keeps error recovery from interacting with them at all.

## Performance

Measured with `tree-sitter parse --time` (CLI 0.25.x), 2026-09:

| Input | Speed |
|---|---|
| normal stdlib file (98 KB, `testGetStaticFunctions_StandardClassType_21_test.cj`) | ~6–8 MB/s |
| error-dense fuzz file (527 KB, `regression_fuzz_0016.cj`) | ~4 MB/s |

The scanner is not the bottleneck: scans are linear over their span and the
serialized state is <100 bytes. Parse time is dominated by the GLR parse
table (~5.8k states; see `STATE_COUNT` in `src/parser.c`) and, on corrupt
files, by error-recovery version races (see `docs/PROBLEMATIC_TEST_CASES.md`
#5 for the residual cost-race cases that live in libtree-sitter constants).

## Possible follow-ups

1. `_TERMINATOR` moves statement-boundary logic into C — invisible to
   grammar readers and queries. Part of it might be absorbable into
   grammar.js with the JS-style internal-newline trick if we ever want to
   shrink the C surface.
2. Nested macro bodies (`@Outer(@Inner(x))` where the inner call opens its
   own body) currently fall back to flat content; the `macro_openers` slot
   holds one frame. Widen it if a corpus case demands it.
3. The whitespace-skip in `scan_quote_open`/`scan_macro_at` spans newlines;
   if a corpus case ever needs `quote`/`@` to be newline-strict, that skip
   must become line-local.
