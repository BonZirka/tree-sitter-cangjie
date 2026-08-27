# Lexer & Parser Rework — Design

Date: 2026-09-08
Status: approved (design); implementation plan pending

## Goals

1. Improve error recovery
2. Simplify the grammar
3. Increase parse speed
4. Reduce ambiguity (fewer conflicts, fewer live GLR versions)

The current state is treated as legacy debt: every mechanism is re-derived
from first principles against reference grammars, not assumed sound.

## Scope

Lexer (scanner.c + token definitions) **and** the coupled parser hot spots
(postfix structure, `atomic_variable`, pattern/arm separation, statement
lists, PREC ladder). A lexer-only rework cannot reach goals 2 and 4: most
conflicts and version-splitting live in the grammar layer.

Node-shape changes, corpus re-goldening, and query updates are accepted
as part of the work (decided during brainstorming).

## Reference survey

| Grammar | conflicts | externals | scanner.c | relevant technique |
|---|---|---|---|---|
| tree-sitter-scala (official) | 72 | ~25 | 2046 lines | layout stack; **all strings external**; external hard keywords (`else`, `catch`, …) so `/*` does not occupy a parse-table column ("costs about 0.6 MiB of parser.c"); `POSTFIX_OP` token; postfix on restricted bases |
| tree-sitter-kotlin (fwcd) | 51 | 10 | 979 lines | `_automatic_semicolon` ASI engine driven by a bracket-context stack; targeted external disambiguators (`_import_dot`, `_by_delegation_hint`) instead of conflicts |
| tree-sitter-haskell | ~15 | ~30 | modular `grammar/` dir | `cmd`/`cond`/`phantom` external token classes; scanner owns whitespace (zero extras); conflicts.js documents which conflicts were "turned into scanner lookahead"; `error_sentinel` (we adopted this already) |
| tree-sitter-swift | 2 | 0 | none | brace structure carries everything; extras `/\s+/` |
| ours (before) | 19 | 8 | 401 lines | accreting ad-hoc suppression rules |

Chosen model: **Kotlin/Scala ASI** (newlines stay extras, scanner = principled
statement-boundary engine). Haskell's single-authority model (zero extras,
newline as explicit external token in rules) was rejected: for a C-family
syntax every newline-legal position needs explicit grammar placement — a
large, fragile surface. Swift's no-scanner model was rejected: it loses
statement-boundary precision and coarsens recovery.

## Debt catalog (before)

1. Scanner boundary logic is ad-hoc: seven hand-patched suppressions
   (`.`, `?`, `|`, `&`, `~`, `else`, `{`), each originally a bugfix; no
   principled model.
2. Strings use four mechanisms: `token.immediate` chunks (line strings),
   regex chunks (multi-line), external raw strings, external unterminated
   tails — plus permissive `escape_sequence = /\\./`.
3. Newlines handled twice: `/\s/` extras (per char) *and* `_TERMINATOR`;
   where both are valid, every newline spawns two GLR versions.
4. Raw-string scanner state (`in_string`, `delimiter_length`, `quote`) is
   global, not GLR-version-local — latent bug class.
5. `postfix_expression = seq($._expression, suffix)` over ANY expression —
   the ambiguity engine (`x < y > (z)` cross-products; chains nest
   structurally N ways).
6. `atomic_variable` (identifier + optional type_arguments) wraps every
   identifier reference — tree noise and hub of 4 of 19 conflicts fighting
   pattern-vs-expression duality.
7. `match_case_body: case $._expression =>` forces 5 conflicts
   (`wildcard_pattern/match_case_body`, `_pattern/atomic_variable`,
   `enum_pattern/atomic_variable`, `_constant_pattern/_atomic_expression`,
   `_name/_var_binding_pattern`).
8. `_expression_or_declarations` left-recursive twin-slot statement list
   with terminator separators (blocks, lambdas, match arms).
9. PREC soup: negatives (`INIT:-1`, `RESERVED_ID:-3`) and duplicates
   (`TOKEN:1 = PIPE:1`, `COMMENT:0 = ASSIGN:0`); `MARCO_CALL` typo.
