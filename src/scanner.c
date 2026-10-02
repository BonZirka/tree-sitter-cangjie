#include "tree_sitter/parser.h"
#include <wctype.h>
#include <string.h>
#include <stdio.h>

enum TokenType {
  TERMINATOR,
  BLOCK_COMMENT_CONTENT,
  LINE_STRING_START,
  LINE_STRING_CONTENT,
  LINE_STRING_END,
  MULTILINE_STRING_START,
  MULTILINE_STRING_CONTENT,
  MULTILINE_STRING_END,
  INTERP_OPEN,
  INTERP_CLOSE,
  BRACE_OPEN,
  BRACE_CLOSE,
  RAW_STRING_START,
  RAW_STRING_CONTENT,
  RAW_STRING_END,
  QUOTE_OPEN,
  QUOTE_CONTENT,
  QUOTE_PAREN_OPEN,
  QUOTE_PAREN_CLOSE,
  QUOTE_INTERP_OPEN,
  QUOTE_INTERP_CLOSE,
  QUOTE_CLOSE,
  MACRO_AT,
  MACRO_ATTR_OPEN,
  MACRO_BODY_CONTENT,
  MACRO_ATTR_CLOSE,
  MACRO_INPUT_OPEN,
  MACRO_INPUT_CLOSE,
  ERROR_SENTINEL,
  GENERIC_LT,
};

#define CTX_NONE 0
#define CTX_LINE_STRING 1
#define CTX_MULTILINE_STRING 2
#define CTX_INTERP 3
#define CTX_BRACE 4
#define CTX_RAW_STRING 5
#define CTX_QUOTE 6
#define CTX_QUOTE_PAREN 7
#define CTX_QUOTE_INTERP 8
#define CTX_MACRO_BODY 9

#define STACK_MAX 32

typedef struct {
  uint8_t kinds[STACK_MAX];
  char params[STACK_MAX];
  char params2[STACK_MAX];
  char macro_openers[8];
  uint8_t macro_openers_top;
  uint8_t top;
} Scanner;

static void advance(TSLexer *lexer) {
  lexer->advance(lexer, false);
}

static void skip(TSLexer *lexer) {
  lexer->advance(lexer, true);
}

void *tree_sitter_cangjie_external_scanner_create() {
  return calloc(1, sizeof(Scanner));
}

void tree_sitter_cangjie_external_scanner_destroy(void *payload) {
  free(payload);
}

unsigned tree_sitter_cangjie_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *s = (Scanner *)payload;
  if (s->top > STACK_MAX) s->top = STACK_MAX;
  if (s->macro_openers_top > 8) s->macro_openers_top = 8;
  buffer[0] = (char)s->top;
  for (uint8_t i = 0; i < s->top; i++) {
    buffer[1 + i * 2] = (char)s->kinds[i];
    buffer[2 + i * 2] = s->params[i];
    buffer[33 + i] = s->params2[i];
  }
  buffer[66] = (char)s->macro_openers_top;
  for (uint8_t i = 0; i < s->macro_openers_top; i++) buffer[67 + i] = s->macro_openers[i];
  return 67 + s->macro_openers_top;
}

void tree_sitter_cangjie_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
  Scanner *s = (Scanner *)payload;
  s->top = 0;
  s->macro_openers_top = 0;
  if (length < 1) return;
  uint8_t count = (uint8_t)buffer[0];
  if (count > STACK_MAX) count = STACK_MAX;
  if (length < (unsigned)(1 + count * 2)) return;
  for (uint8_t i = 0; i < count; i++) {
    s->kinds[i] = (uint8_t)buffer[1 + i * 2];
    s->params[i] = buffer[2 + i * 2];
    s->params2[i] = buffer[33 + i];
  }
  s->top = count;
  if (length < 67) return;
  uint8_t ocount = (uint8_t)buffer[66];
  if (ocount > 8) ocount = 8;
  if (length < (unsigned)(67 + ocount)) return;
  for (uint8_t i = 0; i < ocount; i++) s->macro_openers[i] = buffer[67 + i];
  s->macro_openers_top = ocount;
}

static void push(Scanner *s, uint8_t kind, char param) {
  if (s->top < STACK_MAX) {
    s->kinds[s->top] = kind;
    s->params[s->top] = param;
    s->params2[s->top] = 0;
    s->top++;
  }
}

