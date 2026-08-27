# Lexer & Parser Rework Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the lexer as a principled stateless ASI engine with fully externalized strings/quote/macro-body lexing, then restructure the parser hot spots (postfix-on-atoms, kill `atomic_variable`, pattern/arm separation, flat statement lists, coherent PREC), landing each phase green on the 6017-file corpus.

**Architecture:** Kotlin/Scala-style newline model (extras keep `/\s+/`, scanner emits `_terminator` + external continuation keywords), Scala-style uniform external string tokens, cmd-pattern external openers for `quote()`/macro bodies, then grammar-layer restructuring. Spec: `docs/superpowers/specs/2026-09-08-lexer-rework-design.md`.

**Tech Stack:** tree-sitter CLI (`tree-sitter generate/build/test/query`), `grammar.js` (DSL), `src/scanner.c`, golden harness `scripts/golden.py`, query files in `queries/`.

---

## Spec amendments (decided during planning, applied to spec)

1. **No bracket-context stack.** Kotlin's ASI engine proves the terminator decision can be stateless: `f(valid_symbols, lookahead)`. "Inside brackets → no terminator" is already enforced by the grammar never validating `_terminator` there. The stack was over-engineering; GLR-safe by construction instead.
2. **Continuation keywords** (`else/catch/finally/where`) become external string tokens. Their scanner emits the keyword only after skipping *whitespace* (never comments) — a comment between construct and keyword falls through to the extras path, preserving the comment as a visible node.
3. **Quote/macro-body escapes become raw content** (`quote_escape`, `macro_escape` nodes deleted; `\@`, `\(` etc. live inside content tokens). Strings inside bodies still parse as real `string_literal` nodes (content ends at quote chars).
4. **Keyword reservation relaxes** for the four externalized keywords: in non-continuation states they lex as plain `identifier` (`let where = 1` becomes parseable). Accepted permissiveness; corpus CI guards fallout.
5. **Modularization deferred.** `grammar.js` stays the single grammar file through all phases; the `grammar/` file split is postponed to its own stage, planned separately after this rework lands (mapping preserved at the end of this plan).

## Conventions (apply to every task)

- **Hard ban on in-code comments.** No `//`, `/* */`, or JS comments in any code written below or during execution. Rationale lives in docs.
- Build: `tree-sitter generate && tree-sitter build` (in repo root).
- Parse probes: `/tmp/opencode/ts-iso/ts parse FILE` (stdout = tree; stderr = summary; `--stat` for speed; `-c` for compact).
- Corpus CI: `XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config timeout 1800000 python3 scripts/golden.py --ci --jobs 1` (timeout ≥ 1800000 ms). Accept: same with `--update-all`.
- Corpus tests: `XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test` (fast gate; corpus files in `test/corpus/`).
- Queries: `for q in queries/*.scm; do tree-sitter query "$q" <any .cj> >/dev/null || echo FAIL; done`.
- Every phase ends with: corpus tests green → full CI green (audit diffs) → accept if intended → benchmark → commit.
- Commit messages: `refactor(lexer): ...` / `refactor(grammar): ...` style, one per task.

## File structure (end state)

| File | Responsibility |
|---|---|
| `src/scanner.c` | terminator + continuation keywords + comments + strings + quote/macro-body openers/content/closers + sentinel (23 external tokens, 10-byte state) |
| `grammar.js` | the only grammar file throughout this plan (all phases edit it in place; `grammar/` split is a deferred stage) |
| `queries/*.scm` | updated per phase where node shapes change |
| `test/corpus/*.txt` | fast characterization + behavior tests per phase |

---

## Phase 0 — Baseline & scaffolding

### Task 1: Capture baseline metrics

**Files:**
- Create: `docs/superpowers/plans/2026-09-08-lexer-rework-baseline.txt`

- [ ] **Step 1: Record metrics**

```bash
cd /home/huawei/projects/tree-sitter-cangjie
python3 -c "import json; print('conflicts:', len(json.load(open('src/grammar.json')).get('conflicts', [])))"
grep -o "STATE_COUNT [0-9]*" src/parser.c | head -1
wc -c src/parser.c src/scanner.c grammar.js
```
Expected: `conflicts: 19`, `STATE_COUNT 3303` (or current), sizes recorded.

- [ ] **Step 2: Record corpus + speed numbers**

```bash
python3 -c "
import gzip, glob
n=0; nodes=0
for f in glob.glob('test/golden/**/*.golden.gz', recursive=True):
    d=gzip.open(f).read()
    if b'(ERROR' in d: n+=1; nodes+=d.count(b'(ERROR')
print('error files:', n, 'error nodes:', nodes)
"
cd /tmp/opencode/rank && python3 bench.py >/dev/null 2>&1; grep -v "	inf	" bench.tsv | sort -t$'\t' -k1,1rn | head -20 > /home/huawei/projects/tree-sitter-cangjie/docs/superpowers/plans/2026-09-08-lexer-rework-baseline.txt
```
Expected: `error files: 858  error nodes: 6852` appended with top-20 table.

- [ ] **Step 3: Commit**

```bash
git add docs/superpowers/plans/ && git commit -m "docs: baseline metrics for lexer rework"
```

### Task 2: Corpus-test scaffolding + smoke test

**Files:**
- Create: `test/corpus/smoke.txt`

- [ ] **Step 1: Write smoke corpus test**

```
==================
package and function
==================
package foo

main() {
}
------------------
(translation_unit
  (package_declaration
    "package"
    (package_name
      (scoped_identifier
        (identifier))))
  (main_definition
    "main"
    (parameter_list)
    (block)))
```

- [ ] **Step 2: Verify exact tree shape**

```bash
cd /home/huawei/projects/tree-sitter-cangjie
/tmp/opencode/ts-iso/ts parse -c test/recovery/01_missing_terminator.cj >/dev/null 2>&1
printf 'package foo\n\nmain() {\n}\n' > /tmp/opencode/rank/smoke.cj
/tmp/opencode/ts-iso/ts parse /tmp/opencode/rank/smoke.cj 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g'
```
If the printed tree differs from the expected block above, correct `test/corpus/smoke.txt` to match the CURRENT tree (this is a characterization test).

- [ ] **Step 3: Run and pass**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: `✓ smoke` (or equivalent pass listing).

- [ ] **Step 4: Commit**

```bash
git add test/corpus/smoke.txt && git commit -m "test: corpus harness smoke test"
```

---

## Phase 1 — ASI engine + external continuation keywords

