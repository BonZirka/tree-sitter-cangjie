# Single-file grammar + scala/TS-style expression rewrite

**Date:** 2026-08-28
**Status:** Approved
**Approach:** Two-phase — Phase 0 no-op merge, Phase 1 aggressive rewrite
**Inspiration:** `tree-sitter-scala` (expression ladder, `inline:` aggressiveness,
class-partitioned operators), `tree-sitter-typescript` (ASI model, statement-list
idiom, separate left-recursive postfix leaf rules).

## Goal

Refactor `tree-sitter-cangjie` so that:

1. The grammar lives in a **single `grammar.js`** file (no `grammar_common.js`,
   no `grammar_literal.js`), matching the convention of every mainstream
   tree-sitter grammar.
2. The number of **ambiguities (declared `conflicts`) and parse-table states**
   drops sharply, targeting **≥30% fewer states** and **≈half the conflict
   groups**, without regressing parse correctness.

The 6017-file golden corpus (vendored under `test/sources/`) exists to gate this
refactor: every behavioral change is caught as a golden diff and every
correctness regression as an ERROR/MISSING count increase.

## Verified baseline (idempotent `tree-sitter generate`, CLI 0.25.10)

| Metric | Value |
|---|---|
| `STATE_COUNT` (total LR states) | 5073 |
| `LARGE_STATE_COUNT` | 1498 |
| Conflict groups in `conflicts:` | 16 (22 individual symbols) |
| `test/sources/cangjie_test` files with ERROR/MISSING nodes | 1315 / 5250 |
| Golden files (all roots) | 6017 |

Per-rule state count, top consumers (`tree-sitter generate --report-states-for-rule -`):

| Rule | States |
|---|---|
| `binary_expression` | 622 |
| `range_expression` | 549 |
| `postfix_expression` | 515 |
| `function_definition` | 472 |
| `call_suffix` | 386 |
| `_top_objects_repeat1` | 214 |
| `operator_function_definition` | 171 |
| `try_expression` | 152 |
| `variable_declaration` | 142 |
| `trailing_lambda_expression` | 135 |
| `_expression_or_declarations` | 128 |
| `array_literal` | 126 |
| `lambda_expression` | 108 |
| `macro_expression` | 105 |
| `call_suffix_repeat1` | 101 |

Declared conflict groups (16):

```
[modifiers] · [modifiers, variable_declaration] · [call_suffix] ·
[function_definition] · [_member_declarations] · [interface_body] ·
[_top_objects] · [primary_init, this_super_expression] · [atomic_variable] ·
[macro_expression] · [_try_handler] · [named_parameter, unnamed_member_param] ·
[_macro_name, annotation] · [annotation_list, decorated_declaration] ·
[features_directive] · [translation_unit, _top_level_object]
```

## Golden policy (agreed)

- **Error count is the hard gate.** A sub-step is allowed only if the total
  number of files containing `ERROR`/`MISSING` nodes does not increase
  (cangjie_test ≤ 1315; total across all roots ≤ current). Any increase stops
  the work and is fixed before proceeding.
- **CST shape is soft.** Node renames/nesting changes are acceptable; each diff
  is reviewed via `golden.py --diff <key>`, then goldens are rebased with
  `--update-all` (or per-file `--update`) once the new shape is confirmed
  correct.
- After rebase, `make golden-ci` must report **0 REGRESSION**.

## Phase 0 — No-op merge into a single `grammar.js`

**Files:**
- Modify: `grammar.js` (absorb `grammar_common.js` + `grammar_literal.js`).
- Delete: `grammar_common.js`, `grammar_literal.js`.

**Mechanics:**
- Move `PREC`, `TOKENS`, `newline`, `terminator`, `sep1`, `commaSep`,
  `commaSep1`, `commaSep1Trailing`, `commaSepTrailing` to the top of
  `grammar.js` as plain `const`s (above `module.exports = grammar({ … })`),
  mirroring how scala/typescript lay out their constants.
- Dissolve the `Literal($)` factory: move every rule it returns (`_literal`,
  `integer_literal`, `float_literal`, `rune_literal`, `byte_literal`,
  `escape_sequence`, `boolean_literal`, `string_literal`, `_line_string_literal`,
  `inline_expression`, `_multi_line_string_literal`,
  `in_multi_line_string_expression`, `_interpolation_statement`,
  `_multi_line_raw_string_literal`, `unit_literal`) **verbatim** into `rules: {}`.
  Drop the `...Literal()` spread.