static void pop(Scanner *s) {
  if (s->top > 0) s->top--;
}

static bool is_ident_char(int32_t c) {
  return iswalpha(c) || iswdigit(c) || c == '_';
}

static bool match_word_tail(TSLexer *lexer, const char *rest, uint8_t len) {
  for (uint8_t i = 0; i < len; i++) {
    if (lexer->lookahead != rest[i]) return false;
    advance(lexer);
  }
  return !is_ident_char(lexer->lookahead);
}

static bool word_continues(TSLexer *lexer) {
  switch (lexer->lookahead) {
    case 'e':
      advance(lexer);
      return match_word_tail(lexer, "lse", 3);
    case 'c':
      advance(lexer);
      return match_word_tail(lexer, "atch", 4);
    case 'f':
      advance(lexer);
      return match_word_tail(lexer, "inally", 6);
    case 'h':
      advance(lexer);
      return match_word_tail(lexer, "andle", 5);
    case 'w':
      advance(lexer);
      return match_word_tail(lexer, "here", 4);
    default:
      return false;
  }
}

static bool continues_expression(TSLexer *lexer) {
  switch (lexer->lookahead) {
    case '.':
    case '?':
    case '{':
      return true;
    case '|':
      advance(lexer);
      return true;
    case '&':
      advance(lexer);
      return true;
    case '~':
      advance(lexer);
      return lexer->lookahead == '>';
    default:
      return false;
  }
}

static void peek_blank_lines_and_comments(TSLexer *lexer) {
  for (;;) {
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
    if (lexer->lookahead == '\n' || lexer->lookahead == '\r') {
      if (lexer->lookahead == '\r') skip(lexer);
      if (lexer->lookahead == '\n') skip(lexer);
      continue;
    }
    if (lexer->lookahead == '/') {
      skip(lexer);
      if (lexer->lookahead == '/') {
        while (lexer->lookahead != '\n' && lexer->lookahead != '\r' &&
               lexer->lookahead != 0) skip(lexer);
        continue;
      }
      if (lexer->lookahead == '*') {
        skip(lexer);
        for (;;) {
          if (lexer->lookahead == '*') {
            skip(lexer);
            if (lexer->lookahead == '/') {
              skip(lexer);
              break;
            }
          } else if (lexer->lookahead == 0) {
            break;
          } else {
            skip(lexer);
          }
        }
        continue;
      }
      return;
    }
    return;
  }
}

static bool scan_terminator(TSLexer *lexer) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r') skip(lexer);
  if (lexer->lookahead != '\n') return false;
  skip(lexer);
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
  lexer->mark_end(lexer);
  peek_blank_lines_and_comments(lexer);
  if (word_continues(lexer)) return false;
  if (continues_expression(lexer)) return false;
  lexer->result_symbol = TERMINATOR;
  return true;
}

static bool scan_block_comment_content(TSLexer *lexer) {
  int nesting = 1;
  while (nesting > 0 && lexer->lookahead != 0) {
    if (lexer->lookahead == '*') {
      skip(lexer);
      if (lexer->lookahead == '/') {
        nesting--;
        skip(lexer);
      }
    } else if (lexer->lookahead == '/') {
      skip(lexer);
      if (lexer->lookahead == '*') {
        nesting++;
        skip(lexer);
      }
    } else {
      skip(lexer);
    }
  }
  lexer->mark_end(lexer);
  lexer->result_symbol = BLOCK_COMMENT_CONTENT;
  return true;
}

static bool scan_string_open(TSLexer *lexer, Scanner *s) {
  char q = (char)lexer->lookahead;
  if (q != '"' && q != '\'') return false;
  advance(lexer);
  if (lexer->lookahead == q) {
    advance(lexer);
    if (lexer->lookahead == q) {
      advance(lexer);
      push(s, CTX_MULTILINE_STRING, q);
      lexer->result_symbol = MULTILINE_STRING_START;
      return true;
    }
    lexer->mark_end(lexer);
    lexer->result_symbol = LINE_STRING_START;
    return true;
  }
  push(s, CTX_LINE_STRING, q);
  lexer->mark_end(lexer);
  lexer->result_symbol = LINE_STRING_START;
  if (lexer->lookahead == '\n' || lexer->lookahead == '\r' || lexer->lookahead == 0) {
    pop(s);
  }
  return true;
}

