#include "tree_sitter/parser.h"
#include <wctype.h>
#include <string.h>

enum TokenType {
  _TERMINATOR,
  _BLOCK_COMMENT_CONTENT,
  _MULTI_LINE_RAW_STRING_START,
  _MULTI_LINE_RAW_STRING_CONTENT,
  _MULTI_LINE_RAW_STRING_END,
  _LINE_STRING_TAIL_SINGLE,
  _LINE_STRING_TAIL_DOUBLE,
  _ERROR_SENTINEL,
};

typedef struct {
  bool in_string;            // Whether we're currently inside a string
  uint8_t delimiter_length;  // Number of '#' characters in current delimiter
  char quote;                // Quote character opening the raw string ('"' or '\'')
} Scanner;

// ----------------------------------------------------------
// Utility Functions
// ----------------------------------------------------------

static void advance(TSLexer *lexer) {
  lexer->advance(lexer, false);
}

static void skip(TSLexer *lexer) {
  lexer->advance(lexer, true);
}

// ----------------------------------------------------------
// Scanner Lifecycle Functions
// ----------------------------------------------------------

void *tree_sitter_cangjie_external_scanner_create() {
  Scanner *scanner = calloc(1, sizeof(Scanner));
  scanner->delimiter_length = 0;
  scanner->in_string = false;
  scanner->quote = 0;
  return scanner;
}

void tree_sitter_cangjie_external_scanner_destroy(void *payload) {
  free(payload);
}

unsigned tree_sitter_cangjie_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *scanner = (Scanner *)payload;
  buffer[0] = scanner->in_string ? 1 : 0;
  buffer[1] = (char)scanner->delimiter_length;
  buffer[2] = scanner->quote;
  return 3;
}

void tree_sitter_cangjie_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
  Scanner *scanner = (Scanner *)payload;
  if (length >= 3) {
    scanner->in_string = buffer[0];
    scanner->delimiter_length = (uint8_t)buffer[1];
    scanner->quote = buffer[2];
  } else {
    scanner->delimiter_length = 0;
    scanner->in_string = false;
    scanner->quote = 0;
  }
}

// ----------------------------------------------------------
// Delimiter Scanning Functions
// ----------------------------------------------------------

static bool scan_opening_delimiter(TSLexer *lexer, Scanner *scanner) {
  // Count the number of '#' characters
  uint8_t hash_count = 0;
  while (lexer->lookahead == '#') {
    advance(lexer);
    hash_count++;
    if (hash_count == UINT8_MAX) return false;  // Prevent overflow
  }

  // Must be followed by a quote (either style: #"…"# or #'…'#)
  if ((lexer->lookahead != '"' && lexer->lookahead != '\'') || hash_count == 0) {
    scanner->delimiter_length = 0;
    scanner->in_string = false;
    scanner->quote = 0;
    return false;
  }

  // Store the quote, delimiter length, and mark as in string
  scanner->quote = (char)lexer->lookahead;
  advance(lexer);
  scanner->delimiter_length = hash_count;
  scanner->in_string = true;
  lexer->result_symbol = _MULTI_LINE_RAW_STRING_START;
  return true;
}

static bool scan_closing_delimiter(TSLexer *lexer, Scanner *scanner) {
  if (lexer->lookahead != scanner->quote) return false;
  advance(lexer);  // consume the closing quote

  // Count the number of '#' characters
  uint8_t hash_count = 0;
  while (lexer->lookahead == '#') {
    advance(lexer);
    hash_count++;
    if (hash_count == UINT8_MAX) return false;
  }

  // Must match the opening delimiter length; the token ends right after
  // the last '#' — do NOT consume whatever follows it.
  if (hash_count != scanner->delimiter_length) {
    return false;
  }

  // Reset scanner state
  scanner->delimiter_length = 0;
  scanner->in_string = false;
  scanner->quote = 0;
  lexer->result_symbol = _MULTI_LINE_RAW_STRING_END;
  return true;
}

// ----------------------------------------------------------
// Content Scanning Function
// ----------------------------------------------------------

static bool scan_string_content(TSLexer *lexer, Scanner *scanner) {
  if (!scanner->in_string) return false;

  lexer->result_symbol = _MULTI_LINE_RAW_STRING_CONTENT;

  while (true) {
    // Check for potential closing delimiter
    if (lexer->lookahead == scanner->quote) {
      lexer->mark_end(lexer); //标记内容的结束位置
      uint8_t hash_count = 0;
      advance(lexer);
      // Count the '#' characters
      while (lexer->lookahead == '#') {
        advance(lexer);
        hash_count++;
      }
      // Check if it's a valid closing delimiter
      if (hash_count == scanner->delimiter_length) {
        // Not part of the content - return what we have
        return true;
      }
    }
    // Handle EOF case
    else if (lexer->lookahead == 0) {
      lexer->mark_end(lexer);
      return true;
    } 
    // Normal content character
    else {
      advance(lexer);
    }
  }
}

