# Problematic Test Cases

This document records test cases that expose fundamental ambiguities or limitations in the tree-sitter-cangjie grammar.

## 1. Annotation vs Macro Expression Ambiguity

**File:** `test/sources/cangjie_test/LLT/compiler/Parser/ar/generic_in_expr_followed_commas/annotation.cj`

**Issue:** Cannot distinguish between annotation arguments (parsed expressions) and macro body (raw token streams) without semantic information.

**Example:**
```cangjie
@A[a < b, c >= d]
@B[f2<i32, i32>(d), 0]
public class C {}
```

**Current Behavior:**
- Parsed as `annotation` with `annotation_argument` containing parsed expressions
- `a < b` → `binary_expression`
- `f2<i32, i32>(d)` → `postfix_expression` with `type_arguments` and `call_suffix`

**Expected Behavior (per Cangjie spec):**
- Should be parsed as `macro_expression` with `macro_attribute_body` containing raw token streams
- Content inside `[...]` should be raw tokens, not parsed expressions

**Root Cause:**
Both `annotation` and `macro_expression` start with `@Name` and can have `[...]` or `(...)` bodies. Without knowing whether `A` or `B` are annotations or macros, the parser cannot determine whether to parse the content as expressions or raw tokens.

**Impact:**
- AST structure differs from Cangjie compiler's expectations
- Downstream tools (IDE, linter) may need to handle both interpretations
- This is a fundamental limitation of context-free grammars

**Potential Solutions:**
1. **Accept the ambiguity** - Document that annotations are parsed as expressions, macros as raw tokens, and let downstream tools disambiguate
2. **Unify to macro_expression only** - Remove `annotation` rule and treat all `@Name[...]` as macros with raw tokens (loses expression parsing)
3. **Special-case built-in annotations** - Add specific rules for known annotations like `@Deprecated`, `@Override`, etc. with expression arguments

**Status:** Known limitation, requires semantic information to resolve properly.

---

## 2. Unclosed Single-Line String Absorbing Following Lines — FIXED

**Files:** `test/recovery/10_unclosed_string.cj`, `test/sources/cangjie_test/LLT/Tools/cjfmt/test_cases/test/uilang/test.cj`

**Issue (historical):** When a single-line string was not closed before the
newline, the body repeat silently skipped the newline as an *extra* between
body items and absorbed following code into the string node — recoloring
everything below it in editors. The same extras mechanism also let binary
`as`-chains span statement boundaries.

**Fix (three parts):**
1. `token.immediate()` on the string body chunk and `$` item — extras can
   never be skipped between body items, so the closed path must finish on
   its opening line.
2. External `_line_string_tail_single/double` tokens: the scanner looks
   ahead to the newline and fires only when **no** closing quote exists on
   the line — consuming the rest of the line as an unterminated string at
   zero error cost. It never competes with the closed path (the scanner
   declines whenever the quote is found, rewinding the lexer).
3. The tail is `optional()` in the unterminated rule, so even a bare quote
   at end of line becomes a valid unterminated string — no MISSING-closer
   insertion, which previously cascaded into one ERROR blob when several
   unclosed strings shared a block.

**Result:** unclosed strings are contained to their own line; following
lines parse and color as if the string was closed. `test/recovery/
10_unclosed_string.cj` now recovers with **zero** error nodes (better than
its EXPECT). The refactoring also de-absorbed cross-line binary expressions
and split several golden-encoded misparses into honest, localized errors
(error *files* 1247 → 1250; error nodes reflect blob-splitting, not
degradation). Verified: 6017/6017 golden files pass.

**Status:** Fixed.

---

## 3. Comma-Space-Hash Sequence Swallows Raw String Opener (pre-existing)

**Minimal repro:**
```cangjie
@M(x.replace("\r",""), ##"raw
"##)
```

**Issue:** Inside a macro call body, the internal lexer produces a single
`macro_raw_token` matching `, ##` atomically (the regex `/[^()\\\[\]@'"]+/`
permits `,`, space, and `#`), so the external `_multi_line_raw_string_start`
scanner never gets called at the `##"` position — the raw string never opens.
Without a preceding comma (`@M(##"raw` …) the raw string opens correctly,
because there the scanner wins the longest-match competition (3 chars `##"`
vs 2 chars `##`).