Behavior-preserving refactor: trees must NOT change (corpus CI must show zero diffs). External keyword tokens render identically to the internal `token('else')` literals they replace.

### Task 3: Characterization corpus tests

**Files:**
- Create: `test/corpus/continuation.txt`, `test/corpus/try_handlers_red.txt`

- [ ] **Step 1: Write tests encoding current correct behavior**

Cangjie if-branches REQUIRE blocks (`if (c) f()` is invalid source); catch patterns REQUIRE a type (`catch (e)` bare is invalid — the failure must localize inside the brackets per the Task 5 gate). Four characterization sections (all must parse 0 errors today): (a) block-bodied if with `else` on its own line — else attaches across newline; (b) same with `// comment` between `}` and `else` — comment stays a node AND else attaches; (c) local function inside block with `{` on next line; (d) class member `func f<T>(): T where T <: Numeric` (same line). Generate each expected tree from the CURRENT parser:

```bash
cd /tmp/opencode/rank
printf 'main() {\n  if (c) {\n    f()\n  }\n  else {\n    g()\n  }\n}\n' > k1.cj
printf 'main() {\n  if (c) {\n    f()\n  }\n  // c\n  else {\n    g()\n  }\n}\n' > k2.cj
printf 'main() {\n  func f(): Int64\n  {\n    1\n  }\n}\n' > k4.cj
printf 'class C {\n  func f<T>(): T where T <: Numeric {\n    1\n  }\n}\n' > k5.cj
for i in 1 2 4 5; do /tmp/opencode/ts-iso/ts parse k$i.cj 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g'; echo ---; done
```
All four must show 0 errors today (else/`{` suppression exists; class-body where works via flattened `_declaration_list`). Transcribe each output into `test/corpus/continuation.txt` sections with the source between `==================` markers and tree below `------------------`.

Then create `test/corpus/try_handlers_red.txt` — TWO sections, both RED now, both must go green at the Task 5 gate:

Section `try catch finally attach across newline` — typed pattern, multiline:
```
main() {
  try {
    1
  }
  catch (e: Exception) {
    2
  }
  finally {
    3
  }
}
```
Desired tree = byte-exact parse of the one-liner `main() { try { 1 } catch (e: Exception) { 2 } finally { 3 } }` (parses clean today).

Section `invalid catch pattern localizes error` — bare pattern (invalid Cangjie, but the failure MUST be localized inside the brackets, not destroy the construct):
```
main() {
  try {
    1
  }
  catch (e) {
    2
  }
  finally {
    3
  }
}
```
Desired tree (hand-crafted from grammar rules — untranscribable today because the current parse loses the whole structure): `try_expression` with `try_body`, a `catch_clause` containing `"catch"`, `"("`, an `(ERROR (var_binding_pattern))` region for `e` only, `")"`, and `catch_body: (block)`, plus `finally_body: (block)`. At the Task 5 gate, if recovery produces an equally-localized shape differing only in error-span edges, update the corpus expectation and proceed; if the structure is NOT preserved (no catch_clause or missing finally_body), that is a Task 5 BLOCKER requiring a grammar accommodation for the pattern-position recovery.

- [ ] **Step 2: Run and pass**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: all pass (guards the refactor).

- [ ] **Step 3: Commit**

```bash
git add test/corpus/ && git commit -m "test: characterization tests for continuations; red test for newline try-handlers"
```
Expected test state: continuation 4/4 + smoke pass; try_handlers_red 1 pass (typed) and 1 fail (bare/localization) — the fail is the Task 5 gate.

### Task 4+5 (AS BUILT — design superseded: keywords stay internal)

**Status: DONE (commit e4b73e67).** The planned design (externalize `else`/`catch`/`finally`/`where` as scanner tokens) was ABANDONED after implementation experiments:

- v1 (scanner skips whitespace, emits keyword): attaches, but shifts every keyword token start by the preceding whitespace — 886 golden diffs. Rejected: external token spans must match internal-lexer spans.
- v1.5 (emit only when sitting exactly on the word): never attaches — the internal lexer skips extras and consumes the keyword as an identifier within one lex request, so the scanner is not re-called at the word. Rejected.
- **v1.6 (shipped)**: all keywords stay INTERNAL in `_kw`. `scan_terminator` instead generalizes terminator suppression: `word_continues()` does a boundary-checked lookahead for `e`/`c`/`f`/`w` and suppresses the pending terminator before those four internal keywords. Externals remain the original 8 (TERMINATOR, BLOCK_COMMENT_CONTENT, RAW_STRING_*, LINE_STRING_TAIL_*, ERROR_SENTINEL). Scanner state: raw-string delimiter triple only. The original Task 4/5 code listings were stale and were removed; `src/scanner.c` as committed is authoritative.

Consequences:

- Spec amendment 4 (keyword reservation relaxation) is MOOT — reservation unchanged.
- `catch_clause` gained a paren-less fallback branch for the cjc-invalid `catch _ {` shape: `choice(seq('(', optional($.catch_pattern), ')'), $.catch_pattern)`. Invalid patterns inside parens localize as ERROR in the bracket region; `catch _ {` forms a clean clause (deterministic on lookahead — catch_pattern cannot start with `(`).

**Gate results:** corpus 7/7 (continuation 4/4, try_handlers 2/2 — both red gates green, smoke 1/1); CI `6017 files | 6017 ok | 0 REGRESSION | error nodes in 857 files (6845 total)`; 11 improvement-class diffs accepted (catch/finally/where attach across newlines; 0 ERROR-COUNT increases); speed unchanged (test_15 80ms, fuzz_0016 114ms).

---

## Phase 2 — Strings, quote bodies, macro bodies fully external

Node shapes change: `in_multi_line_string_expression` → `string_interpolation`; `quote_escape`, `macro_escape`, `quote_raw_token`, `macro_raw_token`, `macro_paren_group`, `macro_bracket_group`, `_line_string_tail_*` forms deleted. Queries updated in Task 10.

### Task 6: Red corpus tests

**Files:**
- Create: `test/corpus/strings.txt`, `test/corpus/quotes_macros.txt`

- [ ] **Step 1: Write desired-shape tests (they must FAIL on current parser)**