10. Monolithic 1007-line grammar.js.
11. Macro bodies: bare `@` inside a body is an error (must be escaped,
    verified: `@M1[@M2[x]]` → 2 errors, `@M1[a \@ b]` → clean);
    `macro_raw_token` regex excludes `@`/quotes/brackets — fragile.
    NOTE: there is **no `@` interpolation**; the only interpolation holes
    are `$name`/`$(expr)` in `quote()` bodies and `${…}` in strings.

## Design — lexer core (chunk 1)

### 1. Scanner architecture (ASI engine)

```
scan():
  1. skip spaces/tabs/CR (scanner peeks past them for continuation decisions)
  2. if error-recovery state → sentinel handling, bail
  3. if crossing newline(s):
       inside bracket context (stack)      → no terminator
       next real token ∈ continuation set  → no terminator
       else                                → emit _TERMINATOR (consumes the newline run)
  4. dispatch on valid_symbols: continuation keywords, strings, quotes, comments
```

Whitespace/newlines remain extras (model A — Kotlin/Scala keep them too);
the extras regex is upgraded from `/\s/` (one char per extra token) to
`/\s+/` (one token per whitespace run, fewer round trips). The scanner
additionally skips spaces/tabs at scan start so its continuation decisions
see past them. The newline extras-vs-`_TERMINATOR` version split is not
eliminated in this model — it is minimized structurally (flattened lists,
postfix restructure) so it stays transient and merging at token boundaries.

- **Bracket-context stack** (`(` `[` `{` push, closers pop; serialized into
  scanner state): replaces the seven ad-hoc suppressions with one data-driven
  continuation check.
- **Continuation suppression stays scanner-side, keywords stay internal**
  (amended during Phase 1): externalizing `else`/`catch`/`finally`/`where` is
  incompatible with stable trees — the scanner skips whitespace, so an
  external keyword shifts its token start (886 diffs in v1), and emitting
  only when sitting on the word never attaches (the internal lexer consumes
  the keyword as an identifier within one lex request, v1.5). Instead,
  `scan_terminator` suppresses terminators via a boundary-checked
  lookahead for the four internal keywords (`word_continues`).
- **GLR-safe state invariant**: every decision is a pure function of
  `valid_symbols`, lookahead, and the serialized stack; document it.
  Fixes debt item 4.

### 2. Strings — one uniform external mechanism

| kind | tokens |
|---|---|
| line `'` `"` | `_line_string_start` / `_line_string_content` / `_line_string_end` |
| multiline `"""` `'''` | `_multiline_string_start` / `_multiline_string_content` / `_multiline_string_end` |
| raw `#"`…"#` | `_raw_string_start` / `_raw_string_content` / `_raw_string_end` |

- Interpolation holes `${…}` are normal grammar rules *between*
  content/middle tokens; the scanner emits `_string_middle` vs `_string_end`
  depending on whether it sees `${` (Scala's `_interpolated_string_middle`
  pattern).
- **Unterminated strings are not a special case**: the scanner emits
  `_line_string_end` only when it actually finds the closing quote before
  the newline; otherwise content runs to the newline and the line-string
  rule completes with `optional(_line_string_end)` — one authority, zero
  ambiguity between the closed and unterminated readings (the closing
  quote and the newline are distinguishable scan outcomes). Multi-line
  strings tolerate EOF the same way. Deletes both `_line_string_tail_*`
  tokens and the `prec(-2)` bare-opener forms.