// ----------------------------------------------------------
// Unterminated Line String Tail
// ----------------------------------------------------------
//
// Fires only when no closing quote exists between the current position and
// the end of the line: the string is provably unterminated, so the rest of
// the line is consumed as one tail token and the string node ends at the
// newline at zero error cost. Without this, an unclosed string either
// absorbs the following lines (body repeat + extras) or forces a MISSING
// closer insertion — and several MISSING insertions in one block cascade
// into a single ERROR blob that swallows the rest of the file (breaking
// syntax highlighting below the broken line).
//
// If the quote DOES appear before the newline, decline: the lexer rewinds
// and the normal body/closer items parse the string. Speculative lookahead
// with a false return is safe (same pattern as the _TERMINATOR scan).

static bool scan_line_string_tail(TSLexer *lexer, char quote, enum TokenType result) {
  bool advanced = false;
  while (lexer->lookahead != '\n' && lexer->lookahead != '\r' &&
         lexer->lookahead != 0) {
    if (lexer->lookahead == quote) return false;  // can close normally
    advance(lexer);
    advanced = true;
  }
  if (!advanced) return false;  // empty tail — at newline/EOF already
  lexer->mark_end(lexer);
  lexer->result_symbol = result;
  return true;
}

// ----------------------------------------------------------
// Main Scanning Function
// ----------------------------------------------------------

bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  // Error-recovery mode: tree-sitter marks ALL external tokens valid when
  // repairing an error. _BLOCK_COMMENT_CONTENT would then unconditionally
  // scan from an arbitrary position to '*/'/EOF, swallowing the rest of the
  // file as one phantom token. The sentinel is referenced by no grammar rule,
  // so it is valid in NO state except error recovery — decline and let the
  // internal lexer drive recovery (same pattern as tree-sitter-rust).
  if (valid_symbols[_ERROR_SENTINEL]) {
    return false;
  }

  Scanner *scanner = (Scanner *)payload;

  // Unterminated line-string tail. At most one of the two symbols is valid
  // in a given state (they belong to the single- vs double-quoted string
  // branches). On decline the lexer rewinds and the checks below run.
  if (valid_symbols[_LINE_STRING_TAIL_SINGLE] || valid_symbols[_LINE_STRING_TAIL_DOUBLE]) {
    char quote = valid_symbols[_LINE_STRING_TAIL_DOUBLE] ? '"' : '\'';
    if (scan_line_string_tail(lexer, quote,
                              valid_symbols[_LINE_STRING_TAIL_DOUBLE]
                                  ? _LINE_STRING_TAIL_DOUBLE
                                  : _LINE_STRING_TAIL_SINGLE)) {
      return true;
    }
  }

  // _TERMINATOR: a newline statement-terminator. Emitted for '\n' (or "\r\n")
  // UNLESS the next non-whitespace char starts a continuation:
  //   '.' or '?'  -> postfix-continuation (expr\n  .method())
  //   '||', '&&', '|>', '~>' -> binary-operator continuation (expr\n  || expr)
  // Comments (// ... and /* ... */) are skipped during the lookahead so that
  //   expr\n  // comment\n  .method()  continues correctly.
  //
  // mark_end is placed right after the FIRST newline + indentation, BEFORE
  // the comment/blank-line lookahead. The terminator token therefore consumes
  // exactly one line ending; any comments after it stay in the input stream
  // and are picked up as extras (visible nodes) instead of being swallowed.
  if (valid_symbols[_TERMINATOR] &&
      (lexer->lookahead == '\n' || lexer->lookahead == '\r' ||
       lexer->lookahead == ' ' || lexer->lookahead == '\t')) {
    // Skip trailing spaces/tabs before the newline
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
    if (lexer->lookahead != '\n' && lexer->lookahead != '\r') {
      // No newline after spaces — not a terminator, let extras handle it
      return false;
    }
    if (lexer->lookahead == '\r') skip(lexer);
    if (lexer->lookahead == '\n') skip(lexer);
    // consume this line's leading indentation, then fix the token end here
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
    lexer->mark_end(lexer);

    // Peek past blank lines and comments (chars beyond mark_end are NOT
    // consumed by the emitted token) to find the real next char.
    for (;;) {
      while (lexer->lookahead == ' ' || lexer->lookahead == '\t') skip(lexer);
      if (lexer->lookahead == '\n' || lexer->lookahead == '\r') {
        if (lexer->lookahead == '\r') skip(lexer);
        if (lexer->lookahead == '\n') skip(lexer);
        continue;
      }
      if (lexer->lookahead == '/') {
        skip(lexer);  // peek second char
        if (lexer->lookahead == '/') {
          // line comment — skip to end of line (peeking only)
          while (lexer->lookahead != '\n' && lexer->lookahead != '\r' && lexer->lookahead != 0) skip(lexer);
          continue;
        } else if (lexer->lookahead == '*') {
          // block comment — skip to */ (peeking only)
          skip(lexer);  // skip the '*'
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
        } else {
          // single '/' — division on the next line; not a continuation.
          break;
        }
      }
      break;
    }
    // postfix-continuation or binary-operator continuation -> suppress
    if (lexer->lookahead == '.' || lexer->lookahead == '?') {
      return false;
    }
    // check for ||, &&, |>, ~> two-char continuation operators
    if (lexer->lookahead == '|' || lexer->lookahead == '&' || lexer->lookahead == '~') {
      int first = lexer->lookahead;
      skip(lexer);
      if ((first == '|' && (lexer->lookahead == '|' || lexer->lookahead == '>')) ||
          (first == '&' && lexer->lookahead == '&') ||
          (first == '~' && lexer->lookahead == '>')) {
        return false;
      }
      if (first == '|' || first == '&') {
        // single |/& — binary continuation (`expr\n | expr`, the dominant
        // multi-line style in the corpus, e.g. testcase_245 case bodies).
        // Enum/match/exception `|` separators never have the terminator valid
        // between items, so they are unaffected.
        return false;
      }
      // single ~ — starts a finalizer (`~init`), a member start, not a
      // continuation. Emit terminator (mark_end was fixed earlier).
      lexer->result_symbol = _TERMINATOR;
      return true;
    }
    // `else` continuation: a line starting with the hard keyword `else`
    // always continues the preceding if-expression (`else` cannot begin
    // any statement). Word-boundary is checked so identifiers such as
    // `elsewise` still get their terminator. mark_end was fixed earlier,
    // so speculative peeks past it do not widen the emitted token.
    if (lexer->lookahead == 'e') {
      skip(lexer);
      if (lexer->lookahead == 'l') {
        skip(lexer);
        if (lexer->lookahead == 's') {
          skip(lexer);
          if (lexer->lookahead == 'e') {
            skip(lexer);
            if (!(iswalpha(lexer->lookahead) || iswdigit(lexer->lookahead) ||
                  lexer->lookahead == '_')) {
              return false;  // suppress terminator: else continues the `if`
            }
          }
        }
      }
      // not exactly "else" — emit terminator for whatever identifier follows
      lexer->result_symbol = _TERMINATOR;
      return true;
    }
    lexer->result_symbol = _TERMINATOR;
    return true;
  }

  // Nested block comment content scanner.
  // Called after the grammar has matched '/*'. Scans everything until
  // nesting level reaches 0 (including the closing '*/').
  // Cangjie's block comments nest, unlike C.
  if (valid_symbols[_BLOCK_COMMENT_CONTENT]) {
    int nesting = 1;  // we're inside one level (/* already matched)
    while (nesting > 0 && lexer->lookahead != 0) {
      if (lexer->lookahead == '*') {
        skip(lexer);
        if (lexer->lookahead == '/') {
          nesting--;
          skip(lexer);  // consume the '/' of '*/'
        }
      } else if (lexer->lookahead == '/') {
        skip(lexer);
        if (lexer->lookahead == '*') {
          nesting++;
          skip(lexer);  // consume the '*'
        }
      } else {
        skip(lexer);
      }
    }
    lexer->mark_end(lexer);
    lexer->result_symbol = _BLOCK_COMMENT_CONTENT;
    return true;
  }

  // Skip whitespace (spaces/tabs/CR — NOT '\n', which is _TERMINATOR's job)
  // before looking for raw-string delimiters.
  while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r') {
    skip(lexer);
  }

  // Check for delimiters first
  if (valid_symbols[_MULTI_LINE_RAW_STRING_START] && !scanner->in_string && lexer->lookahead=='#') {
    return scan_opening_delimiter(lexer, scanner);
  }
  // Then check for string content
  if (valid_symbols[_MULTI_LINE_RAW_STRING_CONTENT] && scanner->in_string) {
    return scan_string_content(lexer, scanner);
  }
  // Looking for closing delimiter
  if (valid_symbols[_MULTI_LINE_RAW_STRING_END] && scanner->in_string &&
      lexer->lookahead == scanner->quote) {
    return scan_closing_delimiter(lexer, scanner);
  }

  return false;
}