`test/corpus/strings.txt` sections: (a) closed line string with escape + interpolation `"a\n${x}b"`; (b) unterminated line string recovers at the newline as `string_literal` with content, NO error node; (c) multiline `"""` string with interpolation hole and escapes; (d) raw string `#"a"b"#`; (e) `$` alone in string (`"$5"`). `test/corpus/quotes_macros.txt` sections: (a) `quote( (a) $(x) "s" )` with nested parens and hole; (b) macro body `@M[a \@ b "s" c]` with escape, string, bare `@`; (c) unbalanced macro body `@M[a(b]` followed by more code — recovers at `]`, no file-swallow; (d) unterminated body `@M[abc` at EOF recovers.

Write each section as source + DESIRED tree (use the Task 4 node names; for (b)/(c)/(d) the tree contains `string_literal`/`macro_expression` nodes WITHOUT enclosing `(ERROR ...)`).

- [ ] **Step 2: Run — verify they fail**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: the new sections FAIL (current parser produces different shapes).

- [ ] **Step 3: Commit the failing tests**

```bash
git add test/corpus/ && git commit -m "test: desired-shape corpus tests for external strings and bodies (red)"
```

### Task 7: scanner.c (v2)

**Files:**
- Modify: `src/scanner.c` (replace entire file)

- [ ] **Step 1: Replace scanner.c**

Keep Tasks 4's terminator/keyword/block-comment functions byte-identical. New enum and state:

```c
enum TokenType {
  TERMINATOR,
  KW_ELSE,
  KW_CATCH,
  KW_FINALLY,
  KW_WHERE,
  BLOCK_COMMENT_CONTENT,
  LINE_STRING_START,
  LINE_STRING_CONTENT,
  LINE_STRING_END,
  MULTILINE_STRING_START,
  MULTILINE_STRING_CONTENT,
  MULTILINE_STRING_END,
  RAW_STRING_START,
  RAW_STRING_CONTENT,
  RAW_STRING_END,
  QUOTE_OPEN,
  QUOTE_CONTENT,
  QUOTE_CLOSE,
  MACRO_AT,
  MACRO_BODY_OPEN,
  MACRO_BODY_CONTENT,
  MACRO_BODY_CLOSE,
  ERROR_SENTINEL,
};

typedef struct {
  bool in_string;
  uint8_t delimiter_length;
  char quote;
  bool in_multiline;
  char ml_quote;
  uint8_t quote_depth;
  bool in_macro;
  char macro_kind;
  uint8_t macro_depth;
  char line_quote;
} Scanner;
```

Serialization (order fixed):

```c
unsigned tree_sitter_cangjie_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *s = (Scanner *)payload;
  buffer[0] = s->in_string;
  buffer[1] = (char)s->delimiter_length;
  buffer[2] = s->quote;
  buffer[3] = s->in_multiline;
  buffer[4] = s->ml_quote;
  buffer[5] = (char)s->quote_depth;
  buffer[6] = s->in_macro;
  buffer[7] = s->macro_kind;
  buffer[8] = (char)s->macro_depth;
  buffer[9] = s->line_quote;
  return 10;
}

void tree_sitter_cangjie_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
  Scanner *s = (Scanner *)payload;
  if (length >= 10) {
    s->in_string = buffer[0];
    s->delimiter_length = (uint8_t)buffer[1];
    s->quote = buffer[2];
    s->in_multiline = buffer[3];
    s->ml_quote = buffer[4];
    s->quote_depth = (uint8_t)buffer[5];
    s->in_macro = buffer[6];
    s->macro_kind = buffer[7];
    s->macro_depth = (uint8_t)buffer[8];
    s->line_quote = buffer[9];
  } else {
    s->in_string = false;
    s->delimiter_length = 0;
    s->quote = 0;
    s->in_multiline = false;
    s->ml_quote = 0;
    s->quote_depth = 0;
    s->in_macro = false;
    s->macro_kind = 0;
    s->macro_depth = 0;
    s->line_quote = 0;
  }
}
```

Line-string functions:

```c
static bool scan_line_start(TSLexer *lexer, enum TokenType sym) {
  if (lexer->lookahead != '"' && lexer->lookahead != '\'') return false;
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = sym;
  return true;
}

static bool scan_line_content(TSLexer *lexer, char quote, enum TokenType sym) {
  bool any = false;
  lexer->result_symbol = sym;
  while (lexer->lookahead != 0) {
    if (lexer->lookahead == '\n' || lexer->lookahead == '\r') break;
    if (lexer->lookahead == quote) break;
    if (lexer->lookahead == '\\') break;
    if (lexer->lookahead == '$') {
      lexer->mark_end(lexer);
      advance(lexer);
      if (lexer->lookahead == '{') return true;
      any = true;
      continue;
    }
    advance(lexer);
    any = true;
  }
  lexer->mark_end(lexer);
  return any;
}

static bool scan_line_end(TSLexer *lexer, char quote, enum TokenType sym) {
  if (lexer->lookahead != quote) return false;
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = sym;
  return true;
}
```

Multiline functions:

```c
static bool scan_multiline_start(TSLexer *lexer, Scanner *s, enum TokenType sym) {
  char q = lexer->lookahead;
  if (q != '"' && q != '\'') return false;
  advance(lexer);
  if (lexer->lookahead != q) return false;
  advance(lexer);
  if (lexer->lookahead != q) return false;
  advance(lexer);
  lexer->mark_end(lexer);
  s->in_multiline = true;
  s->ml_quote = q;
  lexer->result_symbol = sym;
  return true;
}

static bool scan_multiline_content(TSLexer *lexer, Scanner *s, enum TokenType sym) {
  if (!s->in_multiline) return false;
  bool any = false;
  lexer->result_symbol = sym;
  while (lexer->lookahead != 0) {
    if (lexer->lookahead == '\\') break;
    if (lexer->lookahead == '$') {
      lexer->mark_end(lexer);
      advance(lexer);
      if (lexer->lookahead == '{') return any;
      any = true;
      continue;
    }
    if (lexer->lookahead == s->ml_quote) {
      lexer->mark_end(lexer);
      advance(lexer);
      if (lexer->lookahead == s->ml_quote) {
        advance(lexer);
        if (lexer->lookahead == s->ml_quote) return true;
        any = true;
        continue;
      }
      any = true;
      continue;
    }
    advance(lexer);
    any = true;
  }
  lexer->mark_end(lexer);
  return any;
}

static bool scan_multiline_end(TSLexer *lexer, Scanner *s, enum TokenType sym) {
  if (!s->in_multiline || lexer->lookahead != s->ml_quote) return false;
  advance(lexer);
  if (lexer->lookahead != s->ml_quote) return false;
  advance(lexer);
  if (lexer->lookahead != s->ml_quote) return false;
  advance(lexer);
  lexer->mark_end(lexer);
  s->in_multiline = false;
  s->ml_quote = 0;
  lexer->result_symbol = sym;
  return true;
}
```

