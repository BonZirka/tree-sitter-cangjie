# Single-file grammar + scala/TS-style rewrite — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Collapse `grammar.js` + `grammar_common.js` + `grammar_literal.js` into one `grammar.js`, then aggressively cut parse-table states and declared conflicts via a scala/TS-style expression rewrite, gated at every step by the golden harness (error-file count must not rise).

**Architecture:** Phase 0 is a byte-identical no-op merge (green checkpoint). Phase 1 is a sequence of golden-gated grammar edits — class-partition `binary_expression`, restructure `range_expression`, flatten `postfix_expression` into separate left-recursive leaf rules, replace the self-recursive terminator-list idiom with a shared TS-style `termList` helper, expand `inline:`, and prune `conflicts`. Each edit is verified by `tree-sitter generate` (state/conflict counts) + `golden.py --ci --fail-on-error` (hard error gate) + `recovery_report.py` (no new cascading) + reviewed `--update-all` rebase.

**Tech Stack:** tree-sitter CLI 0.25.10 (pinned), `tree-sitter generate` + `--report-states-for-rule`, `scripts/golden.py` golden harness, `scripts/recovery_report.py`, GNU make.

**Spec:** `docs/superpowers/specs/2026-08-28-single-file-grammar-rewrite-design.md`

**Branch:** `error-recovery` (current). Working tree is clean.

---

## Verification Protocol (run after every code edit, in this exact order)

Define a baseline once at Task 0, then re-capture after each task. Each task's "Verify" steps invoke these named checks; expected numbers are given per task.

- **V1 — generate & state count.** `tree-sitter generate 2>&1 | tail -3` must succeed. Then:
  ```sh
  grep -E '#define STATE_COUNT|#define LARGE_STATE_COUNT' src/parser.c
  python3 -c "import json;g=json.load(open('src/grammar.json'));print('conflicts:',len(g['conflicts']))"
  ```
  Record the three numbers. They must not *increase* vs. the previous checkpoint; Phase-1 tasks expect them to *decrease*.
- **V2 — error-count hard gate.** Captured baseline `$ERR_BASE` (files with ERROR/MISSING across all roots). Run:
  ```sh
  python3 scripts/golden.py --ci --fail-on-error "$ERR_BASE" 2>&1 | tail -4
  ```
  Exit 0 required. The summary's `error nodes in N files` must be ≤ `$ERR_BASE`. Any increase → STOP, revert, fix.
- **V3 — recovery.** `python3 scripts/recovery_report.py 2>&1 | tail -3` → no new `cascading` verdict vs. baseline (5 cascading / 5 clean / 2 localized).
- **V4 — review CST diffs + rebase.** Sample 3 reshaped files: `python3 scripts/golden.py --diff <key>` each; confirm the new shape is correct. Then accept all pending: `python3 scripts/golden.py --update-all 2>&1 | tail -4`.
- **V5 — re-verify.** `make golden-ci 2>&1 | tail -3` → must print `0 REGRESSION`. Capture the new `$ERR_BASE` for the next task: `ERR_BASE=$(python3 scripts/golden.py --ci 2>&1 | grep -oP 'error nodes in \K\d+')`.

**Commit message convention:** `refactor(grammar): <subject>`.

---

## File Structure

- **Modify:** `grammar.js` — absorbs `grammar_common.js` + `grammar_literal.js` (Phase 0), then edited rule-by-rule (Phase 1).
- **Delete:** `grammar_common.js`, `grammar_literal.js` (Phase 0).
- **Generated (regenerated each step):** `src/grammar.json`, `src/parser.c`, `src/node-types.json` — produced by `tree-sitter generate`, committed.
- **Golden (rebased each step):** `test/golden/**/*.cj.golden.gz` — rewritten by `golden.py --update-all` after review.
- **Untouched:** `src/scanner.c`, `queries/*.scm`, `scripts/golden.py`, `scripts/recovery_report.py`, `test/recovery/`, all bindings.

---

## Task 0: Phase 0 — no-op merge into single `grammar.js`

**Files:**
- Modify: `grammar.js` (absorb both helper files)
- Delete: `grammar_common.js`, `grammar_literal.js`

**Goal:** One file; `tree-sitter generate` produces byte-identical `src/parser.c`; goldens stay GREEN.