static bool scan_interp_open(TSLexer *lexer, Scanner *s) {
  if (lexer->lookahead != '$') return false;
  advance(lexer);
  if (lexer->lookahead != '{') return false;
  advance(lexer);
  push(s, CTX_INTERP, 0);
  lexer->mark_end(lexer);
  lexer->result_symbol = INTERP_OPEN;
  return true;
}

static bool scan_line_content(TSLexer *lexer, Scanner *s, bool pending) {
  bool any = false;
  char quote = s->params[s->top - 1];
  lexer->result_symbol = LINE_STRING_CONTENT;
  while (lexer->lookahead != 0) {
    if (lexer->lookahead == '\n' || lexer->lookahead == '\r') {
      pop(s);
      lexer->mark_end(lexer);
      return any;
    }
    if (lexer->lookahead == quote) {
      lexer->mark_end(lexer);
      if (!any && !pending) return false;
      return true;
    }
    if (lexer->lookahead == '\\') {
      lexer->mark_end(lexer);
      return any;
    }
    if (lexer->lookahead == '$') {
      lexer->mark_end(lexer);
      return any;
    }
    advance(lexer);
    any = true;
  }
  pop(s);
  lexer->mark_end(lexer);
  return any;
}

static bool scan_multiline_content(TSLexer *lexer, Scanner *s) {
  char quote = s->params[s->top - 1];
  bool any = false;
  lexer->result_symbol = MULTILINE_STRING_CONTENT;
  while (lexer->lookahead != 0) {
    if (lexer->lookahead == '\\') {
      lexer->mark_end(lexer);
      return any;
    }
    if (lexer->lookahead == '$') {
      lexer->mark_end(lexer);
      return any;
    }
    if (lexer->lookahead == quote) {
      advance(lexer);
      if (lexer->lookahead == quote) {
        advance(lexer);
        if (lexer->lookahead == quote) {
          advance(lexer);
          pop(s);
          lexer->mark_end(lexer);
          if (!any) lexer->result_symbol = MULTILINE_STRING_END;
          return true;
        }
      }
      any = true;
      continue;
    }
    advance(lexer);
    any = true;
  }
  pop(s);
  lexer->mark_end(lexer);
  return any;
}

static bool scan_raw_open(TSLexer *lexer, Scanner *s) {
  uint8_t hash_count = 0;
  while (lexer->lookahead == '#') {
    advance(lexer);
    hash_count++;
    if (hash_count == UINT8_MAX) return false;
  }
  if ((lexer->lookahead != '"' && lexer->lookahead != '\'') || hash_count == 0) return false;
  push(s, CTX_RAW_STRING, (char)lexer->lookahead);
  s->params2[s->top - 1] = (char)hash_count;
  advance(lexer);
  lexer->result_symbol = RAW_STRING_START;
  return true;
}

static bool scan_raw_content(TSLexer *lexer, Scanner *s) {
  if (!s->top || s->kinds[s->top - 1] != CTX_RAW_STRING) return false;
  char quote = s->params[s->top - 1];
  uint8_t hashes = (uint8_t)s->params2[s->top - 1];
  bool any = false;
  lexer->result_symbol = RAW_STRING_CONTENT;
  for (;;) {
    if (lexer->lookahead == quote) {
      advance(lexer);
      uint8_t count = 0;
      while (lexer->lookahead == '#') {
        advance(lexer);
        count++;
      }
      if (count == hashes) {
        pop(s);
        lexer->mark_end(lexer);
        if (!any) lexer->result_symbol = RAW_STRING_END;
        return true;
      }
      any = true;
      continue;
    }
    if (lexer->lookahead == 0) {
      pop(s);
      lexer->mark_end(lexer);
      return any;
    }
    advance(lexer);
    any = true;
  }
}