Raw-string functions: identical to Task 4 (rename only).

Quote functions:

```c
static bool scan_quote_open(TSLexer *lexer, Scanner *s) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r') skip(lexer);
  if (lexer->lookahead != 'q') return false;
  advance(lexer);
  if (!match_word_tail(lexer, "uote", 4)) return false;
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
  if (lexer->lookahead != '(') return false;
  advance(lexer);
  lexer->mark_end(lexer);
  s->quote_depth = 1;
  lexer->result_symbol = QUOTE_OPEN;
  return true;
}

static bool scan_quote_close(TSLexer *lexer, Scanner *s) {
  if (!s->quote_depth || lexer->lookahead != ')') return false;
  advance(lexer);
  lexer->mark_end(lexer);
  s->quote_depth = 0;
  lexer->result_symbol = QUOTE_CLOSE;
  return true;
}

static bool scan_quote_content(TSLexer *lexer, Scanner *s) {
  if (!s->quote_depth) return false;
  bool any = false;
  uint8_t depth = s->quote_depth;
  lexer->result_symbol = QUOTE_CONTENT;
  while (lexer->lookahead != 0) {
    char c = lexer->lookahead;
    if (c == '(') {
      depth++;
      advance(lexer);
      any = true;
      continue;
    }
    if (c == ')') {
      if (depth == 1) break;
      depth--;
      advance(lexer);
      any = true;
      continue;
    }
    if (c == '\\' || c == '"' || c == '\'') break;
    if (c == '$') {
      lexer->mark_end(lexer);
      advance(lexer);
      if (iswalpha(lexer->lookahead) || lexer->lookahead == '_' || lexer->lookahead == '(') return any;
      any = true;
      continue;
    }
    advance(lexer);
    any = true;
  }
  lexer->mark_end(lexer);
  return any;
}
```

Macro functions:

```c
static bool scan_macro_at(TSLexer *lexer) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
  if (lexer->lookahead != '@') return false;
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = MACRO_AT;
  return true;
}

static bool scan_macro_body_open(TSLexer *lexer, Scanner *s) {
  if (lexer->lookahead != '[' && lexer->lookahead != '(') return false;
  s->macro_kind = (char)lexer->lookahead;
  s->macro_depth = 1;
  s->in_macro = true;
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = MACRO_BODY_OPEN;
  return true;
}

static bool scan_macro_body_close(TSLexer *lexer, Scanner *s) {
  if (!s->in_macro || lexer->lookahead != s->macro_kind || s->macro_depth != 1) return false;
  advance(lexer);
  lexer->mark_end(lexer);
  s->in_macro = false;
  s->macro_depth = 0;
  s->macro_kind = 0;
  lexer->result_symbol = MACRO_BODY_CLOSE;
  return true;
}

static bool scan_macro_body_content(TSLexer *lexer, Scanner *s) {
  if (!s->in_macro) return false;
  bool any = false;
  lexer->result_symbol = MACRO_BODY_CONTENT;
  while (lexer->lookahead != 0) {
    char c = lexer->lookahead;
    if (c == '(' || c == '[' || c == '{') {
      s->macro_depth++;
      advance(lexer);
      any = true;
      continue;
    }
    if (c == s->macro_kind) {
      if (s->macro_depth == 1) break;
      s->macro_depth--;
      advance(lexer);
      any = true;
      continue;
    }
    if (c == '"' || c == '\'') break;
    advance(lexer);
    any = true;
  }
  lexer->mark_end(lexer);
  return any;
}
```

Main scan — final dispatch (branch order: sentinel → keywords → terminator → block comment → quote-run strings → line end/content → multiline content/end → raw → quote close/content → quote open → macro close/content → macro at/open):

```c
bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  if (valid_symbols[ERROR_SENTINEL]) return false;
  Scanner *s = (Scanner *)payload;

  if ((valid_symbols[KW_ELSE] || valid_symbols[KW_CATCH] ||
       valid_symbols[KW_FINALLY] || valid_symbols[KW_WHERE]) &&
      scan_keyword(lexer, valid_symbols)) return true;

  if (valid_symbols[TERMINATOR] && scan_terminator(lexer)) return true;

  if (valid_symbols[BLOCK_COMMENT_CONTENT] && scan_block_comment_content(lexer)) return true;

  if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
      (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
    char q = lexer->lookahead;
    uint8_t run = 0;
    while (lexer->lookahead == q && run < 3) {
      advance(lexer);
      run++;
    }
    if (run >= 3 && valid_symbols[MULTILINE_STRING_START]) {
      lexer->mark_end(lexer);
      s->in_multiline = true;
      s->ml_quote = q;
      lexer->result_symbol = MULTILINE_STRING_START;
      return true;
    }
    if (run >= 1 && valid_symbols[LINE_STRING_START]) {
      lexer->mark_end(lexer);
      s->line_quote = q;
      lexer->result_symbol = LINE_STRING_START;
      return true;
    }
    return false;
  }

  if (valid_symbols[LINE_STRING_END] && s->line_quote) {
    if (scan_line_end(lexer, s->line_quote, LINE_STRING_END)) {
      s->line_quote = 0;
      return true;
    }
  }

  if (valid_symbols[LINE_STRING_CONTENT] && s->line_quote) {
    if (scan_line_content(lexer, s->line_quote, LINE_STRING_CONTENT)) return true;
  }

  if (valid_symbols[MULTILINE_STRING_CONTENT] && s->in_multiline) {
    if (scan_multiline_content(lexer, s, MULTILINE_STRING_CONTENT)) return true;
  }

  if (valid_symbols[MULTILINE_STRING_END] && s->in_multiline) {
    if (scan_multiline_end(lexer, s, MULTILINE_STRING_END)) return true;
  }

  if (valid_symbols[RAW_STRING_START] && !s->in_string && lexer->lookahead == '#') {
    return scan_raw_open(lexer, s);
  }
  if (valid_symbols[RAW_STRING_CONTENT] && s->in_string) {
    return scan_raw_content(lexer, s);
  }
  if (valid_symbols[RAW_STRING_END] && s->in_string && lexer->lookahead == s->quote) {
    return scan_raw_close(lexer, s);
  }

  if (valid_symbols[QUOTE_CLOSE] && scan_quote_close(lexer, s)) return true;
  if (valid_symbols[QUOTE_CONTENT] && scan_quote_content(lexer, s)) return true;
  if (valid_symbols[QUOTE_OPEN] && scan_quote_open(lexer, s)) return true;

  if (valid_symbols[MACRO_BODY_CLOSE] && scan_macro_body_close(lexer, s)) return true;
  if (valid_symbols[MACRO_BODY_CONTENT] && s->in_macro) {
    if (scan_macro_body_content(lexer, s)) return true;
  }
  if (valid_symbols[MACRO_BODY_OPEN] && scan_macro_body_open(lexer, s)) return true;
  if (valid_symbols[MACRO_AT] && scan_macro_at(lexer)) return true;

  return false;
}
```