- Delete the `require('./grammar_common')` and `require('./grammar_literal')`
  lines.
- Move the literal-token regex consts (`hexDigit`, `decimalDigits`,
  `intLiteral`, `floatLiteral`, `rune_literal` regex, `byte_literal` regex,
  etc.) to the top-of-file const block.

**Correctness contract:** the merged `grammar.js` must produce a
**byte-identical** `src/grammar.json` and `src/parser.c` to today's committed
files. Verified by: `tree-sitter generate` produces no diff vs. the committed
artifacts (the current generate is idempotent, so this is a reliable check).
Consequence: **all 6017 goldens stay GREEN**, the 1315/5250 negative split is
unchanged, and zero `conflicts`/states change.

**Commit:** `refactor(grammar): merge grammar_common + grammar_literal into grammar.js`

Phase 0 is a clean measurement checkpoint. Every Phase-1 delta is measured
against it.

## Phase 1 — scala/TS-style aggressive rewrite

Each numbered sub-phase is a separately-committed increment verified by the
§Verification protocol before the next begins.

### 1. Expression ladder: `expression` supertype + `_infix_operand` + `_simple_expression`

Model on scala's ladder and TS's `primary_expression`/`call_expression` split.

- Promote `expression` to a `supertypes` entry: rename `_expression` →
  `expression`. Add `expression` to `supertypes: $ => [$._literal, $.expression]`.
  (CST reshape — `_expression` nodes become `expression` in dumps → reviewed
  rebase.)
- Keep the ladder shape:
  - `expression: choice(assignment_expression, unary_expression, binary_expression, _simple_expression, …control/match/if/try/lambda/…)`
  - `_infix_operand: choice(binary_expression, unary_expression, _simple_expression)` (scala's shared operand rule, so the 13 binary productions don't each re-multiply their operand alternatives).
  - `_simple_expression`: the leaf choice (literals, `atomic_variable`, `parenthesized_expression`, `tuple_expression`, `array_literal`, `range_expression`, and the **postfix leaf rules** below, `jump_expression`, `lambda_expression`, `if_expression`, `match_expression`, `_loop_expression`, `try_expression`, `quote_expression`, `macro_expression`, `let_pattern_destructor`, `_dollar_identifier`, `_dollar_call`, `synchronized_expression`, `spawn_expression`, `perform_expression`, `resume_expression`, `unsafe_expression`, `this_super_expression`).

### 2. Flatten postfix into separate left-recursive leaf rules

Today's recursive wrapper:

```js
postfix_expression: $ => prec.right(PREC.MEMBER, seq(
    $._expression,
    choice($.field_access, $.scope_resolution, $.index_access,
           $.quest_access, $.call_suffix, $.inc_or_dec,
           $.trailing_lambda_expression)))
```

…is the 515-state hog. Replace with **separate leaf rules**, each in
`_simple_expression` with its own `prec.left`:

```js
field_access:        $ => prec.left(PREC.MEMBER,  seq($._expression, '.', $.atomic_variable)),
scope_resolution:    $ => prec.left(PREC.MEMBER,  seq($._expression, '::', $.atomic_variable)),
call_suffix:          $ => prec.left(PREC.PARENS,  seq($._expression, '(', /*args*/, ')', optional($.trailing_lambda_expression))),
index_access:         $ => prec.left(PREC.ARRAY,   seq($._expression, '[', /* … */, ']')),
quest_access:         $ => prec.left(PREC.POSTFIX, seq($._expression, '?', choice($.field_access, $.index_access, $.call_suffix, $.trailing_lambda_expression))),
inc_or_dec:           $ => prec.left(PREC.POSTFIX, seq($._expression, choice(token('++'), token('--')))),
trailing_lambda_expression: $ => prec.left(PREC.POSTFIX, seq($._expression, '{', /* … */, '}')),
```

`postfix_expression` is **dropped** unless a query depends on it. Audit first:
`grep -rn postfix_expression queries/` → none currently. If a future query
needs the wrapper, re-add it as an `inline` alias.

CST effect: `a.b.c(…)` → `call_suffix(field_access(field_access(a, b), c), …)`
instead of `postfix_expression(postfix_expression(postfix_expression(a, …)))`.
Fewer wrapper nodes; reviewed rebase.