- `escape_sequence` remains a named token lexed by the internal lexer at
  positions where the scanner ended a content chunk on `\`; bad escapes
  stay visible instead of being swallowed by `/\\./`.

### 3. Quotes & macro bodies (same treatment)

- `quote(…)` bodies: scanner tracks paren/bracket nesting depth (like
  block-comment nesting today) and emits raw content runs as single tokens;
  `$name` / `$(expr)` interpolation stays grammar-visible between content
  tokens (Haskell's `quasiquote_body` precedent).
- Macro-expansion bodies `@M[...]` / `@M(...)`: same nesting-aware content
  tokens, carving out escapes (`\(`, `\)`, `\[`, `\]`, `\@`, `\\`) and
  string/rune literals. No `@` holes, no `$` holes (see debt item 11).
- Deletes in-grammar `macro_raw_token`, `quote_raw_token`, `quote_escape`
  regex fragility; unbalanced brackets inside a body recover at the body
  boundary instead of eating the file.

Deleted from scanner: `_line_string_tail_single`, `_line_string_tail_double`,
the `else`/`{`/`|`/`&` special cases. Deleted from grammar.js: `lineStr`,
`multiLineStr`, `token.immediate` machinery, `inline_expression`'s
terminator soup.

## Design — parser hot spots (chunk 2)

### 4a. Postfix on atoms

```
_expression        = binary | unary | is/as | assignment | postfix
postfix_expression = primary | seq(postfix_expression, suffix)   // left-recursion through the node itself
primary            = atoms | if/match/try/loop/... (control expressions stay expressions)
```

Call/index/field suffixes attach only to primary/postfix chains — removes the
`x < y > (z)` cross-product class and shrinks version counts structurally.

### 4b. Kill `atomic_variable`

Expressions reference `identifier` (+ optional `type_arguments` sibling for
generic calls) directly. `var_binding_pattern` survives only at real binding
sites (patterns, declarations).

### 4c. Pattern/arm separation

Match arms take `$._pattern` (constant-expression patterns stay as
`_constant_pattern`) instead of `case $._expression =>`. Forms are verified
against the corpus and the real compiler (`cjc`) as usual. Expected to
dissolve most of the five pattern conflicts.

### 4d. Statement lists

`_expression_or_declarations` flattened like `translation_unit` /
`_declaration_list` (repeat with optional `;` runs, no terminator separators)
at all four use sites (block, trailing lambda, lambda, match arms). Safe
because the scanner owns newline decisions and `{` suppression.

### 4e. PREC ladder + modifiers

Coherent renumbering; every negative `prec` re-proven against the corpus or
removed; fix the `MARCO_CALL` typo; rework the `modifiers` conflicts.
Target: **19 → ≤8 conflicts**.

## Modularization

Deferred to its own stage (user decision, 2026-09-08): `grammar.js` remains
the single grammar file throughout this rework. After the rework lands, a
separate plan splits it into `grammar/` (`tokens.js`, `literals.js`,
`types.js`, `declarations.js`, `expressions.js`, `patterns.js`, `macros.js`,
`conflicts.js`, `precedences.js`) — a pure mechanical split.

## Migration

Phased landings; each phase ends green:

| Phase | Content | churn |
|---|---|---|
| 1 | ASI engine, generalized terminator suppression (keywords stay internal; done, e4b73e67) | scanner.c rewrite, small grammar edits |
| 2 | Strings + `quote()` + macro bodies externalized | query updates, re-golden |
| 3 | Postfix/atomic_variable restructure | node-type churn, queries, re-golden |
| 4 | Patterns/arms + statement-list flatten + PREC cleanup | re-golden |
| 5 | Extras `/\s+/` upgrade + rewrite docs | none; re-golden only if extras upgrade churns |

(Modularization is a deferred stage with its own plan; see the
Modularization section.)

Per-phase loop: `tree-sitter generate → build → probe suite → full CI (6017
files, `scripts/golden.py --ci --jobs 1`) → audit diffs → accept
(`--update-all`) → benchmark top-20 → commit`.

## Success criteria

- Conflicts: 19 → ≤8 (all remaining documented in conflicts.js style)
- Error files: ≤858, error nodes: ≤6852 (no net regression; expected
  improvement from bounded string/quote/macro-body recovery)
- Speed: no clean-file regression vs the 4.4–6.2 MB/s band; top-20 table
  improved or flat
- scanner.c: every decision documented, state serialized, no ad-hoc
  per-character suppression table
- queries: all five `.scm` files validate and render after each phase