**Dispatch invariants:**

1. `scan_line_start` sets `s->line_quote`; the dispatch clears it only after a successful `scan_line_end`.
2. Empty content chunks (`scan_line_content`/`scan_multiline_content`/`scan_quote_content`/`scan_macro_body_content` returning false) fall through to the next branches or the final `return false`; the internal lexer then lexes the boundary token (`escape_sequence`, `${`, terminator, …) from the rewound position.
3. Multiline content `$`-peek that returns with `any == false` (empty chunk at a hole) falls through; the grammar lexes `${` internally.
4. When both `LINE_STRING_END` and `LINE_STRING_CONTENT` are valid and lookahead is the quote char, END wins (dispatch order above).
5. `scan_terminator`, `scan_keyword`, and `scan_block_comment_content` are byte-identical to Task 4.

- [ ] **Step 2: Do NOT build yet (externals must change first — Task 8)**

### Task 8: Grammar — string/quote/macro rules

**Files:**
- Modify: `grammar.js` (externals, string rules ~line 971–1005, quote rules ~line 888–919, macro rules ~line 845–871, annotation line 576)

- [ ] **Step 1: Update externals**

```js
    externals: $ => [
        $._terminator,
        $._kw_else,
        $._kw_catch,
        $._kw_finally,
        $._kw_where,
        $._block_comment_content,
        $._line_string_start,
        $._line_string_content,
        $._line_string_end,
        $._multiline_string_start,
        $._multiline_string_content,
        $._multiline_string_end,
        $._raw_string_start,
        $._raw_string_content,
        $._raw_string_end,
        $._quote_open,
        $._quote_content,
        $._quote_close,
        $._macro_at,
        $._macro_body_open,
        $._macro_body_content,
        $._macro_body_close,
        $._error_sentinel,
    ],
```

- [ ] **Step 2: Replace string rules**

Delete `lineStr`, `multiLineStr` helpers (lines 43–50) and all of: `_line_string_literal`, `_line_string_unterminated_single`, `_line_string_unterminated_double`, `_multi_line_string_literal`, `in_multi_line_string_expression`, `_multi_line_raw_string_literal`. Insert:

```js
        string_literal: $ => choice($._line_string, $._multiline_string, $._raw_string),

        _line_string: $ => seq(
            $._line_string_start,
            repeat(choice($._line_string_content, $.escape_sequence, $.string_interpolation)),
            optional($._line_string_end),
        ),

        _multiline_string: $ => seq(
            $._multiline_string_start,
            optional(seq(optional(/\r/), /\n/)),
            repeat(choice($._multiline_string_content, $.escape_sequence, $.string_interpolation)),
            optional($._multiline_string_end),
        ),

        _raw_string: $ => seq(
            $._raw_string_start,
            optional($._raw_string_content),
            optional($._raw_string_end),
        ),

        string_interpolation: $ => seq(
            '${',
            optional(seq(
                $._interpolation_statement,
                repeat(seq(repeat1(terminator($)), $._interpolation_statement)),
            )),
            '}',
        ),

        _interpolation_statement: $ => choice($.variable_declaration, $._expression),
```

- [ ] **Step 3: Replace quote rules**

Delete `quote_expression`'s old body, `_quote_body_item`, `quote_paren_group`, `quote_interpolation`, `quote_escape`, `quote_raw_token`. Also delete `quote` from the `_kw(...)` string and `TOKENS.QUOTE` references. Insert:

```js
        quote_expression: $ => prec(PREC.MACRO_QUOTE, seq(
            $._quote_open,
            repeat($._quote_body_item),
            $._quote_close,
        )),

        _quote_body_item: $ => choice(
            $._quote_content,
            $.string_literal,
            $.rune_literal,
            $.quote_interpolation,
            $._dollar_identifier,
        ),

        quote_interpolation: $ => seq('$', '(', $._expression, ')'),
```

- [ ] **Step 4: Replace macro rules**

Delete `macro_paren_group`, `macro_bracket_group`, `macro_escape`, `macro_raw_token`. Update `annotation` (line 576) and `macro_expression` (line 850):

```js
        annotation: $ => seq(
            $._macro_at, optional('!'),
            alias(seq(repeat(seq($.identifier, '.')), $.identifier), $.annotation_name),
            optional(seq('[', $._annotation_argument_list, ']'))
        ),
```

```js
        macro_expression: $ => prec(PREC.MACRO_QUOTE, seq(
            $._macro_at,
            optional('!'),
            $._macro_name,
            optional($._macro_body),
        )),

        _macro_body: $ => seq(
            $._macro_body_open,
            repeat($._macro_body_item),
            optional($._macro_body_close),
        ),

        _macro_body_item: $ => choice(
            $._macro_body_content,
            $.string_literal,
            $.rune_literal,
        ),
```

- [ ] **Step 5: Build**

```bash
tree-sitter generate && tree-sitter build
```
Expected: generate may demand new conflicts — add ONLY what it names (likely `[$._macro_body_content]` or string-adjacent groups) to `conflicts`, then re-generate until clean. Record each demanded conflict in the commit message.

- [ ] **Step 6: Corpus tests green**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: Task 6 tests pass. Iterate: if an expected tree is structurally reasonable but differs cosmetically, adjust the corpus test (not the grammar) ONLY when the difference does not lose information (e.g. alias naming); if information is lost (error where clean expected), fix the scanner/grammar.

- [ ] **Step 7: Recovery spot-checks**

```bash
printf 'main() { let s = "abc\n  let x = 1\n}\n' > /tmp/opencode/rank/s1.cj
printf '@M[a(b]\nmain() {}\n' > /tmp/opencode/rank/s2.cj
printf 'macro package m\nmacro @M() {}\nmain() { @M[ok] }\n' > /tmp/opencode/rank/s3.cj
for i in 1 2 3; do /tmp/opencode/ts-iso/ts parse /tmp/opencode/rank/s$i.cj 2>&1 | tail -1; done
```
Expected: s1 — string recovers at the newline, following lines parse as code; s2 — body recovers at `]`, `main` parses; s3 — clean.