- [ ] **Step 1: Inline `grammar_common.js` consts/helpers at the top of `grammar.js`**

Replace the current top of `grammar.js` (lines 1–20, the `@file` comment + `<reference>` + `// @ts-check` + the `const { ... } = require('./grammar_common')` block) with:

```js
/**
 * @file Cangjie grammar for tree-sitter
 * @author BonZer0 <sergeykovaltsov@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

const newline = /\r?\n/;
const terminator = ($) => choice($._terminator, ';');
```

Then **paste the `PREC` const verbatim from `grammar_common.js:5-28`** and **the `TOKENS` const verbatim from `grammar_common.js:30-115`** (each TOKENS value is `token('...')`-wrapped in the original — keep that exactly; do not retyped as bare strings, or generate may differ). Then append the helpers verbatim from `grammar_common.js:117-135`:

```js
function sep1(rule, separator) { return seq(rule, repeat(seq(separator, rule))); }
function commaSep1(rule) { return seq(rule, repeat(seq(',', rule))); }
function commaSep1Trailing(rule) { return seq(rule, repeat(seq(',', rule)), optional(',')); }
function commaSepTrailing(rule) { return optional(commaSep1Trailing(rule)); }
function commaSep(rule) { return optional(commaSep1(rule)); }
```

(Do NOT add a `termList` helper here — that arrives in Task 4.)

⚠ **Critical:** `grammar_common.js` wraps each TOKENS value in `token(...)` (e.g. `AS: token('as')`). The merged version MUST preserve the exact `token('...')` wrapping, or the generated parser differs. After pasting, verify every TOKENS entry is `NAME: token('word')` form — if any drift, restore the `token(...)` wrapper. Step 3 (generate = no diff) is the hard check; if it fails, the cause is a missing `token(...)`.

- [ ] **Step 2: Inline `grammar_literal.js` regex consts + dissolve the `Literal($)` factory**

(a) Add the literal regex consts (from `grammar_literal.js` lines 1–59) immediately after the `TOKENS` block above:

```js
const hexDigit = /[0-9a-fA-F]/;
const octalDigit = /[0-7]/;
const decimalDigit = /[0-9]/;
const binaryDigit = /[01]/;
const hexDigits = seq(hexDigit, repeat(choice('_', hexDigit)));
const octalDigits = seq(octalDigit, repeat(choice('_', octalDigit)));
const decimalDigits = seq(decimalDigit, repeat(choice('_', decimalDigit)));
const binaryDigits = seq(binaryDigit, repeat(choice('_', binaryDigit)));
const hexLiteral = seq('0', choice('x', 'X'), hexDigits);
const octalLiteral = seq('0', choice('o', 'O'), octalDigits);
const binaryLiteral = seq('0', choice('b', 'B'), binaryDigits);
const decimalLiteral = choice(decimalDigit, seq(/[1-9]/, repeat1(choice('_', decimalDigit))));
const intLiteral = seq(choice(binaryLiteral, octalLiteral, hexLiteral, decimalLiteral), optional(/_?[iu](8|16|32|64)/));
const decimalExponent = seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits);
const decimalFloatLiteral = seq(choice(seq(decimalLiteral, decimalExponent), seq(decimalLiteral, '.', decimalDigits, optional(decimalExponent)), seq('.', decimalDigits, optional(decimalExponent))), optional(/_?[fF](16|32|64)/));
const hexExponent = seq(choice('p', 'P'), optional(choice('+', '-')), decimalDigits);
const hexMantissa = choice(seq(hexDigits), seq(hexDigits, '.', hexDigits), seq('.', hexDigits));
const hexFloatLiteral = seq('0', choice('x', 'X'), hexMantissa, hexExponent);
const floatLiteral = choice(decimalFloatLiteral, hexFloatLiteral);
const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');
const escapedIdentifier = /\\[tbrn'"\\fv0\$]/;
const rune_literal = choice(seq('r\'', choice(/[^'\\]/, uniCharacterLiteral, escapedIdentifier), '\''), seq('r"', choice(/[^"\\]/, uniCharacterLiteral, escapedIdentifier), '"'));
const singleCharByte = /[\u0000-\u0009\u000B\u000C\u000E-\u0021\u0023-\u0026\u0028-\u005B\u005D-\u007F]/;
const byteEscapedIdentifier = /\\[tbrn'"\\fv0]/;
const hexCharByte = seq('\\u{', choice(hexDigit, seq(hexDigit, hexDigit)), '}');
const byte_literal = seq('b\'', choice(singleCharByte, '"', hexCharByte, byteEscapedIdentifier), '\'');
```