static bool scan_quote_open(TSLexer *lexer, Scanner *s) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r' ||
         lexer->lookahead == '\n') skip(lexer);
  if (lexer->lookahead != 'q') return false;
  advance(lexer);
  if (!match_word_tail(lexer, "uote", 4)) return false;
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
  if (lexer->lookahead != '(') return false;
  advance(lexer);
  push(s, CTX_QUOTE, 0);
  lexer->mark_end(lexer);
  lexer->result_symbol = QUOTE_OPEN;
  return true;
}

static bool scan_quote_content(TSLexer *lexer) {
  bool any = false;
  lexer->result_symbol = QUOTE_CONTENT;
  while (lexer->lookahead != 0) {
    char c = (char)lexer->lookahead;
    if (c == '(' || c == ')' || c == '\\' || c == '"' || c == '\'' || c == '$') {
      lexer->mark_end(lexer);
      return any;
    }
    advance(lexer);
    any = true;
  }
  lexer->mark_end(lexer);
  return any;
}

static bool scan_macro_at(TSLexer *lexer) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r' ||
         lexer->lookahead == '\n') skip(lexer);
  if (lexer->lookahead != '@') return false;
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = MACRO_AT;
  return true;
}

static bool scan_macro_body_open(TSLexer *lexer, Scanner *s) {
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
  if (lexer->lookahead != '[' && lexer->lookahead != '(') return false;
  char opener = (char)lexer->lookahead;
  if (s->macro_openers_top == 0) {
    push(s, CTX_MACRO_BODY, (opener == '[') ? ']' : ')');
    s->macro_openers_top = 1;
    s->macro_openers[0] = opener;
  } else {
    return false;
  }
  advance(lexer);
  lexer->mark_end(lexer);
  lexer->result_symbol = (opener == '[') ? MACRO_ATTR_OPEN : MACRO_INPUT_OPEN;
  return true;
}

static bool scan_macro_body_content(TSLexer *lexer, Scanner *s) {
  if (!s->top || s->kinds[s->top - 1] != CTX_MACRO_BODY) return false;
  char closer = s->params[s->top - 1];
  bool any = false;
  // EXPERIMENT: expression-capable macro bodies. With no nested openers
  // pending, raw content only covers whitespace/newline runs; anything
  // else is declined so the internal lexer produces expression tokens.
  if (s->macro_openers_top == 0) {
    char c = (char)lexer->lookahead;
    if (c != ' ' && c != '\t' && c != '\r' && c != '\n') return false;
  }
  lexer->result_symbol = MACRO_BODY_CONTENT;
  while (lexer->lookahead != 0) {
    char c = (char)lexer->lookahead;
    if (c == '(' || c == '[' || c == '{') {
      if (s->macro_openers_top < 8) {
        s->macro_openers[s->macro_openers_top++] = c;
      }
      advance(lexer);
      any = true;
      continue;
    }
    if (c == ')' || c == ']' || c == '}') {
      if (s->macro_openers_top >= 2) {
        char open = s->macro_openers[s->macro_openers_top - 1];
        if ((open == '(' && c == ')') || (open == '[' && c == ']') || (open == '{' && c == '}')) {
          s->macro_openers_top--;
          advance(lexer);
          any = true;
          continue;
        }
      }
      if (c == closer) {
        lexer->mark_end(lexer);
        if (!any) return false;
        return true;
      }
      advance(lexer);
      any = true;
      continue;
    }
    if (c == '#' || c == '"' || c == '\'' || c == '\\') {
      lexer->mark_end(lexer);
      return any;
    }
    advance(lexer);
    any = true;
  }
  pop(s);
  s->macro_openers_top = 0;
  lexer->mark_end(lexer);
  return any;
}

static bool ws(char c) {
  return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}

