# Terminator Boundary Bias Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Eliminate the residual `None<V>`-class glue parses and the macro-attach ERROR by biasing GLR ties toward statement-boundary readings (spec: `docs/superpowers/specs/2026-09-10-terminator-boundary-bias-design.md`).

**Architecture:** Two grammar-only changes on branch `terminator-boundary-bias`. B1 audits and documents the terminator/`;` consumption routes (no behavioral change expected — the one dual route is nodeless and cjc-legal). B2 adds targeted negative `prec.dynamic` to glue-prone rules (`binary_expression` first, then `macro_expression`/`assignment_expression` only if the corpus demands). The scanner and extras are NOT touched (dual-identity newlines stay, per precedent survey in the spec).

**Tech Stack:** tree-sitter grammar.js, `python3 scripts/tsbuild.py` (mandatory generation entry point), `python3 scripts/golden.py` corpus harness (3 s per-subprocess timeout already enforced), `cjc` 1.2.0 for semantic arbitration.

**Memory discipline (CRITICAL, user-mandated):** every `tree-sitter` invocation gets `timeout 3`; `tsbuild.py` runs alone, never parallel; `cjc` sequential under `timeout 120`; worker pools ≤ 8; never `ulimit -v` (breaks cc with fake segfaults).

**Branch:** work happens on `terminator-boundary-bias` (already created from `error-recovery`). Push at the end (Task 6); do not push earlier.

---

## Background facts (verified, do not re-derive)

- The `;`-substitution experiment (`/tmp/opencode/rank/p2/termprobe.py`, `cjcprobe.py`):
  179/200 sampled files parse identically with `;` at every scanner-emitted TERMINATOR;
  2 files parse *better* (concurrent_hash_map.cj: 5 glue sites; PropGetterOrSetter_01.cj:
  macro attach); `cjc` accepted the substitution in 19/19 cross-tabulated files.
- Root mechanism: `\n` has dual identity (`/\s/` extras + external TERMINATOR token),
  so two GLR branches both cross a newline; the tie resolves late by tree comparison
  and picks the glue. `;` cannot be swallowed by extras, so the glue branch dies at it.
- cjc legality matrix (all PASS, verified 2026-09-10): `package a.b;` /
  `import std.math.*;` / `class C {} ;` between items / leading `;` / `import a;` then
  `import b;`. Therefore top-level `token(';')` slots MUST stay.
- E1 constraint (learned by revert): NEVER make the external TERMINATOR valid at
  top-level item boundaries — it kills the macro-prefix→`import` attachment
  (`@When[...] import ...` in `socket_raw_cjnative.cj`).
- k4 contract: `foo()` followed by `{ lambda }` on the NEXT line must parse as a
  trailing lambda, not two statements. The scanner's `{`-suppression keeps this tie
  alive; a blanket `prec.dynamic` on statement items would break it. That is why B2
  is targeted, not blanket.

## Terminator consumption-site audit (current grammar.js)

| Line | Rule | Form | Position class |
|---|---|---|---|
| 165 | translation_unit items | `optional(token(';'))` prefix | top-level `;` slot |
| 166 | translation_unit end | `optional(token(';'))` | top-level `;` slot |
| 171, 175 | package_declaration / macro_package_declaration | rule-internal `terminator($)` | rule-internal |
| 182 | features_directive | `repeat1(terminator($))` | rule-internal |
| 214 | import_list | rule-internal `terminator($)` | rule-internal |
| 328 | _expression_or_declarations | item-trailing `repeat(terminator($))` | block items |
| 401 | generic_constraints | `repeat(seq(',', optional(repeat1(terminator($))), ...))` | list separator |
| 440 | _declaration_list | `optional(repeat1(token(';')))` prefix | member-list `;` slot |
| 483, 490 | primary_init | rule-internal `terminator($)` | rule-internal |
| 867 | _try_handler | trailing `repeat(terminator($))` | rule-internal |
| 1062, 1071 | string_interpolation / interp_brace_group | `optional(repeat1(terminator($)))` | interpolation holes |

Known dual route: `;` immediately after the last `import_list` is consumable by BOTH
import_list's `terminator($)` (line 214) and the items-prefix `token(';')` (line 165).
Both routes are **nodeless** (terminators produce no tree nodes) and the versions
merge, so the tie has zero tree impact; cjc says the position is legal. Decision:
document as accepted, change nothing, unless Task 2's verification finds a
visible-tree difference.