(b) Delete the two `require` lines:
- `const Literal = require('./grammar_literal');` (grammar.js line 51)
- the `const { PREC, TOKENS, newline, terminator, sep1, commaSep, commaSep1, commaSep1Trailing, commaSepTrailing } = require('./grammar_common');` block (lines 10–20)

(c) In `rules: {}`, replace the final `...Literal(),` spread (grammar.js line 1059) by pasting the literal rule bodies verbatim from `grammar_literal.js` (the object returned by the `module.exports = function ($) { return { ... } }` — every key: `_literal, integer_literal, float_literal, rune_literal, byte_literal, escape_sequence, boolean_literal, string_literal, _line_string_literal, inline_expression, _multi_line_string_literal, in_multi_line_string_expression, _interpolation_statement, _multi_line_raw_string_literal, unit_literal`). Each `name: $ => ...` or `name: _ => ...` is pasted as a normal rule entry; `$` is already the grammar parameter in `rules: {}`.

(d) Delete `grammar_common.js` and `grammar_literal.js`.

- [ ] **Step 3: V1 — verify byte-identical generate**

```sh
cp src/grammar.json /tmp/opencode/grammar.before.json
cp src/parser.c /tmp/opencode/parser.before.c
tree-sitter generate
diff -q src/grammar.json /tmp/opencode/grammar.before.json && diff -q src/parser.c /tmp/opencode/parser.before.c && echo "IDENTICAL — Phase 0 is a true no-op"
```
Expected: `IDENTICAL — Phase 0 is a true no-op`. If the diff is non-empty, the merge is NOT behavior-preserving; revert (`git checkout -- grammar.js grammar_common.js grammar_literal.js`) and re-check the `token(...)` wrapping in `TOKENS` and the pasted literal consts. Do NOT proceed until generate is byte-identical.

- [ ] **Step 4: V2/V5 — goldens stay green**

```sh
make golden-ci 2>&1 | tail -3
ERR_BASE=$(python3 scripts/golden.py --ci 2>&1 | grep -oP 'error nodes in \K\d+')
echo "ERR_BASE=$ERR_BASE"  # record this for every subsequent task
```
Expected: `0 REGRESSION` and `0 new` (nothing changed, so no rebases). `ERR_BASE` is the baseline error-file count across all roots.

- [ ] **Step 5: Record baseline metrics**

```sh
grep -E '#define STATE_COUNT|#define LARGE_STATE_COUNT' src/parser.c   # 5073 / 1498
python3 -c "import json;g=json.load(open('src/grammar.json'));print('conflicts:',len(g['conflicts']))"   # 16
echo "BASELINE: STATE=5073 LARGE=1498 conflicts=16 ERR_BASE=$ERR_BASE"
```
Record this triple + `ERR_BASE` at the top of your task notes; every Phase-1 task compares against it.

- [ ] **Step 6: Commit**

```sh
git add grammar.js grammar_common.js grammar_literal.js src/grammar.json src/parser.c src/node-types.json
git commit -m "refactor(grammar): merge grammar_common + grammar_literal into grammar.js"
```
(Stage the deletions of the two helper files too — `git add` records removals.)

---

## Task 1: Class-partition `binary_expression` (25 → 13 productions)

**Files:**
- Modify: `grammar.js` — replace `BINARY_OPERATORS` + `binary_expression` (lines 22–49 and 736–750).

**Goal:** Cut `binary_expression` states (~622) by collapsing 25 per-operator productions into 13 per-precedence-class productions. CST operator field stays the same literal string → goldens should stay GREEN or near-green.

- [ ] **Step 1: Replace the `BINARY_OPERATORS` const + `binary_expression` rule**

Delete the `const BINARY_OPERATORS = [...]` block (lines 22–49) and the `binary_expression: $ => choice(...BINARY_OPERATORS.map(...))` rule (lines 736–750). Replace the rule with:

```js
        binary_expression: $ => choice(
            prec.left(PREC.OR,         seq(field('left', $._expression), field('operator', choice(token('||'))),                                                          field('right', $._expression))),
            prec.left(PREC.AND,        seq(field('left', $._expression), field('operator', choice(token('&&'))),                                                          field('right', $._expression))),
            prec.right(PREC.COALESCE,   seq(field('left', $._expression), field('operator', choice(token('??'))),                                                          field('right', $._expression))),
            prec.left(PREC.EQUALITY,   seq(field('left', $._expression), field('operator', choice(token('=='), token('!='))),                                            field('right', $._expression))),
            prec.left(PREC.REL,        seq(field('left', $._expression), field('operator', choice(token('>'), token('<'), token('>='), token('<='), TOKENS.IS, TOKENS.AS, TOKENS.IN, TOKENS.NOT_IN)), field('right', $._expression))),
            prec.left(PREC.BIT_OR,     seq(field('left', $._expression), field('operator', choice(token('|'))),                                                          field('right', $._expression))),
            prec.left(PREC.BIT_XOR,    seq(field('left', $._expression), field('operator', choice(token('^'))),                                                          field('right', $._expression))),
            prec.left(PREC.BIT_AND,    seq(field('left', $._expression), field('operator', choice(token('&'))),                                                          field('right', $._expression))),
            prec.left(PREC.SHIFT,      seq(field('left', $._expression), field('operator', choice(token('<<'), token('>>'))),                                            field('right', $._expression))),
            prec.left(PREC.ADD_SUB,    seq(field('left', $._expression), field('operator', choice(token('+'), token('-'))),                                            field('right', $._expression))),
            prec.left(PREC.MUL_DIV,    seq(field('left', $._expression), field('operator', choice(token('*'), token('/'), token('%'))),                                  field('right', $._expression))),
            prec.right(PREC.POWER,      seq(field('left', $._expression), field('operator', choice(token('**'))),                                                          field('right', $._expression))),
            prec.left(PREC.PIPE,       seq(field('left', $._expression), field('operator', choice(token('|>'), token('~>'))),                                            field('right', $._expression))),
        ),
```

Note: `TOKENS.IS` etc. are already `token('is')`, so wrapping again in `token(...)` is harmless (tree-sitter idempotent). Operator field still yields the literal string in the CST, so existing goldens' `operator: "is"` rendering is unchanged.

⚠ **`_infix_operand` ladder deferred (spec §1 deviation).** The spec mentions introducing `_infix_operand = choice(binary_expression, unary_expression, _atomic_expression)` as the binary operand. This is **deferred** here: it would restrict binary operands to binary|unary|atomic, breaking unparenthesized control-expression operands like `(if c then x else y) + 1` and risking new ERROR nodes. Keeping operands as `$._expression` is behavior-preserving; the state cut comes from 25→13 productions alone. Revisit in a follow-up only if Task 7's metrics miss the ≤3500 bar.

- [ ] **Step 2: V1** — generate; expect `STATE_COUNT` < 5073 and `conflicts` ≤ 16.
- [ ] **Step 3: V2** — `python3 scripts/golden.py --ci --fail-on-error "$ERR_BASE" 2>&1 | tail -4`; expect exit 0. (Expected: 0 REGRESSION — operator-field values unchanged.) If error-file count rose, revert and investigate the `??`/`**` right-assoc or the `is`/`as`/`in`/`!in` grouping.
- [ ] **Step 4: V3** — recovery report; no new cascading.
- [ ] **Step 5: V4** — if any golden diffs (possible from operator-field rendering), sample 3, confirm correct, `--update-all`.
- [ ] **Step 6: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 7: Commit** — `refactor(grammar): class-partition binary_expression (25→13 productions)`

---

## Task 2: Restructure `range_expression` (cut the 16-combo blowup)

**Files:**
- Modify: `grammar.js` — replace `range_expression` (lines 763–768).

**Goal:** Remove the `optional(start) × choice(..|..=) × optional(end) × optional(step)` nullable-prefix combinatoric (~549 states) by splitting into explicit alternatives where no `optional` precedes the operator token.

- [ ] **Step 1: Replace the `range_expression` rule**