### Task 9: Query updates

**Files:**
- Modify: `queries/highlights.scm`

- [ ] **Step 1: Apply edits**

Replace `(in_multi_line_string_expression "${" @punctuation.special)` and its `"}"` line with:

```scheme
(string_interpolation "${" @punctuation.special)
(string_interpolation "}" @punctuation.special)
```

Delete the `(quote_escape) @string.escape` and `(macro_escape) @string.escape` lines.

- [ ] **Step 2: Validate all queries**

```bash
for q in queries/*.scm; do XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter query "$q" /tmp/opencode/rank/s3.cj > /dev/null 2>&1 && echo "OK $q" || echo "FAIL $q"; done
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter highlight test/sources/cangjie_test/HLT/regression/testcase_589.cj > /dev/null && echo "highlight ok"
```
Expected: all OK, highlight renders.

### Task 10: Phase 2 gate

- [ ] **Step 1: Full CI + audit**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config timeout 1800000 python3 scripts/golden.py --ci --jobs 1 2>&1 | tail -1
```
Expected: error files ≤ 858 AND error nodes ≤ 6852. Audit: `grep "ERROR-COUNT INCREASED"` count must be ≤ 10; each one either (a) string/quote/macro recovery improvement candidate — accept, or (b) real regression — fix scanner before proceeding.

- [ ] **Step 2: Accept + benchmark**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config python3 scripts/golden.py --update-all 2>&1 | tail -1
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config python3 scripts/golden.py --ci --jobs 1 2>&1 | tail -1
```

- [ ] **Step 3: Commit**

```bash
git add -A && git commit -m "refactor(lexer): externalize strings, quote bodies, macro bodies; single uniform mechanism"
```

---

## Phase 3 — Postfix on atoms, kill atomic_variable

### Task 11: Red corpus tests

**Files:**
- Create: `test/corpus/expressions.txt`

- [ ] **Step 1: Write desired-shape tests**

Sections: (a) chained calls/fields `a.b(c)[d]?.e()` — flat `postfix_expression` with repeated suffix children, NO nested `atomic_variable`/`var_binding_pattern` in expression trees; (b) generic reference `x<Int64>(y)`; (c) `x < y > (z)` disambiguation — document the chosen reading from the current parser's accepted golden (characterization: extract from existing golden for a file containing this shape); (d) field access target with type args `Foo<Int64>.bar()`. Generate trees with the current parser for (c) from its golden; write DESIRED trees for (a)/(b)/(d) using `identifier` (no `atomic_variable`).

- [ ] **Step 2: Verify red where behavior changes**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: (a)/(b)/(d) fail (atomic_variable present today).

- [ ] **Step 3: Commit red tests**

```bash
git add test/corpus/expressions.txt && git commit -m "test: expression-layer desired shapes (red)"
```

### Task 12: Expression-layer restructure

**Files:**
- Modify: `grammar.js` (expression rules ~lines 590–730, declarations using `atomic_variable`)

- [ ] **Step 1: Replace the expression core**

```js
        _expression: $ => choice(
            $.postfix_expression,
            $.unary_expression,
            $.binary_expression,
            $.is_expression,
            $.as_expression,
            $.assignment_expression,
        ),

        _primary_expression: $ => choice(
            $._literal,
            $.array_literal,
            $.identifier,
            $.generic_identifier,
            $.parenthesized_expression,
            $.tuple_expression,
            $.range_expression,
            $.lambda_expression,
            $.jump_expression,
            $.synchronized_expression,
            $.spawn_expression,
            $.perform_expression,
            $.resume_expression,
            $.unsafe_expression,
            $.this_super_expression,
            $.if_expression,
            $.match_expression,
            $._loop_expression,
            $.try_expression,
            $.quote_expression,
            $.macro_expression,
            $.let_pattern_destructor,
            $._dollar_identifier,
            $._dollar_call,
        ),

        postfix_expression: $ => choice(
            $._primary_expression,
            prec.right(seq(
                field('base', $.postfix_expression),
                field('suffix', $._postfix_suffix),
            )),
        ),

        _postfix_suffix: $ => choice(
            prec(PREC.MEMBER, $.field_access),
            prec(PREC.MEMBER, $.scope_resolution),
            prec(PREC.ARRAY, $.index_access),
            prec(PREC.POSTFIX, $.quest_access),
            prec(PREC.PARENS, $.call_suffix),
            prec(PREC.POSTFIX, $.inc_or_dec),
            $.trailing_lambda_expression,
        ),

        generic_identifier: $ => seq(
            field('name', $.identifier),
            field('arguments', $.type_arguments),
        ),
```

- [ ] **Step 2: Retarget all `atomic_variable` users**

```js
        field_access: $ => seq('.', choice($.identifier, $.generic_identifier)),
        scope_resolution: $ => seq('::', choice($.identifier, $.generic_identifier)),
```

In `call_suffix`: replace `seq($._var_binding_pattern, ':', $._expression)` with `seq($.identifier, ':', $._expression)`; replace `seq(TOKENS.INOUT, optional(seq($._expression, '.')), $._var_binding_pattern)` with `seq(TOKENS.INOUT, optional(seq($._expression, '.')), $.identifier)`.

Delete the `atomic_variable` rule AND the old `_atomic_expression` rule. Retarget `_assignable` to the new primary layer:

```js
        _assignable: $ => prec(1, choice(
            $._primary_expression,
            $.unary_expression,
            $.binary_expression,
            $.is_expression,
            $.as_expression,
        )),
```

Search for remaining references: `grep -n "atomic_variable\|_atomic_expression" grammar.js` must return nothing except `_constant_pattern`'s alias (which uses `_literal`, not `_atomic_expression` — verify).

- [ ] **Step 3: Build — add only demanded conflicts**

```bash
tree-sitter generate && tree-sitter build
```
For each conflict the generator names, add it to `conflicts` with a one-line rationale recorded in the commit message (not in code). Expected candidates: `[$.generic_identifier]`, `[$.postfix_expression]`, `[$.call_suffix]` (already present).

- [ ] **Step 4: Query updates (expression side)**