// Swift's ParseExpr.cpp rule (SO 36387657): favor the operator '<' unless a
// generic clause balances to '>' and the next token is in the follow set.
// '(' '[' '.' count only immediately after '>'; ')',']','{','}',',',';'
// count across whitespace.
static bool scan_generic_lt(TSLexer *lexer) {
  lexer->mark_end(lexer);
  advance(lexer);                            // consume the '<' (peek)
  int depth = 1;
  unsigned steps = 0;
  while (depth > 0) {
    if (steps++ > 1024 || lexer->lookahead == 0) return false;
    if (ws(lexer->lookahead)) { advance(lexer); continue; }
    if (lexer->lookahead == '<') { depth++; advance(lexer); continue; }
    if (lexer->lookahead == '>') { depth--; advance(lexer); continue; }
    if (lexer->lookahead == '/') {           // trivia: '//' and '/* */'
      advance(lexer);
      if (lexer->lookahead == '/') {
        advance(lexer);
        while (lexer->lookahead != '\n' && lexer->lookahead != 0) advance(lexer);
        continue;
      }
      if (lexer->lookahead == '*') {
        advance(lexer);
        int comment_steps = 0;
        while (lexer->lookahead != 0 && comment_steps++ < 1024) {
          if (lexer->lookahead == '*') {
            advance(lexer);
            if (lexer->lookahead == '/') { advance(lexer); break; }
          } else advance(lexer);
        }
        if (lexer->lookahead == 0) return false;
        continue;
      }
      return false;                          // bare '/': division, not a type clause
    }
    if (lexer->lookahead == '-') {          // '->' inside function types: '>' is not a closer
      advance(lexer);
      if (lexer->lookahead == '>') { advance(lexer); continue; }
      return false;
    }
    if (lexer->lookahead == '(') {           // function-type parameter lists
      advance(lexer);
      int parens = 1;
      while (parens > 0 && steps++ < 1024 && lexer->lookahead != 0) {
        if (lexer->lookahead == '(') parens++;
        else if (lexer->lookahead == ')') parens--;
        else if (lexer->lookahead == '-') {   // '->' inside the parens
          advance(lexer);
          if (lexer->lookahead == '>') { advance(lexer); continue; }
        } else if (lexer->lookahead == '<') { advance(lexer); continue; }
        else if (lexer->lookahead == '>') { advance(lexer); continue; }
        advance(lexer);
      }
      if (parens != 0) return false;
      continue;
    }
    if (is_ident_char(lexer->lookahead) || lexer->lookahead == '.' ||
        lexer->lookahead == ',' || lexer->lookahead == '?' ||
        lexer->lookahead == '$' || lexer->lookahead == ':') {
      advance(lexer);
      continue;
    }
    return false;                            // not type-list content: comparison
  }
  // Follow set: Swift's *_following adapted to cangjie ASI — after
  // whitespace the expression-continuation tokens ('.' '?' '{' '|' '&' '~',
  // cf. scan_terminator) keep the generic reading; '==' etc. favor the
  // comparison. Comments are trivia here; a newline counts as crossing.
  bool spaced = false, newline = false;
  int32_t c = 0;
  for (;;) {
    if (ws(lexer->lookahead)) {
      if (lexer->lookahead == '\n' || lexer->lookahead == '\r') newline = true;
      spaced = true;
      advance(lexer);
      continue;
    }
    if (lexer->lookahead == '/') {
      advance(lexer);
      if (lexer->lookahead == '/') {
        advance(lexer);
        while (lexer->lookahead != '\n' && lexer->lookahead != 0) advance(lexer);
        continue;                            // '\n' picked up by the ws branch
      }
      if (lexer->lookahead == '*') {
        advance(lexer);
        int comment_steps = 0;
        while (lexer->lookahead != 0 && comment_steps++ < 1024) {
          if (lexer->lookahead == '\n' || lexer->lookahead == '\r') newline = true;
          if (lexer->lookahead == '*') {
            advance(lexer);
            if (lexer->lookahead == '/') { advance(lexer); break; }
          } else advance(lexer);
        }
        continue;                            // EOF handled by c == 0 below
      }
      c = '/';                               // bare '/': division
      break;
    }
    c = lexer->lookahead;
    break;
  }
  bool follow;
  // A newline after a well-formed clause ends the statement (cangjie ASI):
  // the generic reading wins regardless of what the next line starts with.
  if (newline || c == 0) follow = true;
  // '(' and '=' are accepted across whitespace too (corpus compatibility —
  // spaced `Array<Int64> (args)` — and machine-generated macrocall spacing);
  // '.' stays Swift-strict (period_following).
  else if (c == '(' || c == '[' || c == '=' ||
           (c == '.' && !spaced)) follow = true;
  else if (c == ')' || c == ']' || c == '{' || c == '}' ||
           c == ',' || c == ';' || c == '?' || c == '@' ||
           c == '|' || c == '&' || c == '~') follow = true;
  else follow = false;
  if (!follow) return false;
  lexer->result_symbol = GENERIC_LT;
  return true;
}

bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  Scanner *s = (Scanner *)payload;

  // Error-state guard: `_error_sentinel` is referenced by no grammar rule,
  // so it is valid only during error recovery, where ALL externals are marked
  // valid. Without this, the context-free block-comment body scanner (no
  // scanner-side start marker) can start at an arbitrary position and swallow
  // the rest of the file, letting a "blob" error version win the recovery
  // cost race. Context-backed tokens stay legal: only real starts push.
  if (valid_symbols[ERROR_SENTINEL] && s->top == 0) {
    return false;
  }

  uint8_t top = s->top ? s->kinds[s->top - 1] : CTX_NONE;

  if (top == CTX_NONE) {
    if (valid_symbols[GENERIC_LT]) {
      // Spaces/tabs only: a '\n' here must stay for scan_terminator (ASI) —
      // a generic '<' never starts across a newline in cangjie.
      while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
      if (lexer->lookahead == '<') {
        if (scan_generic_lt(lexer)) return true;
        return false;   // clause peek past '<': reset via re-lex, no fall-through
      }
    }
    if (valid_symbols[TERMINATOR] && scan_terminator(lexer)) return true;
    if (valid_symbols[BLOCK_COMMENT_CONTENT] && scan_block_comment_content(lexer)) return true;
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t' ||
           lexer->lookahead == '\r' || lexer->lookahead == '\n') skip(lexer);
    if (valid_symbols[RAW_STRING_START] && lexer->lookahead == '#') {
      return scan_raw_open(lexer, s);
    }
    if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
        (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
      return scan_string_open(lexer, s);
    }
    if (valid_symbols[QUOTE_OPEN] && scan_quote_open(lexer, s)) return true;
    if ((valid_symbols[MACRO_ATTR_OPEN] || valid_symbols[MACRO_INPUT_OPEN]) &&
        scan_macro_body_open(lexer, s)) return true;
    if (valid_symbols[MACRO_AT] && scan_macro_at(lexer)) return true;
    return false;
  }

  switch (top) {
    case CTX_LINE_STRING:
      if (valid_symbols[LINE_STRING_END] && lexer->lookahead == s->params[s->top - 1]) {
        pop(s);
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = LINE_STRING_END;
        return true;
      }
      if (valid_symbols[LINE_STRING_CONTENT] && scan_line_content(lexer, s, false)) return true;
      if (valid_symbols[INTERP_OPEN] && lexer->lookahead == '$') {
        if (scan_interp_open(lexer, s)) return true;
        if (valid_symbols[LINE_STRING_CONTENT] && scan_line_content(lexer, s, true)) return true;
      }
      return false;

    case CTX_MULTILINE_STRING:
      if (valid_symbols[MULTILINE_STRING_CONTENT] && scan_multiline_content(lexer, s)) return true;
      if (valid_symbols[INTERP_OPEN] && lexer->lookahead == '$') {
        if (scan_interp_open(lexer, s)) return true;
        if (valid_symbols[MULTILINE_STRING_CONTENT] && scan_multiline_content(lexer, s)) return true;
      }
      return false;

    case CTX_INTERP:
    case CTX_BRACE:
      if (valid_symbols[GENERIC_LT]) {
        while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
        if (lexer->lookahead == '<') {
          if (scan_generic_lt(lexer)) return true;
          return false;
        }
      }
      if (valid_symbols[TERMINATOR] && scan_terminator(lexer)) return true;
      if (valid_symbols[BLOCK_COMMENT_CONTENT] && scan_block_comment_content(lexer)) return true;
      while (lexer->lookahead == ' ' || lexer->lookahead == '\t' ||
             lexer->lookahead == '\r' || lexer->lookahead == '\n') skip(lexer);
      if (top == CTX_INTERP) {
        if (valid_symbols[INTERP_CLOSE] && lexer->lookahead == '}') {
          pop(s);
          advance(lexer);
          lexer->mark_end(lexer);
          lexer->result_symbol = INTERP_CLOSE;
          return true;
        }
      } else {
        if (valid_symbols[BRACE_CLOSE] && lexer->lookahead == '}') {
          pop(s);
          advance(lexer);
          lexer->mark_end(lexer);
          lexer->result_symbol = BRACE_CLOSE;
          return true;
        }
      }
      if (valid_symbols[BRACE_OPEN] && lexer->lookahead == '{') {
        push(s, CTX_BRACE, 0);
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = BRACE_OPEN;
        return true;
      }
      if (valid_symbols[RAW_STRING_START] && lexer->lookahead == '#') {
        return scan_raw_open(lexer, s);
      }
      if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
          (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
        return scan_string_open(lexer, s);
      }
      // Macro expressions may appear inside interpolations: ${@f(x)}.
      if ((valid_symbols[MACRO_ATTR_OPEN] || valid_symbols[MACRO_INPUT_OPEN]) &&
          scan_macro_body_open(lexer, s)) return true;
      if (valid_symbols[MACRO_AT] && scan_macro_at(lexer)) return true;
      return false;

    case CTX_RAW_STRING:
      if (valid_symbols[RAW_STRING_CONTENT] || valid_symbols[RAW_STRING_END]) {
        return scan_raw_content(lexer, s);
      }
      return false;

    case CTX_QUOTE:
    case CTX_QUOTE_PAREN:
      if (top == CTX_QUOTE) {
        if (valid_symbols[QUOTE_CLOSE] && lexer->lookahead == ')') {
          pop(s);
          advance(lexer);
          lexer->mark_end(lexer);
          lexer->result_symbol = QUOTE_CLOSE;
          return true;
        }
      } else {
        if (valid_symbols[QUOTE_PAREN_CLOSE] && lexer->lookahead == ')') {
          pop(s);
          advance(lexer);
          lexer->mark_end(lexer);
          lexer->result_symbol = QUOTE_PAREN_CLOSE;
          return true;
        }
      }
      if (valid_symbols[QUOTE_PAREN_OPEN] && lexer->lookahead == '(') {
        push(s, CTX_QUOTE_PAREN, 0);
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = QUOTE_PAREN_OPEN;
        return true;
      }
      if (valid_symbols[QUOTE_INTERP_OPEN] && lexer->lookahead == '$') {
        advance(lexer);
        if (lexer->lookahead == '(') {
          advance(lexer);
          push(s, CTX_QUOTE_INTERP, 0);
          lexer->mark_end(lexer);
          lexer->result_symbol = QUOTE_INTERP_OPEN;
          return true;
        }
        return false;
      }
      if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
          (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
        return scan_string_open(lexer, s);
      }
      if (valid_symbols[QUOTE_CONTENT] && scan_quote_content(lexer)) return true;
      return false;

    case CTX_QUOTE_INTERP:
      if (valid_symbols[QUOTE_INTERP_CLOSE] && lexer->lookahead == ')') {
        pop(s);
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = QUOTE_INTERP_CLOSE;
        return true;
      }
      while (lexer->lookahead == ' ' || lexer->lookahead == '\t' ||
             lexer->lookahead == '\r' || lexer->lookahead == '\n') skip(lexer);
      if (valid_symbols[RAW_STRING_START] && lexer->lookahead == '#') {
        return scan_raw_open(lexer, s);
      }
      if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
          (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
        return scan_string_open(lexer, s);
      }
      return false;

    case CTX_MACRO_BODY: {
      bool balancable = s->macro_openers_top >= 2 &&
                        s->macro_openers[s->macro_openers_top - 1] == '(' &&
                        lexer->lookahead == ')';
      if (!balancable && (valid_symbols[MACRO_ATTR_CLOSE] || valid_symbols[MACRO_INPUT_CLOSE]) &&
          lexer->lookahead == s->params[s->top - 1]) {
        pop(s);
        s->macro_openers_top = 0;
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = (s->params[s->top] == ']') ? MACRO_ATTR_CLOSE : MACRO_INPUT_CLOSE;
        return true;
      }
      if (valid_symbols[MACRO_BODY_CONTENT] && scan_macro_body_content(lexer, s)) return true;
      if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
          (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
        return scan_string_open(lexer, s);
      }
      if (valid_symbols[RAW_STRING_START] && lexer->lookahead == '#') {
        return scan_raw_open(lexer, s);
      }
      return false;
    }

    default:
      return false;
  }
}