```js
        range_expression: $ => prec.right(PREC.RANGE, choice(
            // start op end [:step]
            seq(field('start', $._expression), field('op', choice(token('..'), token('..='))), field('end', $._expression), optional(seq(':', field('step', $._expression)))),
            // op end [:step]            (prefix range)
            seq(                          field('op', choice(token('..'), token('..='))), field('end', $._expression),   optional(seq(':', field('step', $._expression)))),
            // start op [:step]           (postfix range)
            seq(field('start', $._expression), field('op', choice(token('..'), token('..='))),                                optional(seq(':', field('step', $._expression)))),
            // op [:step]                 (bare range)
            seq(                          field('op', choice(token('..'), token('..='))),                                     optional(seq(':', field('step', $._expression)))),
        )),
```

- [ ] **Step 2: V1** — generate; expect `STATE_COUNT` down vs. Task 1's value; `conflicts` ≤ previous.
- [ ] **Step 3: V2** — error gate; expect exit 0. (CST shape of ranges changes — fields `op`/`start`/`end`/`step` appear; the `range_expression` node itself stays named. Diffs expected, errors must not rise.)
- [ ] **Step 4: V3** — recovery report; no new cascading.
- [ ] **Step 5: V4** — `--diff` 3 range-using files (e.g. `cangjie_test/HLT/API/syntax/...`); confirm fielded shape; `--update-all`.
- [ ] **Step 6: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 7: Commit** — `refactor(grammar): restructure range_expression to cut nullable-prefix states`

---

## Task 3: Flatten `postfix_expression` into separate left-recursive leaf rules

**Files:**
- Modify: `grammar.js` — `postfix_expression` (lines 770–781), the 7 leaf rules (lines 783–820), and `_atomic_expression` (lines 693–719).

**Goal:** Drop the recursive `postfix_expression` wrapper (~515 states); make each accessor its own `prec.left` left-recursive leaf rule in `_atomic_expression`. `a.b.c(…)` becomes `call_suffix(field_access(field_access(a,b),c), …)`.

- [ ] **Step 1: Delete `postfix_expression`; rewrite each leaf rule as left-recursive**

Delete the `postfix_expression: $ => prec.right(PREC.MEMBER, seq(...))` rule (lines 770–781). Rewrite the 7 leaf rules so each takes `$._expression` as its left operand and carries its own `prec.left`:

```js
        field_access: $ => prec.left(PREC.MEMBER, seq($._expression, '.', $.atomic_variable)),
        scope_resolution: $ => prec.left(PREC.MEMBER, seq($._expression, '::', $.atomic_variable)),
        call_suffix: $ => prec.left(PREC.PARENS, seq(
            $._expression,
            '(',
            commaSepTrailing(choice(
                seq($._var_binding_pattern, ':', $._expression),
                $._expression,
                seq(TOKENS.INOUT, optional(seq($._expression, '.')), $._var_binding_pattern)
            )),
            ')',
            optional(seq(',', $.trailing_lambda_expression))
        )),
        index_access: $ => prec.left(PREC.ARRAY, seq(
            $._expression,
            '[',
            choice(
                seq($._expression, optional(token('..'))),
                seq($._expression, choice(token('..'), token('..=')), $._expression, optional(seq(':', $._expression))),
                seq(token('..'), $._expression)
            ),
            ']'
        )),
        quest_access: $ => prec.left(PREC.POSTFIX, seq(
            $._expression, '?',
            choice($.field_access, $.index_access, $.call_suffix, $.trailing_lambda_expression)
        )),
        inc_or_dec: $ => prec.left(PREC.POSTFIX, seq($._expression, choice(token('++'), token('--')))),
        trailing_lambda_expression: $ => prec.left(PREC.POSTFIX, seq(
            $._expression,
            '{',
            optional(seq(optional($.lambda_parameters), token('=>'))),
            optional(seq($._expression_or_declarations, repeat(terminator($)))),
            '}'
        )),
```

- [ ] **Step 2: Update `_atomic_expression` — drop `$.postfix_expression`, add the 7 leaf rules**