**Verified pre-existing:** the golden (pre-refactoring) parser produces the
identical broken tree for this input; this is NOT caused by the
refactoring work.

**Potential fix:** none trivial — the internal lexer's greedy longest-match
from the comma position always beats the external scanner. Would require
excluding `#` from `macro_raw_token` (breaks `#` in macro content) or
restructuring macro-body lexing.

**Status:** Known pre-existing limitation.

---

## 4. Archaic `*`-Separated Tuple Types in the Corpus (won't fix)

**Files:** ~404 corpus files, ~4055 instances (e.g. `HLT/regression/testcase_338/...`, `testcase_128/test.cj`)

**Issue:** The corpus generator emitted tuple types with `*` as the element
separator: `(Bool*Int8)`, `(Float64*Int8*(Bool*Int8)*Int32)`. Modern Cangjie
(`cjc 1.2.0-alpha`) rejects them ("expected ')' here"); tuple types use `,`.
Values are emitted with normal commas, so types and values disagree.

**Decision (2026-09):** Keep as errors — the grammar targets current Cangjie,
not the archaic notation. Consequence: files dense with `*`-tuples keep
permanent local errors.

**Verification method:** `source ~/cangjie-sdk/cangjie/envsetup.sh && cjc
probe.cj` — always confirm a suspicious corpus construct against the real
compiler before calling it a grammar bug. Also verified this way: `name!: Type`
named parameters (valid, and already supported), range-with-step `a..b:c`
(valid), and `5&127..=9&127:2` (invalid — cjc groups `5 & (127..=9&127)`, i.e.
RANGE binds tighter than BIT_AND; our grammar deliberately accepts it as a
permissive superset via `PREC.RANGE = 12`).

---

## 5. Whole-File ERROR Condensation on Error-Dense Files (GLR cost race)

**Files:** `testcase_28/test_25.cj`, `test_28.cj`, `testcase_128/test.cj`,
`testcase_43.cj`, `testcase_232.cj`, `testcase_757.cj`,
`testcase_557/src/myType/annotation.cj` (byte-level fuzz corruption of valid
code: `let)a1_..._stat7c`, `tis.a2_purlic`, `@A1j12]` — one error per
mutation site, 740 total)

**Issue:** On files with many (permanently) invalid constructs, tree-sitter's
GLR sometimes emits the entire file as ONE `(ERROR [0,0] - [EOF])` node
wrapping cleanly-parsed children, instead of N small errors at each construct.

**Root cause (from `lib/src/error_costs.h`):** each recovery costs
`ERROR_COST_PER_RECOVERY = 500`; each visible tree an ERROR node absorbs costs
`ERROR_COST_PER_SKIPPED_TREE = 100`; versions further than
`18 * 100` behind the best are pruned. Fine-grained recovery pays ~500 per bad
construct; a whole-file blob pays 500 once plus 100 per absorbed declaration —
the two stay within the pruning window for the whole parse, and the survivor
is decided by local error order. The constructs themselves parse clean in
isolation (verified per-file); there is no grammar-side seed to fix.

**Mitigations already shipped:** `ERROR_SENTINEL` (stops the phantom
block-comment swallow that used to blob every error-dense file),
`PREC.RANGE = 12` (the corpus mask-range idiom `(x&127)..=(y&127):step` used
to misgroup and blob ~40 files), and annotation-decorated / paren-wrapped
parameters (`init(@A0 @A1[12] p0: Bool)`, `@M1[x] (b!: Int64)` — cjc-verified
syntax whose absence blobbed `testcase_557/.../class.cj`). Remaining blobs are
this cost race on archaic/corrupt content.

**Status:** Accepted upstream behavior; no per-grammar lever (constants are
compiled into libtree-sitter).

## Adding New Problematic Cases

When adding new problematic test cases, use this format:

```markdown
## N. Brief Title

**File:** `path/to/test.cj`

**Issue:** One-line description

**Example:**
```cangjie
// problematic code
```

**Current Behavior:**
- What the parser does now

**Expected Behavior:**
- What it should do (if known)

**Root Cause:**
- Why this happens

**Impact:**
- What breaks or is incorrect

**Potential Solutions:**
- Possible fixes (if any)

**Status:** Known limitation / Under investigation / Fixed in commit XYZ
```