### 3. Class-partition `binary_expression`

Today: `BINARY_OPERATORS.map(...)` → 25 separate `prec.left/right` productions
(622 states). Collapse to **one production per precedence class** with
`field('operator', choice(...))`, grouping by the existing `PREC` table:

| Class | Operators | Prec | Assoc |
|---|---|---|---|
| OR | `\|\|` | OR | left |
| AND | `&&` | AND | left |
| COALESCE | `??` | COALESCE | right |
| EQUALITY | `==` `!=` | EQUALITY | left |
| REL | `>` `<` `>=` `<=` `is` `as` `in` `!in` | REL | left |
| BIT_OR | `\|` | BIT_OR | left |
| BIT_XOR | `^` | BIT_XOR | left |
| BIT_AND | `&` | BIT_AND | left |
| SHIFT | `<<` `>>` | SHIFT | left |
| ADD_SUB | `+` `-` | ADD_SUB | left |
| MUL_DIV | `*` `/` `%` | MUL_DIV | left |
| POWER | `**` | POWER | right |
| PIPE | `\|>` `~>` | PIPE | left |

≈13 productions instead of 25; identical precedence/associativity. Operator
field carries the literal choice so highlight/locals queries that match on the
operator string still resolve.

### 4. Restructure `range_expression`

Today: `prec.right(PREC.RANGE, seq(optional(start), choice('..','..='), optional(end), optional(step)))`
— 16 nullable-combinations (549 states). Split into explicit named
alternatives so the nullable-prefix combinatorics disappear:

```js
range_expression: $ => prec.right(PREC.RANGE, choice(
    seq(field('start', $._expression), field('op', choice('..','..=')), field('end', $._expression), optional(seq(':', field('step', $._expression)))),
    seq(field('op', choice('..','..=')), field('end', $._expression), optional(seq(':', field('step', $._expression)))),
    seq(field('start', $._expression), field('op', choice('..','..=')), optional(seq(':', field('step', $._expression)))),
    seq(field('op', choice('..','..=')), optional(seq(':', field('step', $._expression)))),
))
```

(The exact factoring is finalized during implementation; the constraint is:
no `optional` before the operator token, which is what creates the
nullable-prefix state blowup.)

### 5. List/terminator consolidation (TS-style, kills 5 conflict groups)

Cangjie's recursive idiom

```js
seq(optional(seq(self, repeat1(terminator($)))), X, optional(repeat1(terminator($))))
```

appears in `_top_objects`, `_member_declarations`, `interface_body`,
`_expression_or_declarations`, `extend_body`, `foreign_body`. It is
self-referential via `optional`, generating conflict groups
`[_member_declarations]`, `[interface_body]`, `[_top_objects]`,
`[_try_handler]`, `[features_directive]`.

Replace with a shared TS-style list helper:

```js
const termList = (item, $) =>
    seq(repeat(seq(item, repeat1(terminator($)))), item, optional(repeat1(terminator($))));
// equivalent TS shape: seq(item, repeat(seq(terminator, item)), optional(terminator))
```

Single `repeat`, **no self-reference → no conflict**. Applied to each of the six
sites. `_top_objects_repeat1` 214 → ~40; `_expression_or_declarations` 128 → ~30.

Removes conflict groups: `[_member_declarations]`, `[interface_body]`,
`[_top_objects]`, `[_try_handler]`, `[features_directive]` (5 of 16).

### 6. Expand `inline:` (scala's biggest single lever)

scala's notes quantify ~600 states / ~2MB saved by inlining unit-reduce rules.
Add to `inline: $ => [ … ]`:

```
_atomic_expression, _loop_expression, _import_packages,
_expression_or_declarations (post-list-rewrite), _case_body,
_try_handler (post-list-rewrite), _macro_body_item, _quote_body_item,
_foreign_member_declaration, _interface_body_statement, _top_level_object
```

Each inlined rule removes a reduce step and merges states. Only rules that
remain non-recursive after §5 are inlined (the self-recursive list rules stay
named).

### 7. Re-evaluate `conflicts`