In `_atomic_expression: $ => choice(...)` (lines 693–719), remove the `$.postfix_expression,` entry and add instead: `$.field_access, $.scope_resolution, $.call_suffix, $.index_access, $.quest_access, $.inc_or_dec, $.trailing_lambda_expression,`. (These are now the recursive leaves; they self-reference via `$._expression` → `_atomic_expression`, which tree-sitter resolves with the `prec.left`.)

- [ ] **Step 3: Audit queries for `postfix_expression` references**

```sh
grep -rn postfix_expression queries/ || echo "no query references — safe to drop"
```
Expected: `no query references — safe to drop`. (If any appear, add an `inline` alias `postfix_expression: $ => choice($.field_access, $.call_suffix, ...)` — but currently none exist.)

- [ ] **Step 4: V1** — generate; expect `STATE_COUNT` down sharply vs. Task 2. Watch for new conflicts — if `tree-sitter generate` warns, add the minimal `[call_suffix]`/`[field_access]` group back to `conflicts` (the old `[call_suffix]` group may have been resolved by flattening; verify).
- [ ] **Step 5: V2** — error gate; **expect a drop in error-file count** (better postfix recovery often fixes prior cascades) but at minimum no increase. If it rose, the `prec.left` chain isn't reducing correctly — revert and try `prec.right` on `quest_access` (the `?`-chain is right-leaning).
- [ ] **Step 6: V3** — recovery report; expect `cascading` ≤ 5 (baseline) — the recovery cases `01..12` should recover at least as well.
- [ ] **Step 7: V4** — `--diff` 5 files with chained calls (`a.b.c.d`, `f()()`, `obj?.m`); confirm the new flat nested shape is correct (no `postfix_expression` wrapper); `--update-all`.
- [ ] **Step 8: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 9: Commit** — `refactor(grammar): flatten postfix_expression into left-recursive leaf rules`

---

## Task 4: List/terminator consolidation — shared `termList` helper

**Files:**
- Modify: `grammar.js` — add `termList` helper; rewrite 6 list sites: `_top_objects` (110), `_member_declarations` (467–479), `interface_body` (426–430), `_expression_or_declarations` (308–316), `extend_body` (613–623), `foreign_body` (630–634).

**Goal:** Replace the self-recursive `seq(optional(seq(self, repeat1(terminator))), X, optional(repeat1(terminator)))` idiom (which generates conflict groups 4/5/6/10/14) with a single `repeat`-based TS-style helper → no self-reference, no conflict.

- [ ] **Step 1: Add the `termList` helper (top-of-file, after `commaSep`)**

```js
// TS-style statement list: item (terminator item)* optional-trailing-terminator.
// No self-reference → no reduce/reduce conflict. Item may itself be a choice.
const termList = (item, $) => seq(
    repeat(seq(item, repeat1(terminator($)))),
    item,
    optional(repeat1(terminator($))),
);
```

- [ ] **Step 2: Rewrite the six sites to use `termList`**

For each site, replace the `seq(optional(seq(self, repeat1(terminator($)))), X, optional(repeat1(terminator($))))` body with `termList(X, $)` (where `X` is the existing `choice(...)` of list elements). Concrete edits:

```js
// _top_objects (line 110):
_top_objects: $ => termList($._top_level_object, $),

// _expression_or_declarations (lines 308-316):
_expression_or_declarations: $ => termList(choice(
    $.variable_declaration, $.function_definition,
    $.assignment_expression, $._expression,
), $),

// interface_body (lines 426-430):
interface_body: $ => termList($._interface_body_statement, $),

// _member_declarations (lines 467-479):
_member_declarations: $ => termList(choice(
    $.variable_declaration, $.function_definition, $.operator_function_definition,
    $.property_definition, $.init, $.static_init, $.macro_expression, $.decorated_member,
), $),

// extend_body (lines 613-623):
extend_body: $ => seq('{', repeat(seq(choice(
    $.function_definition, $.operator_function_definition, $.property_definition,
    $.decorated_member, $.macro_expression,
), repeat(terminator($)))), '}'),
//  (extend_body already uses a plain repeat; leave as-is unless its conflict
//  group [extend_definition] is still present after Task 6 — it isn't in the
//  drop list, so SKIP extend_body. Only touch it if V1 shows a remaining conflict.)

// foreign_body (lines 630-634):
foreign_body: $ => seq('{', repeat(seq($._foreign_member_declaration, repeat(terminator($)))), '}'),
//  (already plain-repeat; same as extend_body — SKIP unless a conflict remains.)
```