---

### Task 1: Baseline snapshots

**Files:**
- Create: `/tmp/opencode/rank/p2/b2_baseline/` (artifacts only, NOT committed)

- [ ] **Step 1: Save pre-change dumps of the target files**

```bash
mkdir -p /tmp/opencode/rank/p2/b2_baseline && cd /home/huawei/projects/tree-sitter-cangjie
for f in cangjie_runtime/stdlib/libs/std/collection/concurrent/concurrent_hash_map.cj \
         "cangjie_test/HLT/API/syntax/API/Decl/PropGetterOrSetter/PropGetterOrSetter_01.cj" \
         "cangjie_test/HLT/API/std/random/random_nextInt8_03_01.cj"; do
  python3 scripts/golden.py --dump "$f" \
    > "/tmp/opencode/rank/p2/b2_baseline/$(basename $f).dump" 2>/dev/null
done
grep -c "assignment_expression" /tmp/opencode/rank/p2/b2_baseline/concurrent_hash_map.cj.dump
```

Expected: dump files exist; the grep prints the current glue count (baseline to beat,
expected ≥ 10 from the probe's signed delta: −5 assignment −10 binary in the
substituted version).

- [ ] **Step 2: Ensure the k4 probe exists**

```bash
printf 'func f() {\n  foo()\n  { x => x + 1 }\n}\n' > /tmp/opencode/rank/p2/k4.cj
timeout 3 env XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config \
  tree-sitter parse /tmp/opencode/rank/p2/k4.cj 2>/dev/null | grep -cE "\(ERROR|MISSING"
```

Expected: `0` (baseline green — this contract must survive unchanged).

### Task 2: B1 — consumption-site audit sign-off

**Files:**
- Modify: none (audit is recorded here and in the commit message; grammar.js unchanged)

- [ ] **Step 1: Verify the audit table line numbers still match**

```bash
cd /home/huawei/projects/tree-sitter-cangjie
grep -n "terminator(\$\|token(';')" grammar.js
```

Expected: exactly the 14 sites from the table above (lines may shift ±2 if grammar.js
changed since 2026-09-10; rule names must match).

- [ ] **Step 2: Verify no other file consumes terminators**

```bash
grep -n "_terminator" grammar.js queries/*.scm | grep -v "externals\|terminator(\$)"
```

Expected: only the `externals:` declaration. If anything else appears, STOP and
re-open the design (out-of-plan consumption route found).

- [ ] **Step 3: Record sign-off**

No code change. The dual route at import-overlap is accepted (nodeless, cjc-legal,
merging). Evidence lives in this plan and the commit message of Task 3.

### Task 3: B2 — negative dynamic precedence on binary_expression

**Files:**
- Modify: `grammar.js` (the `binary_expression` rule)
- Test: corpus + probes + golden CI (commands below)

- [ ] **Step 1: Apply the edit**

Find (current):

```js
        binary_expression: $ => choice(
            bop($, PREC.OR,        ['||']),
```

Replace with:

```js
        binary_expression: $ => prec.dynamic(-1, choice(
            bop($, PREC.OR,        ['||']),
```

and close the wrapper at the rule's end — find the rule's terminating `),` (the line
after the last `bop(...)` before `range_expression`) and change:

```js
        ),
```

to:

```js
        )),
```

so only `binary_expression` is wrapped. The full rule must read
`binary_expression: $ => prec.dynamic(-1, choice(...bop lines...)),`

- [ ] **Step 2: Generate and run corpus tests**

```bash
cd /home/huawei/projects/tree-sitter-cangjie && python3 scripts/tsbuild.py
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test 2>&1 | tail -1
```

Expected: build OK; `successful parses: 16`.

- [ ] **Step 3: Verify the glue sites resolved**

```bash
python3 scripts/golden.py --dump cangjie_runtime/stdlib/libs/std/collection/concurrent/concurrent_hash_map.cj 2>/dev/null \
  > /tmp/opencode/rank/p2/b2_baseline/concurrent_hash_map.after.dump
diff <(grep -oE '\((assignment|binary)_expression' /tmp/opencode/rank/p2/b2_baseline/concurrent_hash_map.cj.dump | sort | uniq -c) \
     <(grep -oE '\((assignment|binary)_expression' /tmp/opencode/rank/p2/b2_baseline/concurrent_hash_map.after.dump | sort | uniq -c)
```