After §1–§6, re-run `tree-sitter generate` and re-derive the conflict list.
Expected to **drop**: `[call_suffix]`, `[function_definition]`,
`[_member_declarations]`, `[interface_body]`, `[_top_objects]`,
`[macro_expression]`, `[_try_handler]`, `[annotation_list, decorated_declaration]`,
`[features_directive]`, `[translation_unit, _top_level_object]`.

**Keep and declare cleanly** (inherent):
- `[atomic_variable]` — the `a<b>` generic-vs-relational ambiguity is
  irreducible without an external scanner token for `<`.
- `[_macro_name, annotation]` — both are `@? identifier…`.
- `[modifiers]`, `[modifiers, variable_declaration]` — modifier-list prefix.
- `[primary_init, this_super_expression]`, `[named_parameter, unnamed_member_param]`
  — re-verify; keep if still present.

Target: 16 → **≤ 8**.

## Verification protocol (every Phase-1 sub-step)

In this exact order:

1. `tree-sitter generate` succeeds. Record `STATE_COUNT`, `LARGE_STATE_COUNT`,
   conflict-group count. **Must not increase** vs. the previous checkpoint.
2. **Error-count hard gate** — `make golden-ci` alone exits on REGRESSION
   count, *not* on error-file count, so the no-new-errors gate must be invoked
   explicitly:
   ```sh
   # capture baseline at the Phase-0 checkpoint, then at each step:
   ERR_BASE=$(python3 scripts/golden.py --ci 2>&1 | grep -oP 'error nodes in \K\d+')
   # gate: fails (exit 1) when files-with-errors exceeds the captured baseline
   python3 scripts/golden.py --ci --fail-on-error "$ERR_BASE"
   ```
   `cangjie_test` error-file count must stay ≤ 1315; total across all roots
   ≤ the value captured at the previous checkpoint. Any increase → stop, fix.
3. `python3 scripts/recovery_report.py` — no new `cascading` verdict among the
   12 `test/recovery/` cases (baseline: 5 cascading, 5 clean, 2 localized).
4. CST-shape review: `python3 scripts/golden.py --diff <key>` on a sample of
   reshaped files; confirm the new shape is correct, then `--update-all` to
   rebase.
5. Re-run `make golden-ci` post-rebase → must report `0 REGRESSION`.

## Targets

| Metric | Baseline | Target | Source of cut |
|---|---|---|---|
| `STATE_COUNT` | 5073 | ≤ 3500 (~31%+) | §2 postfix, §3 binary, §4 range, §6 inline |
| `LARGE_STATE_COUNT` | 1498 | ↓ | §6 inline |
| Conflict groups | 16 | ≤ 8 | §5 lists, §7 pruning |
| Files w/ ERROR (cangjie_test) | 1315 | ≤ 1315 (hard gate) | §verification |
| Files w/ ERROR (all roots) | current | ≤ current | §verification |
| Grammar files | 3 | 1 | Phase 0 |

## Out of scope

- **No new external-scanner tokens.** Cangjie's existing `_terminator`
  (newline/ASI), `_block_comment_content`, and `_multi_line_raw_string_*`
  scanner (`src/scanner.c`) is untouched. (Cangjie already mirrors TS's ASI
  model; scala's contextual-token-scanner tricks are deliberately not adopted —
  they'd require C scanner work and risk the raw-string state machine.)
- **No `test/recovery/` changes** (per existing convention).
- **No new vendored corpus**; the existing 6017 files are the regression net.
- **Query rewrites only as forced** by node renames. Audit:
  `grep -rn postfix_expression queries/` → none today, so §2 needs no query
  change. If a renamed node appears in a query, update that query in the same
  commit. No opportunistic query refactoring.
- **No native tree-sitter `test/corpus/`** (`=== ===`) format introduced.
- **No behavior changes outside the grammar** (bindings, `src/scanner.c`,
  `scripts/golden.py`, `recovery_report.py` are untouched).

## Open questions resolved during design

- *Drop `postfix_expression` vs keep a thin alias?* — Drop; no query
  references it. Re-add as `inline` alias only if a query needs it.
- *Rename `_expression` → `expression` (CST churn)?* — Yes; it becomes a
  supertype, matching scala/TS convention. Reviewed rebase covers the churn.
- *Is ≤3500 the success bar?* — Yes; ≥30% cut. Conservative enough to be
  achievable, aggressive enough to matter. The §3+§2 cuts alone project
  ~1250 states removed; inline adds more.