So the actual `termList` rewrites are the **first four**: `_top_objects`, `_expression_or_declarations`, `interface_body`, `_member_declarations`. (`extend_body` and `foreign_body` already use plain `repeat` and don't carry the self-recursive conflict — leave them.)

- [ ] **Step 3: V1** — generate; expect `conflicts` to drop by ~5 (groups `[_member_declarations]`, `[interface_body]`, `[_top_objects]`, `[_try_handler]`, `[features_directive]`). `STATE_COUNT` down. If `_try_handler` or `features_directive` conflict remains, that's OK — Task 6 handles survivors.
- [ ] **Step 4: V2** — error gate; no increase.
- [ ] **Step 5: V3** — recovery report; no new cascading.
- [ ] **Step 6: V4** — `--diff` 3 files with member lists (a class body, an interface body, a block); confirm list structure preserved; `--update-all`.
- [ ] **Step 7: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 8: Commit** — `refactor(grammar): replace self-recursive list idiom with termList helper`

---

## Task 5: Expand the `inline:` list

**Files:**
- Modify: `grammar.js` — the `inline: $ => []` block (lines 76–77).

**Goal:** Dissolve unit-reduce rules so their states merge (scala's biggest documented lever). Only inline rules that are NON-self-recursive after Task 4.

- [ ] **Step 1: Populate `inline:`**

Replace `inline: $ => [],` with:

```js
    inline: $ => [
        $._atomic_expression,
        $._loop_expression,
        $._import_packages,
        $._expression_or_declarations,   // non-recursive after Task 4's termList
        $._case_body,
        $._macro_body_item,
        $._quote_body_item,
        $._foreign_member_declaration,
        $._interface_body_statement,
        $._top_level_object,
        $._try_handler,                 // verify non-recursive first; if it still
                                        // self-references, DROP it from this list
    ],
```

⚠ Before saving, grep each inlined rule to confirm it's not self-referential:
```sh
for r in _atomic_expression _loop_expression _import_packages _expression_or_declarations _case_body _macro_body_item _quote_body_item _foreign_member_declaration _interface_body_statement _top_level_object _try_handler; do
  echo "== $r =="; rg "\$.$r\b" grammar.js | rg -v "inline:|supertypes:"
done
```
If any rule references itself, remove it from `inline:` (inlining a recursive rule is a generate error).

- [ ] **Step 2: V1** — generate; expect `STATE_COUNT` to drop further. If `tree-sitter generate` errors on a recursive inline, remove that one entry and regenerate.
- [ ] **Step 3: V2** — error gate; no increase. (Inlining removes the inlined node from the CST → goldens diff: the wrapper node disappears, children appear directly. This is expected; review carefully.)
- [ ] **Step 4: V3** — recovery report; no new cascading.
- [ ] **Step 5: V4** — `--diff` 5 files; confirm inlined nodes cleanly disappear (children promoted); `--update-all`.
- [ ] **Step 6: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 7: Commit** — `refactor(grammar): inline unit-reduce rules to merge states`

---

## Task 6: Re-derive and prune `conflicts`

**Files:**
- Modify: `grammar.js` — the `conflicts: $ => [...]` block (lines 79–96).

**Goal:** Remove conflict groups that Tasks 1–5 eliminated; keep only the inherent ones. Target 16 → ≤ 8.

- [ ] **Step 1: Re-derive the actual conflict list**

```sh
tree-sitter generate 2>&1 | tail -3   # should print warnings for remaining conflicts
python3 -c "import json;g=json.load(open('src/grammar.json'));[print(c) for c in g['conflicts']]"
```
Read the actual list. The `conflicts:` array in `grammar.js` must match what generate reports — entries that no longer conflict are simply ignored by generate, but keeping stale entries is dead code. Prune to match.

- [ ] **Step 2: Edit `conflicts:` to keep only survivors**

Expected survivors (keep): `[atomic_variable]`, `[_macro_name, annotation]`, `[modifiers]`, `[modifiers, variable_declaration]`, `[primary_init, this_super_expression]`, `[named_parameter, unnamed_member_param]` — plus any others generate still reports. Remove the ones generate no longer flags: `[call_suffix]`, `[function_definition]`, `[_member_declarations]`, `[interface_body]`, `[_top_objects]`, `[macro_expression]`, `[_try_handler]`, `[annotation_list, decorated_declaration]`, `[features_directive]`, `[translation_unit, _top_level_object]`.

Concretely, set `conflicts:` to the verbatim list printed by Step 1's python one-liner (transcribe each `[...]` group into the `conflicts: $ => [ ... ]` array).

- [ ] **Step 3: V1** — generate; `conflicts` count = number of groups you kept (≤ 8 target). `STATE_COUNT` unchanged or slightly down (pruning `conflicts:` doesn't add states; it removes declared ambiguity hints).
- [ ] **Step 4: V2** — error gate; no increase. (Conflict declarations don't change the accepted language, only the parse-table resolution — goldens should stay green if the kept set matches generate's report. If goldens diff, a pruned conflict was actually load-bearing — add it back.)
- [ ] **Step 5: V5** — `make golden-ci` → `0 REGRESSION`; re-capture `ERR_BASE`.
- [ ] **Step 6: Commit** — `refactor(grammar): prune resolved conflicts (16→N)`

---

## Task 7: Final verification + metrics report (no code change)

**Files:** none.

- [ ] **Step 1: Full golden sweep**

```sh
make golden-ci 2>&1 | tail -3
```
Expected: `0 REGRESSION`, `0 new`. Exit 0.

- [ ] **Step 2: Recovery report**

```sh
python3 scripts/recovery_report.py 2>&1 | tail -6
```
Expected: `cascading` ≤ 5 (baseline), no increase.

- [ ] **Step 3: Final metrics**

```sh
grep -E '#define STATE_COUNT|#define LARGE_STATE_COUNT' src/parser.c
python3 -c "import json;g=json.load(open('src/grammar.json'));print('conflicts:',len(g['conflicts']))"
ls grammar*.js | wc -l   # 1
```
Expected vs. baseline:
| Metric | Baseline | Target |
|---|---|---|
| STATE_COUNT | 5073 | ≤ 3500 |
| conflicts | 16 | ≤ 8 |
| grammar files | 3 | 1 |
| error-file count | `$ERR_BASE` (Task 0) | ≤ `$ERR_BASE` |

- [ ] **Step 4: If STATE_COUNT > 3500, one more targeted pass**

If states are still > 3500, re-run `tree-sitter generate --report-states-for-rule - 2>&1 | head -20`, find the new top consumer, and apply one more class-partition or inline to it (same V1–V5 loop). This pass is in-scope per the spec's §7 "survivors" clause.

- [ ] **Step 5: Final commit (if any cleanup) + report**

```sh
git log --oneline -10
```
Write a one-paragraph summary of final metrics vs. baseline into the commit body if a cleanup commit was made; otherwise report the numbers in the task notes.

---

## Task 8 (OPTIONAL / DEFERRED): Promote `expression` supertype

**Status:** ⚠ DEFERRED — recommend skipping unless query ergonomics are explicitly wanted.

**Rationale (spec correction):** The spec's claim that renaming `_expression`→`expression` "renames existing nodes in dumps" is **wrong**. `_expression` is hidden (underscore prefix) and does NOT appear in the CST today. Renaming to `expression` (visible) + adding to `supertypes` would ADD an `expression` wrapper node to every expression in all 6017 goldens — a massive rebase — for ~zero state savings (supertypes don't reduce states). This does not serve the refactor's stated goal (cut states/ambiguities). Defer unless a follow-up specifically wants a queryable `expression` supertype.

**If pursued later:**

- [ ] Rename the rule `_expression` → `expression` (all references).
- [ ] Add `$.expression` to `supertypes: $ => [$._literal, $.expression]`.
- [ ] Run V1–V5; expect a full `--update-all` rebase of every expression-containing golden.
- [ ] Update any query that should treat `expression` as a supertype.
- [ ] Commit — `refactor(grammar): promote expression to supertype`.

---

## Done

The grammar is a single file, parse-table states and declared conflicts are cut per the targets, and the 6017-file golden corpus + 12 recovery cases verify no correctness regression. Every behavioral change was reviewed and rebased under the agreed policy.