Expected: `variable_declaration` count rises by 5 in the after-dump; the diff shows
the binary/assignment glue counts dropping. If NOTHING changed, the tie is not
reaching tree comparison — stop, re-run the `;`-probe on this file to confirm the
tie still exists, and investigate before adding any more `prec.dynamic` wrappers.

- [ ] **Step 4: Probe suite — especially k4**

```bash
for f in k4 att1 att2 att3 b9 mm3 mx rune1 ue1 ue2 ue3 flat empty_blk at4 hl2; do
  p=/tmp/opencode/rank/p2/$f.cj; [ -f $p ] || continue
  r=$(timeout 3 env XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config \
    tree-sitter parse $p 2>/dev/null | grep -cE '\(ERROR|MISSING')
  echo "$f=$r"
done
```

Expected (baseline): `k4=0 att1=0 att2=0 att3=0 b9=0 mm3=0 mx=0 rune1=0 ue1=0 ue2=1
ue3=1 flat=0 empty_blk=0 at4=0 hl2=0`. Any deviation = STOP, revert the edit
(`git checkout grammar.js`), diagnose. ue2/ue3 are DESIGNED to report 1 contained
error each.

- [ ] **Step 5: Golden CI + accept**

```bash
cd /home/huawei/projects/tree-sitter-cangjie
python3 scripts/golden.py --ci --jobs 8 > /tmp/opencode/rank/p2/ci_b2a.log 2>&1; echo rc=$?; tail -1 /tmp/opencode/rank/p2/ci_b2a.log
```

Expected: 0 ERROR-REGRESSION; REGRESSION count small (tied files only — tens, not
thousands). If REGRESSION > 500 or any ERROR-REGRESSION: STOP, revert, diagnose.

```bash
python3 scripts/golden.py --update-all > /tmp/opencode/rank/p2/rebase_b2a.log 2>&1; tail -1 /tmp/opencode/rank/p2/rebase_b2a.log
python3 scripts/golden.py --ci --jobs 8 > /tmp/opencode/rank/p2/ci_b2b.log 2>&1; echo rc=$?; tail -1 /tmp/opencode/rank/p2/ci_b2b.log
```

Expected: rebase updates only the tied files; second CI prints `6017 ok ... 0
REGRESSION`.

- [ ] **Step 6: Commit**

```bash
cd /home/huawei/projects/tree-sitter-cangjie && git add -A && git commit -m "refactor(grammar): bias GLR ties away from binary glue

negative prec.dynamic on binary_expression tips surviving
statement-boundary-vs-continuation ties to the boundary reading,
matching what the ;-substitution experiment showed the real compiler
expects (cjc-legal in 19/19 files). Blanket item bias was rejected: it
would flip the foo()/{lambda} newline tie and break k4.
goldens rebased: 6017 ok / 0 REGRESSION"
```

### Task 4: B2 conditional — macro attach and assignment glue

**Files:**
- Modify: `grammar.js` (only if the corresponding check still fails)

- [ ] **Step 1: Check the macro-attach probe**

```bash
python3 scripts/golden.py --dump "cangjie_test/HLT/API/syntax/API/Decl/PropGetterOrSetter/PropGetterOrSetter_01.cj" 2>/dev/null | grep -cE "\(ERROR|MISSING"
```

Expected: `0`. If `0` → skip Steps 2–3 (Task 3 fixed it as a side effect). If ≥ 1 →
continue.

- [ ] **Step 2: Add negative dynamic to macro_expression (conditional)**

Find (current):

```js
        macro_expression: $ => seq(
```

Replace with:

```js
        macro_expression: $ => prec.dynamic(-1, seq(
```

and change the rule's closing `),` to `)),` (same pattern as Task 3 Step 1; the rule
ends right before `_macro_attr_body`).

- [ ] **Step 3: Re-gate (conditional only)**

Run Task 3 Steps 2–5 again in order. Expected: PropGetterOrSetter dump shows 0
errors; probe suite identical to baseline; CI green before and after rebase. Commit
with message `refactor(grammar): bias macro-attach ties to the attached reading`.

- [ ] **Step 4: Check for independent assignment glue**