`queries/locals.scm` line 23: `(atomic_variable) @local.reference` → `(identifier) @local.reference`.
`queries/highlights.scm` lines 237–249: replace `(atomic_variable)` captures per context — `(atomic_variable) @function` inside call-suffix contexts becomes `(identifier) @function` with the same outer pattern structure (adjust child field paths: `var_binding_pattern` wrappers disappear; the identifier is now direct).

- [ ] **Step 5: Corpus tests + CI gate**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
for q in queries/*.scm; do XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter query "$q" /tmp/opencode/rank/s3.cj > /dev/null 2>&1 && echo "OK $q" || echo "FAIL $q"; done
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config timeout 1800000 python3 scripts/golden.py --ci --jobs 1 2>&1 | tail -1
```
Expected: corpus tests pass; queries OK; CI error files ≤ 858. The diff set will be LARGE (tree-shape change) — audit the ERROR-COUNT INCREASED list only; accept the rest.

- [ ] **Step 6: Accept + bench + commit**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config python3 scripts/golden.py --update-all 2>&1 | tail -1
python3 /tmp/opencode/rank/bench.py >/dev/null 2>&1
git add -A && git commit -m "refactor(grammar): postfix on atoms, remove atomic_variable"
```

---

## Phase 4 — Patterns/arms, flat statement lists, PREC ladder

### Task 13: Match arms take patterns

**Files:**
- Modify: `grammar.js` (match rules ~lines 780–800, pattern rules ~lines 249–280)

- [ ] **Step 1: Restructure arms**

```js
        match_expression: $ => seq(
            TOKENS.MATCH,
            optional(seq('(', field('condition', $._expression), ')')),
            '{',
            repeat1(choice($.match_case, $.match_case_body)),
            '}'
        ),
        match_case: $ => seq(
            TOKENS.CASE, sep1($._pattern, '|'), optional($.pattern_guard),
            token('=>'),
            $._expression_or_declarations, optional(repeat1(terminator($))),
        ),
        match_case_body: $ => seq(
            TOKENS.CASE, choice($._expression, '_'), token('=>'),
            $._expression_or_declarations, optional(repeat1(terminator($))),
        ),
```
Keep `match_case_body` for bare-identifier/expression cases (corpus uses it); extend `_pattern` with an alias for constant expressions so `case 3 =>` / `case x =>` route through patterns where possible:

```js
        _constant_pattern: $ => alias(choice($._literal, seq('-', $._literal)), $.constant_pattern),
```
 stays; do NOT merge `_expression` into `_pattern` in this task. The goal is only to flatten the statement list below arms and remove `[$.wildcard_pattern, $.match_case_body]` if generate no longer demands it.

- [ ] **Step 2: Build; drop conflicts generate stops demanding**

```bash
tree-sitter generate
```
Remove from `conflicts` any group the generator reports unnecessary (candidates: `[$.wildcard_pattern, $.match_case_body]`). Never leave an unnecessary conflict (generate warns).

### Task 14: Flat statement lists

**Files:**
- Modify: `grammar.js` (block line 284, `_expression_or_declarations` line 289, `trailing_lambda_expression` line 730, `lambda_expression` line 749, `match_case`/`match_case_body` from Task 13)

- [ ] **Step 1: Flatten**

```js
        block: $ => seq(
            '{',
            optional($._expression_or_declarations),
            '}',
        ),

        _expression_or_declarations: $ => repeat1(seq(
            optional(repeat1(token(';'))),
            choice(
                $.variable_declaration,
                $.function_definition,
                $._expression,
            ),
        )),
```

In `trailing_lambda_expression` and `lambda_expression`, replace `optional(seq($._expression_or_declarations, repeat(terminator($))))` and `optional(seq($._expression_or_declarations, optional(repeat1(terminator($)))))` with `optional($._expression_or_declarations)`. In `match_case`/`match_case_body`, drop the `optional(repeat1(terminator($)))` tails (the flattened list consumes `;` runs; newlines are extras).

- [ ] **Step 2: Build + tests**

```bash
tree-sitter generate && tree-sitter build
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
```
Expected: pass. Regression probes from Phase 1 (`k4.cj` next-line brace) must still parse.

### Task 15: PREC ladder

**Files:**
- Modify: `grammar.js` (PREC table lines 14–24)

- [ ] **Step 1: Replace the table (relative order preserved, duplicates removed)**

```js
const PREC = {
    COMMENT: 0,
    ASSIGN: 1,
    PIPE: 2,
    COALESCE: 3,
    RANGE: 4,
    OR: 5,
    AND: 6,
    BIT_OR: 7,
    BIT_XOR: 8,
    BIT_AND: 9,
    EQUALITY: 10,
    REL: 11,
    SHIFT: 12,
    ADD_SUB: 13,
    MUL_DIV: 14,
    POWER: 15,
    UNARY: 16,
    POSTFIX: 17,
    PARENS: 18,
    ARRAY: 19,
    MEMBER: 20,
    MARCO_CALL: 21,
    MACRO_QUOTE: 22,
    TOKEN: 23,
    INIT: -1,
    STATIC_INIT: -2,
    RESERVED_ID: -3,
};
```
Fix `MARCO_CALL` → `MACRO_CALL` and update its single use site. Keep the three negatives; verify each by parsing its motivating case: `init` (probe: `class C { init(x: Int64) { } }`), `static_init` (`static init()`), reserved-id (`let open = 1`). If a negative proves unnecessary (parse clean without), delete it.

- [ ] **Step 2: Conflict-count assert**

```bash
tree-sitter generate && tree-sitter build
python3 -c "import json; c=json.load(open('src/grammar.json')).get('conflicts', []); print('conflicts:', len(c)); assert len(c) <= 8, c"
```
Expected: ≤ 8. If above 8, list the groups, attempt one structural resolution each (e.g. `modifiers` via `prec` on the declaration rule); do NOT accept > 8 without user sign-off.

### Task 16: Phase 4 gate

- [ ] **Step 1: CI + accept + bench + commit**

```bash
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config timeout 1800000 python3 scripts/golden.py --ci --jobs 1 2>&1 | tail -1
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config python3 scripts/golden.py --update-all 2>&1 | tail -1
python3 /tmp/opencode/rank/bench.py >/dev/null 2>&1
git add -A && git commit -m "refactor(grammar): pattern arms, flat statement lists, coherent precedence ladder"
```
Expected: error files ≤ 858, nodes ≤ 6852, top-20 bench improved or flat vs baseline file.

---

## Phase 5 — Extras upgrade, docs, final metrics

### Task 17: Upgrade extras to multi-char whitespace runs

**Files:**
- Modify: `grammar.js` (extras block)

- [ ] **Step 1: Apply**

```js
    extras: $ => [
        /\s+/,
        $.line_comment,
        $.block_comment,
    ],
```

- [ ] **Step 2: Verify zero tree churn**

```bash
tree-sitter generate && tree-sitter build
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config tree-sitter test
XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config timeout 1800000 python3 scripts/golden.py --ci --jobs 1 2>&1 | tail -1
```
Expected: `6017 ok`, zero diffs. If any DIFF appears, revert this task (`git checkout grammar.js`) and record it as a follow-up — whitespace-run extras are an optimization, not a requirement.

- [ ] **Step 3: Commit**

```bash
git add grammar.js src/ && git commit -m "refactor(lexer): multi-char whitespace extras"
```

### Task 18: Docs + final metrics

**Files:**
- Modify: `docs/EXTERNAL_SCANNER_NOTES.md`, `docs/PROBLEMATIC_TEST_CASES.md`, spec status line

- [ ] **Step 1: Rewrite scanner notes** — new token table (23 externals), stateless-ASI description, GLR-safe-state invariant, updated speed table from `bench.py`.

- [ ] **Step 2: Update spec** — mark Status: implemented; fold in the four amendments from this plan's header.

- [ ] **Step 3: Final metrics vs baseline**

```bash
python3 -c "import json; print('conflicts:', len(json.load(open('src/grammar.json')).get('conflicts', [])))"
python3 -c "
import gzip, glob
n=0; nodes=0
for f in glob.glob('test/golden/**/*.golden.gz', recursive=True):
    d=gzip.open(f).read()
    if b'(ERROR' in d: n+=1; nodes+=d.count(b'(ERROR')