```bash
python3 scripts/golden.py --ci --jobs 8 > /tmp/opencode/rank/p2/ci_b2_final.log 2>&1; tail -1 /tmp/opencode/rank/p2/ci_b2_final.log
grep -c "ERROR-COUNT INCREASED" /tmp/opencode/rank/p2/ci_b2_final.log
```

Expected: `6017 ok ... 0 REGRESSION`, `0`. (assignment_expression wrapping is only
warranted if a future CI shows ERROR-COUNT INCREASED files whose diffs are
assignment glue; not expected now. Do NOT wrap speculatively.)

### Task 5: Speed and error-node gates

**Files:**
- Modify: none

- [ ] **Step 1: Error-node count gate**

```bash
tail -1 /tmp/opencode/rank/p2/ci_b2_final.log
```

Expected: `error nodes in 777 files (1073 total)` or FEWER total nodes (Task 3/4 fix
errors; they must not add any). If total rose: identify the file via
`grep "ERROR-COUNT INCREASED"` (must be 0 from Task 4 Step 4) and investigate.

- [ ] **Step 2: Speed sweep on the heaviest files**

```bash
head -20 /tmp/opencode/rank/bench.tsv | cut -f5 | while read rel; do
  p="test/sources/$rel"
  [ -f "$p" ] || continue
  s=$( { time -p timeout 3 env XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config \
    tree-sitter parse -q "$p" ; } 2>&1 | grep real | awk '{print $2}' )
  echo "$s $rel"
done | sort -rn > /tmp/opencode/rank/p2/speed_b2.txt
cat /tmp/opencode/rank/p2/speed_b2.txt
```

Expected: every line under 3 s (no timeouts), total comparable to the pre-B2 sweep.
Gate: neutral or better. If a heavy file regressed > 20%, investigate its diff from
Task 3's rebase before pushing.

### Task 6: Push

**Files:**
- Modify: none

## Execution addendum (2026-09-10, recorded at final review)

- Task 3 shipped as `0c920558`: `prec.dynamic(-1)` on `binary_expression`; 413 golden
  flips, all glue-class (two systematic patterns: match-arm or-patterns
  `1|2|3` previously glued into spurious `binary_expression` — a real misparse class
  with a dedicated LLT test now parsed correctly — and cross-newline initializer glue).
- Task 4 shipped as `053c2a0a`: `prec.dynamic(-1)` on `macro_expression`; 111 golden
  flips, all standalone→attach (4,229 node flips total, 0 attach→standalone;
  expression-position standalone macros correctly kept).
- **Spec deviation, recorded:** the spec's success criterion "PropGetterOrSetter_01
  macro attaches (no ERROR)" is intentionally UNMET. Root cause is not a GLR tie but
  a missing grammar capability: `property_definition` (grammar.js ~456) parses a fixed
  getter/setter pair with no member-list structure, so a macro between accessors
  (`@Deprecated["bbbb"] set(v) {}`) poisons the whole property
  (`PropGetterOrSetter_01.cj` retains 1 ERROR). **Follow-up task recommended:**
  restructure the property body as a repeat of member items (getter / setter /
  macro-call-prefix / decorated member), gated by the standard discipline (tsbuild,
  corpus CI 0 ERROR-REGRESSION, rebase, error-count neutrality, probe stability).
- Nit for the same follow-up: the comment at grammar.js ~898-899 references
  `prec(PREC.MACRO_QUOTE)` which no longer exists (stale since before this branch);
  also `decorated_declaration` (attach margin 1) vs `decorated_member` (+1, margin 2)
  — a future +1 on `decorated_declaration` would make margins uniform.
- Final gates at HEAD `053c2a0a`: 16/16 corpus, 6017 ok / 0 REGRESSION, error nodes
  1073/777 (unchanged), k4 + probe suite at exact baseline, heavy-20 speed sweep
  smooth (slowest 0.18 s, zero timeouts).

- [ ] **Step 1: Final tree check and push**

```bash
cd /home/huawei/projects/tree-sitter-cangjie && git status --short | wc -l && git log --oneline error-recovery..terminator-boundary-bias && git push -u origin terminator-boundary-bias
```

Expected: clean tree; exactly the commits from Tasks 3–4 (+ any docs commits);
push succeeds. Do NOT merge into error-recovery — that decision belongs to the user.