print('error files:', n, 'error nodes:', nodes)
"
diff docs/superpowers/plans/2026-09-08-lexer-rework-baseline.txt <(cd /tmp/opencode/rank && python3 bench.py >/dev/null 2>&1; grep -v "	inf	" bench.tsv | sort -t$'\t' -k1,1rn | head -20)
```
Success criteria: conflicts ≤ 8; error files ≤ 858; nodes ≤ 6852; top-20 times improved or flat; all queries validate.

- [ ] **Step 4: Commit**

```bash
git add docs/ && git commit -m "docs: lexer rework completion notes and final metrics"
```

---

## Deferred stage — grammar/ modularization

Out of scope for this plan (user decision): `grammar.js` remains the single
grammar file through all phases. The file split below becomes its own plan,
written and executed after this rework lands. The mapping is preserved here
so the future plan can reuse it verbatim:

| Module | Rules |
|---|---|
| `grammar/precedences.js` | `PREC` |
| `grammar/tokens.js` | `newline`, `_kw`, `TOKENS`, `hexDigit`, `hexDigits`, `decimalDigits`, `decimalLiteral`, `uniCharacterLiteral` |
| `grammar/helpers.js` | `sep1`, `commaSep1Trailing`, `terminator`, `bop`, `typeTail`, `typeHeader` |
| `grammar/literals.js` | `line_comment`, `block_comment`, `_reserved_identifier`, `identifier`, `_dollar_identifier`, `_literal`, numeric/rune/byte/boolean/string rules, `string_interpolation`, `_interpolation_statement`, `unit_literal` |
| `grammar/types.js` | `*_type`/`_type` family, `type_arguments`, `type_parameters`, `generic_constraints`, `generic_constraint`, `return_type`, `super_or_interface`, `_super_interfaces` |
| `grammar/declarations.js` | `translation_unit`, package/import/`features_directive`, `modifiers`, function/init/property/finalizer definitions, type definitions + bodies, `variable_declaration`, `block` |
| `grammar/expressions.js` | `_expression`, `_primary_expression`, `postfix_expression`, `_postfix_suffix`, `generic_identifier`, access/call/index suffix rules, operators, control-flow expressions, `_expression_or_declarations`, `_assignable`, `let_pattern_destructor`, `_dollar_call` |
| `grammar/patterns.js` | `_pattern` family, pattern_guard, `_patterns_maybe_irrefutable`, `_var_binding_pattern`, `_name` |
| `grammar/macros.js` | `annotation` family, `macro_expression`, `_macro_body*`, `_macro_name`, `decorated_*`, `quote_expression` family |
| `grammar/conflicts.js` | `conflicts` array |

Name-prefix (`_`) rules keep their exact names — node-types depend on them.


## Risk register

| Risk | Mitigation |
|---|---|
| External keywords relax reservation (`let else = 1` parses) | CI audit per file class; accept (permissive direction); revert individual keyword to internal if a corpus file relies on the error |
| GLR-shared scanner state misread across live string versions | state read only under valid_symbols gating; strings start unambiguously (longest-match quote runs); corpus audit in Task 10 |
| Zero-diff expectation in Phase 1 broken by keyword-as-identifier | investigate DIFF files for `else|catch|finally|where` identifier usage; accept only previously-erroring files |
| Phase 3 diff volume (tree-shape churn) | audit only ERROR-COUNT INCREASED; everything else is mechanical rename |
| Conflict creep past 8 | generate-driven removal each phase; user sign-off gate before accepting > 8 |

### Task 19 (FOLLOW-UP, after grammar rework): Highlighting polish

**Status:** pending — deferred by user decision ("Need to add this as separate task after we rework grammar").

**Context:** the everything-as-macro redesign (external tokens for macro/quote/string structure) left several
constructs without visible coloring in `tree-sitter highlight`. Already landed as part of the macro redesign:
`(macro_call_sigil)`, `(quote_keyword)`, `(quote_interpolation) @punctuation.special`.

**Remaining work:**

- [ ] Audit `queries/highlights.scm` against every named node in `src/node-types.json` (annotation nodes were
      deleted; `macro_attribute_body` / `macro_call_body` / `macro_call_prefix` / `string_interpolation` are new).
- [ ] Decide the capture for `quote_raw_token` / `macro_raw_token` — currently `@markup.raw`, which the
      tree-sitter CLI's built-in theme does not style (renders uncolored; editors style it as verbatim).
- [ ] Color macro attribute bodies' operators/literals where raw tokens swallow them.
- [ ] Verify `tree-sitter highlight` over a stdlib file, a HLT macro file, and the probe suite; compare against
      pre-redesign captures.
- [ ] Re-run `--update-all` if the audit introduces grammar-side aliases.
