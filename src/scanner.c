#include "tree_sitter/parser.h"
#include <stdio.h>
#include <string.h>
#include <wctype.h>

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
    QUOTE_MACRO_HEAD,
    QUOTE_NEWLINE,
    PERFORM_DSL,
    RESUME_DSL,
    MACRO_BODY_WORD,
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
#define CTX_MACRO_GROUP 10

#define STACK_MAX 32

// Per-kind profile: the stack machine's transition table. Capability flags are
// context facts, NOT derivable from valid_symbols (quote bodies lex raw-string
// syntax as verbatim content).
typedef struct {
    bool expr_mode;      // expression position
    uint8_t close_token; // 0 = no constant closer
    char close_char;
    bool terminator, generic_lt, block_comment; // expr-mode features
    bool brace_open, quote_open, macro_open;    // opener capabilities
    bool allow_raw;                             // raw-string starts
} FrameInfo;

static const FrameInfo INFO[] = {
    [CTX_NONE] = {true, 0, 0, true, true, true, false, true, true, true},
    [CTX_LINE_STRING] = {false, 0, 0, false, false, false, false, false, false, true},
    [CTX_MULTILINE_STRING] = {false, 0, 0, false, false, false, false, false, false, true},
    [CTX_INTERP] = {true, INTERP_CLOSE, '}', true, true, true, true, false, true, true},
    [CTX_BRACE] = {true, BRACE_CLOSE, '}', true, true, true, true, false, true, true},
    [CTX_RAW_STRING] = {false, 0, 0, false, false, false, false, false, false, true},
    [CTX_QUOTE] = {false, QUOTE_CLOSE, ')', false, false, false, false, false, false, false},
    [CTX_QUOTE_PAREN] = {false, QUOTE_PAREN_CLOSE, ')', false, false, false, false, false, false, false},
    [CTX_QUOTE_INTERP] = {true, QUOTE_INTERP_CLOSE, ')', true, true, true, false, true, false, true},
    [CTX_MACRO_BODY] = {false, 0, 0, false, false, false, false, false, false, true},
    [CTX_MACRO_GROUP] = {false, 0, 0, false, false, false, false, false, false, true},
};

typedef struct {
    uint8_t kinds[STACK_MAX];
    char params[STACK_MAX];
    char params2[STACK_MAX];
    uint8_t top;
} Scanner;

static void push(Scanner *s, uint8_t kind, char param);
static void pop(Scanner *s);
static bool scan_raw_open(TSLexer *lexer, Scanner *s);
static bool scan_string_open(TSLexer *lexer, Scanner *s);
static bool scan_generic_lt(TSLexer *lexer);
static bool scan_terminator(TSLexer *lexer);
static bool scan_block_comment_content(TSLexer *lexer);
static bool scan_macro_body_open(TSLexer *lexer, Scanner *s);
static bool scan_macro_at(TSLexer *lexer);
static bool scan_quote_open(TSLexer *lexer, Scanner *s);
static bool scan_perform_dsl(TSLexer *lexer);
static bool scan_resume_dsl(TSLexer *lexer);

static void advance(TSLexer *lexer) { lexer->advance(lexer, false); }

static void skip(TSLexer *lexer) { lexer->advance(lexer, true); }

// Newline is excluded: it must survive for scan_terminator (ASI).
static void skip_inline_ws(TSLexer *lexer) {
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t')
        skip(lexer);
}

static void skip_ws(TSLexer *lexer) {
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r' || lexer->lookahead == '\n')
        skip(lexer);
}

// Comment content inside quote/macro bodies is raw: delimiters in it must not
// open strings or shift the delimiter stack. EOL (newline left for the caller)
// or '*/' ends it; the leading '/' is consumed.
static void skip_comment_content(TSLexer *lexer) {
    advance(lexer);
    if (lexer->lookahead == '/') {
        while (lexer->lookahead != 0 && lexer->lookahead != '\n' && lexer->lookahead != '\r') {
            advance(lexer);
        }
    } else if (lexer->lookahead == '*') {
        advance(lexer);
        while (lexer->lookahead != 0) {
            if (lexer->lookahead == '*') {
                advance(lexer);
                if (lexer->lookahead == '/') {
                    advance(lexer);
                    return;
                }
                continue;
            }
            advance(lexer);
        }
    }
}

static bool emit_close(TSLexer *lexer, Scanner *s, uint8_t sym) {
    pop(s);
    advance(lexer);
    lexer->mark_end(lexer);
    lexer->result_symbol = sym;
    return true;
}

// String opens, valid_symbols-gated. allow_raw is a context capability, not
// derivable from valid_symbols: quote bodies pass false (raw syntax = content).
static bool scan_string_opens(TSLexer *lexer, Scanner *s, const bool *valid_symbols, bool allow_raw) {
    if (allow_raw && valid_symbols[RAW_STRING_START] && lexer->lookahead == '#') {
        return scan_raw_open(lexer, s);
    }
    if ((valid_symbols[LINE_STRING_START] || valid_symbols[MULTILINE_STRING_START]) &&
        (lexer->lookahead == '"' || lexer->lookahead == '\'')) {
        return scan_string_open(lexer, s);
    }
    return false;
}

void *tree_sitter_cangjie_external_scanner_create() { return calloc(1, sizeof(Scanner)); }

void tree_sitter_cangjie_external_scanner_destroy(void *payload) { free(payload); }

unsigned tree_sitter_cangjie_external_scanner_serialize(void *payload, char *buffer) {
    Scanner *s = (Scanner *)payload;
    if (s->top > STACK_MAX)
        s->top = STACK_MAX;
    buffer[0] = (char)s->top;
    for (uint8_t i = 0; i < s->top; i++) {
        buffer[1 + i * 2] = (char)s->kinds[i];
        buffer[2 + i * 2] = s->params[i];
        buffer[33 + i] = s->params2[i];
    }
    return 65;
}

void tree_sitter_cangjie_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
    Scanner *s = (Scanner *)payload;
    s->top = 0;
    if (length < 1)
        return;
    uint8_t count = (uint8_t)buffer[0];
    if (count > STACK_MAX)
        count = STACK_MAX;
    if (length < (unsigned)(1 + count * 2))
        return;
    for (uint8_t i = 0; i < count; i++) {
        s->kinds[i] = (uint8_t)buffer[1 + i * 2];
        s->params[i] = buffer[2 + i * 2];
        s->params2[i] = buffer[33 + i];
    }
    s->top = count;
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
    if (s->top > 0)
        s->top--;
}

static bool is_ident_char(int32_t c) { return iswalpha(c) || iswdigit(c) || c == '_'; }

static bool match_word_tail(TSLexer *lexer, const char *rest, uint8_t len) {
    for (uint8_t i = 0; i < len; i++) {
        if (lexer->lookahead != rest[i])
            return false;
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
        skip_inline_ws(lexer);
        if (lexer->lookahead == '\n' || lexer->lookahead == '\r') {
            if (lexer->lookahead == '\r')
                skip(lexer);
            if (lexer->lookahead == '\n')
                skip(lexer);
            continue;
        }
        if (lexer->lookahead == '/') {
            skip(lexer);
            if (lexer->lookahead == '/') {
                while (lexer->lookahead != '\n' && lexer->lookahead != '\r' && lexer->lookahead != 0)
                    skip(lexer);
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
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t' || lexer->lookahead == '\r')
        skip(lexer);
    if (lexer->lookahead != '\n')
        return false;
    skip(lexer);
    skip_inline_ws(lexer);
    lexer->mark_end(lexer);
    peek_blank_lines_and_comments(lexer);
    if (word_continues(lexer))
        return false;
    if (continues_expression(lexer))
        return false;
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
    if (q != '"' && q != '\'')
        return false;
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
    if (lexer->lookahead != '$')
        return false;
    advance(lexer);
    if (lexer->lookahead != '{')
        return false;
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
            if (!any && !pending)
                return false;
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
                    if (!any)
                        lexer->result_symbol = MULTILINE_STRING_END;
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
        if (hash_count == UINT8_MAX)
            return false;
    }
    if ((lexer->lookahead != '"' && lexer->lookahead != '\'') || hash_count == 0)
        return false;
    push(s, CTX_RAW_STRING, (char)lexer->lookahead);
    s->params2[s->top - 1] = (char)hash_count;
    advance(lexer);
    lexer->result_symbol = RAW_STRING_START;
    return true;
}

static bool scan_raw_content(TSLexer *lexer, Scanner *s) {
    if (!s->top || s->kinds[s->top - 1] != CTX_RAW_STRING)
        return false;
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
                if (!any)
                    lexer->result_symbol = RAW_STRING_END;
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
    skip_ws(lexer);
    if (lexer->lookahead != 'q')
        return false;
    advance(lexer);
    if (!match_word_tail(lexer, "uote", 4))
        return false;
    skip_inline_ws(lexer);
    if (lexer->lookahead != '(')
        return false;
    advance(lexer);
    push(s, CTX_QUOTE, 0);
    lexer->mark_end(lexer);
    lexer->result_symbol = QUOTE_OPEN;
    return true;
}

// Trivia skipper for speculative peeks; returns false on a bare '/' (division).
// EVERY char goes through advance(), never skip(): the runtime moves token_start
// past skipped chars (lexer.c: `if (skip) token_start = current`), so a skip
// after mark_end clamps the token to zero width; the runtime rewinds on accept.
static bool skip_peek_trivia(TSLexer *lexer) {
    for (;;) {
        while (lexer->lookahead == ' ' || lexer->lookahead == '\t' ||
               lexer->lookahead == '\r' || lexer->lookahead == '\n')
            advance(lexer);
        if (lexer->lookahead != '/')
            return true;
        advance(lexer);
        if (lexer->lookahead == '/') {
            advance(lexer);
            while (lexer->lookahead != '\n' && lexer->lookahead != 0)
                advance(lexer);
            continue;
        }
        if (lexer->lookahead == '*') {
            advance(lexer);
            int nesting = 1;
            while (nesting > 0 && lexer->lookahead != 0) {
                int32_t c = lexer->lookahead;
                advance(lexer);
                if (c == '*' && lexer->lookahead == '/') {
                    advance(lexer);
                    nesting--;
                } else if (c == '/' && lexer->lookahead == '*') {
                    advance(lexer);
                    nesting++;
                }
            }
            continue;
        }
        return false; // bare '/': division, not trivia
    }
}

// Conservative superset of expression-start chars: a false fire yields an error
// inside perform_expression, a false decline breaks legal `perform\nEff()` ASI.
static bool is_expression_start_char(int32_t c) {
    switch (c) {
    case '"':
    case '\'':
    case '(':
    case '[':
    case '{':
    case '-':
    case '!':
    case '~':
    case '&':
    case '@':
    case '#':
    case '`':
        return true;
    default:
        return iswalpha(c) || iswdigit(c) || c == '_';
    }
}

// `perform` is soft: fires only when an expression follows across trivia;
// on decline it re-lexes as a plain identifier (`let x = perform`).
static bool scan_perform_dsl(TSLexer *lexer) {
    if (lexer->lookahead != 'p')
        return false;
    advance(lexer);
    if (!match_word_tail(lexer, "erform", 6))
        return false;
    lexer->mark_end(lexer);
    // Peek on the REAL lexer: a struct copy cannot work (the runtime never updates the copy's lookahead).
    if (!skip_peek_trivia(lexer))
        return false;
    if (!is_expression_start_char(lexer->lookahead))
        return false;
    lexer->result_symbol = PERFORM_DSL;
    return true;
}

// `resume` is soft like `perform` (cjc-verified continuations `with`/`throwing`);
// bare `resume` and `resume(e)` stay identifiers.
static bool scan_resume_dsl(TSLexer *lexer) {
    if (lexer->lookahead != 'r')
        return false;
    advance(lexer);
    if (!match_word_tail(lexer, "esume", 5))
        return false;
    lexer->mark_end(lexer);
    if (!skip_peek_trivia(lexer))
        return false;
    bool continuation = false;
    if (lexer->lookahead == 'w') {
        advance(lexer);
        continuation = match_word_tail(lexer, "ith", 3);
    } else if (lexer->lookahead == 't') {
        advance(lexer);
        continuation = match_word_tail(lexer, "hrowing", 7);
    }
    if (!continuation)
        return false;
    lexer->result_symbol = RESUME_DSL;
    return true;
}

static bool scan_quote_content(TSLexer *lexer) {
    bool any = false;
    lexer->result_symbol = QUOTE_CONTENT;
    while (lexer->lookahead != 0) {
        char c = (char)lexer->lookahead;
        if (c == '/') {
            // Raw content to EOL / '*/': apostrophes and parens in it stay content.
            any = true;
            skip_comment_content(lexer);
            continue;
        }
        if (c == '\n' || c == '\r') {
            // Every newline in a quote body is its own token; the grammar decides
            // separator vs trivia. advance(), never skip: all-skip tokens collapse to zero width.
            if (any) {
                lexer->mark_end(lexer);
                return true;
            }
            if (c == '\r')
                advance(lexer);
            advance(lexer);
            lexer->mark_end(lexer);
            lexer->result_symbol = QUOTE_NEWLINE;
            return true;
        }
        if (c == '(' || c == ')' || c == '\\' || c == '"' || c == '\'' || c == '$') {
            lexer->mark_end(lexer);
            return any;
        }
        if (c == '@') {
            // Split an unescaped @Name head (QUOTE_MACRO_HEAD) so queries can see macro calls inside quotes.
            lexer->mark_end(lexer);
            if (!any) {
                advance(lexer);
                while (is_ident_char(lexer->lookahead))
                    advance(lexer);
                lexer->mark_end(lexer);
                lexer->result_symbol = QUOTE_MACRO_HEAD;
            }
            return true;
        }
        advance(lexer);
        any = true;
    }
    lexer->mark_end(lexer);
    return any;
}

static bool scan_macro_at(TSLexer *lexer) {
    skip_ws(lexer);
    if (lexer->lookahead != '@')
        return false;
    advance(lexer);
    lexer->mark_end(lexer);
    lexer->result_symbol = MACRO_AT;
    return true;
}

static bool scan_macro_body_open(TSLexer *lexer, Scanner *s) {
    skip_inline_ws(lexer);
    if (lexer->lookahead != '[' && lexer->lookahead != '(')
        return false;
    char opener = (char)lexer->lookahead;
    if (s->top >= STACK_MAX)
        return false;
    push(s, CTX_MACRO_BODY, (opener == '[') ? ']' : ')');
    advance(lexer);
    lexer->mark_end(lexer);
    lexer->result_symbol = (opener == '[') ? MACRO_ATTR_OPEN : MACRO_INPUT_OPEN;
    return true;
}

// Shared expression-position dispatch; the caller guarantees top is expr-mode.
static bool scan_expr_frame(TSLexer *lexer, Scanner *s, const bool *valid_symbols, const FrameInfo *info) {
    if (info->generic_lt && valid_symbols[GENERIC_LT]) {
        // Spaces/tabs only: a '\n' must stay for scan_terminator (ASI).
        skip_inline_ws(lexer);
        if (lexer->lookahead == '<') {
            if (scan_generic_lt(lexer))
                return true;
            return false; // clause peek past '<': reset via re-lex, no fall-through
        }
    }
    if (info->terminator && valid_symbols[TERMINATOR] && scan_terminator(lexer))
        return true;
    if (info->block_comment && valid_symbols[BLOCK_COMMENT_CONTENT] && scan_block_comment_content(lexer))
        return true;
    skip_ws(lexer);
    if (info->close_token && valid_symbols[info->close_token] && lexer->lookahead == info->close_char) {
        return emit_close(lexer, s, info->close_token);
    }
    if (info->brace_open && valid_symbols[BRACE_OPEN] && lexer->lookahead == '{') {
        push(s, CTX_BRACE, 0);
        advance(lexer);
        lexer->mark_end(lexer);
        lexer->result_symbol = BRACE_OPEN;
        return true;
    }
    if (scan_string_opens(lexer, s, valid_symbols, info->allow_raw))
        return true;
    if (valid_symbols[PERFORM_DSL] && scan_perform_dsl(lexer))
        return true;
    if (valid_symbols[RESUME_DSL] && scan_resume_dsl(lexer))
        return true;
    if (info->quote_open && valid_symbols[QUOTE_OPEN] && scan_quote_open(lexer, s))
        return true;
    if (info->macro_open) {
        if ((valid_symbols[MACRO_ATTR_OPEN] || valid_symbols[MACRO_INPUT_OPEN]) && scan_macro_body_open(lexer, s))
            return true;
        if (valid_symbols[MACRO_AT] && scan_macro_at(lexer))
            return true;
    }
    return false;
}

static bool scan_macro_body_content(TSLexer *lexer, Scanner *s) {
    uint8_t top = s->kinds[s->top - 1];
    if (top != CTX_MACRO_BODY && top != CTX_MACRO_GROUP)
        return false;
    char closer = s->params[s->top - 1];
    bool any = false;
    lexer->result_symbol = MACRO_BODY_CONTENT;
    while (lexer->lookahead != 0) {
        char c = (char)lexer->lookahead;
        if (c == '(' || c == '[' || c == '{') {
            // Nested group: pushed mid-token so the delimiter stays inside the content it spans.
            push(s, CTX_MACRO_GROUP, (c == '(') ? ')' : (c == '[') ? ']' : '}');
            advance(lexer);
            any = true;
            continue;
        }
        if (c == ')' || c == ']' || c == '}') {
            if (s->kinds[s->top - 1] == CTX_MACRO_GROUP && s->params[s->top - 1] == c) {
                pop(s);
                advance(lexer);
                any = true;
                continue;
            }
            uint8_t bi = s->top - 1;
            while (bi > 0 && s->kinds[bi] == CTX_MACRO_GROUP)
                bi--;
            if (s->kinds[bi] == CTX_MACRO_BODY && c == s->params[bi]) {
                lexer->mark_end(lexer);
                if (!any)
                    return false;
                return true;
            }
            advance(lexer);
            any = true;
            continue;
        }
        if (c == '/') {
            // Raw content: a delimiter in it cannot start a string or unbalance the stack.
            any = true;
            skip_comment_content(lexer);
            continue;
        }
        if (c == '#' || c == '"' || c == '\'' || c == '\\') {
            lexer->mark_end(lexer);
            return any;
        }
        // Ad-hoc split (cjls parity): end the raw run at an ASCII word or
        // digit. On an empty run the word itself is lexed here as
        // MACRO_BODY_WORD (an external, so no keyword machinery applies and
        // reserved words lex as words); digits fall through to the grammar's
        // literal tokens. Non-ASCII stays raw content.
        if (iswalpha(c) || c == '_') {
            if (any) {
                lexer->mark_end(lexer);
                return true;
            }
            lexer->result_symbol = MACRO_BODY_WORD;
            while (iswalpha(lexer->lookahead) || iswdigit(lexer->lookahead) || lexer->lookahead == '_')
                advance(lexer);
            lexer->mark_end(lexer);
            return true;
        }
        if (any && iswdigit(c)) {
            lexer->mark_end(lexer);
            return true;
        }
        advance(lexer);
        any = true;
    }
    while (s->top > 0 && (s->kinds[s->top - 1] == CTX_MACRO_BODY || s->kinds[s->top - 1] == CTX_MACRO_GROUP)) {
        pop(s);
    }
    lexer->mark_end(lexer);
    return any;
}

static bool ws(char c) { return c == ' ' || c == '\t' || c == '\r' || c == '\n'; }

// Swift's ParseExpr.cpp rule (SO 36387657): favor '<' unless a generic clause balances to '>' with a follow-set token next.
static bool scan_generic_lt(TSLexer *lexer) {
    lexer->mark_end(lexer);
    advance(lexer); // consume the '<' (peek)
    int depth = 1;
    unsigned steps = 0;
    while (depth > 0) {
        if (steps++ > 1024 || lexer->lookahead == 0)
            return false;
        if (ws(lexer->lookahead)) {
            advance(lexer);
            continue;
        }
        if (lexer->lookahead == '<') {
            depth++;
            advance(lexer);
            continue;
        }
        if (lexer->lookahead == '>') {
            depth--;
            advance(lexer);
            continue;
        }
        if (lexer->lookahead == '/') { // trivia: '//' and '/* */'
            advance(lexer);
            if (lexer->lookahead == '/') {
                advance(lexer);
                while (lexer->lookahead != '\n' && lexer->lookahead != 0)
                    advance(lexer);
                continue;
            }
            if (lexer->lookahead == '*') {
                advance(lexer);
                int comment_steps = 0;
                while (lexer->lookahead != 0 && comment_steps++ < 1024) {
                    if (lexer->lookahead == '*') {
                        advance(lexer);
                        if (lexer->lookahead == '/') {
                            advance(lexer);
                            break;
                        }
                    } else
                        advance(lexer);
                }
                if (lexer->lookahead == 0)
                    return false;
                continue;
            }
            return false; // bare '/': division, not a type clause
        }
        if (lexer->lookahead == '-') { // '->' inside function types: '>' is not a closer
            advance(lexer);
            if (lexer->lookahead == '>') {
                advance(lexer);
                continue;
            }
            return false;
        }
        if (lexer->lookahead == '(') { // function-type parameter lists
            advance(lexer);
            int parens = 1;
            while (parens > 0 && steps++ < 1024 && lexer->lookahead != 0) {
                if (lexer->lookahead == '(')
                    parens++;
                else if (lexer->lookahead == ')')
                    parens--;
                else if (lexer->lookahead == '-') { // '->' inside the parens
                    advance(lexer);
                    if (lexer->lookahead == '>') {
                        advance(lexer);
                        continue;
                    }
                } else if (lexer->lookahead == '<') {
                    advance(lexer);
                    continue;
                } else if (lexer->lookahead == '>') {
                    advance(lexer);
                    continue;
                }
                advance(lexer);
            }
            if (parens != 0)
                return false;
            continue;
        }
        if (is_ident_char(lexer->lookahead) || lexer->lookahead == '.' || lexer->lookahead == ',' ||
            lexer->lookahead == '?' || lexer->lookahead == '$' || lexer->lookahead == ':') {
            advance(lexer);
            continue;
        }
        return false; // not type-list content: comparison
    }
    // Follow set: Swift's *_following adapted to cangjie ASI — continuation
    // tokens ('.' '?' '{' '|' '&' '~') keep the generic reading, '==' etc.
    // favor comparison; comments are trivia, a newline counts as crossing.
    bool spaced = false, newline = false;
    int32_t c = 0;
    for (;;) {
        if (ws(lexer->lookahead)) {
            if (lexer->lookahead == '\n' || lexer->lookahead == '\r')
                newline = true;
            spaced = true;
            advance(lexer);
            continue;
        }
        if (lexer->lookahead == '/') {
            advance(lexer);
            if (lexer->lookahead == '/') {
                advance(lexer);
                while (lexer->lookahead != '\n' && lexer->lookahead != 0)
                    advance(lexer);
                continue; // '\n' picked up by the ws branch
            }
            if (lexer->lookahead == '*') {
                advance(lexer);
                int comment_steps = 0;
                while (lexer->lookahead != 0 && comment_steps++ < 1024) {
                    if (lexer->lookahead == '\n' || lexer->lookahead == '\r')
                        newline = true;
                    if (lexer->lookahead == '*') {
                        advance(lexer);
                        if (lexer->lookahead == '/') {
                            advance(lexer);
                            break;
                        }
                    } else
                        advance(lexer);
                }
                continue; // EOF handled by c == 0 below
            }
            c = '/'; // bare '/': division
            break;
        }
        c = lexer->lookahead;
        break;
    }
    bool follow;
    // A newline after a well-formed clause ends the statement (ASI): generic reading wins.
    if (newline || c == 0)
        follow = true;
    // '(' / '=' accepted across whitespace (corpus compat); '.' stays Swift-strict.
    else if (c == '(' || c == '[' || c == '=' || (c == '.' && !spaced))
        follow = true;
    else if (c == ')' || c == ']' || c == '{' || c == '}' || c == ',' || c == ';' || c == '?' || c == '@' || c == '|' ||
             c == '&' || c == '~')
        follow = true;
    else
        follow = false;
    if (!follow)
        return false;
    lexer->result_symbol = GENERIC_LT;
    return true;
}

bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
    Scanner *s = (Scanner *)payload;

    // Error-state guard: `_error_sentinel` is valid only during error recovery
    // (no grammar rule references it; all externals are marked valid there).
    // Without this the context-free block-comment scanner can start anywhere and
    // swallow the file, letting a "blob" error version win the recovery race.
    if (valid_symbols[ERROR_SENTINEL] && s->top == 0) {
        return false;
    }

    uint8_t top = s->top ? s->kinds[s->top - 1] : CTX_NONE;

    if (INFO[top].expr_mode) {
        return scan_expr_frame(lexer, s, valid_symbols, &INFO[top]);
    }

    switch (top) {
    case CTX_LINE_STRING:
        if (valid_symbols[LINE_STRING_END] && lexer->lookahead == s->params[s->top - 1]) {
            return emit_close(lexer, s, LINE_STRING_END);
        }
        if (valid_symbols[LINE_STRING_CONTENT] && scan_line_content(lexer, s, false))
            return true;
        if (valid_symbols[INTERP_OPEN] && lexer->lookahead == '$') {
            if (scan_interp_open(lexer, s))
                return true;
            if (valid_symbols[LINE_STRING_CONTENT] && scan_line_content(lexer, s, true))
                return true;
        }
        return false;

    case CTX_MULTILINE_STRING:
        if (valid_symbols[MULTILINE_STRING_CONTENT] && scan_multiline_content(lexer, s))
            return true;
        if (valid_symbols[INTERP_OPEN] && lexer->lookahead == '$') {
            if (scan_interp_open(lexer, s))
                return true;
            if (valid_symbols[MULTILINE_STRING_CONTENT] && scan_multiline_content(lexer, s))
                return true;
        }
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
                return emit_close(lexer, s, QUOTE_CLOSE);
            }
        } else {
            if (valid_symbols[QUOTE_PAREN_CLOSE] && lexer->lookahead == ')') {
                return emit_close(lexer, s, QUOTE_PAREN_CLOSE);
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
        if (scan_string_opens(lexer, s, valid_symbols, false))
            return true;
        if (valid_symbols[QUOTE_CONTENT] && scan_quote_content(lexer))
            return true;
        return false;

    case CTX_QUOTE_INTERP:
        if (valid_symbols[QUOTE_INTERP_CLOSE] && lexer->lookahead == ')') {
            return emit_close(lexer, s, QUOTE_INTERP_CLOSE);
        }
        skip_ws(lexer);
        if (scan_string_opens(lexer, s, valid_symbols, true))
            return true;
        // Nested quotes are legal inside interpolations (cjc-verified); the inner `quote(` pushes its own frame.
        if (valid_symbols[QUOTE_OPEN] && scan_quote_open(lexer, s))
            return true;
        return false;

    case CTX_MACRO_GROUP:
        /* fall through: a folding closer and what follows stay body content */
    case CTX_MACRO_BODY: {
        // The MACRO_BODY frame sits below any pending group frames.
        uint8_t i = s->top - 1;
        while (i > 0 && s->kinds[i] == CTX_MACRO_GROUP)
            i--;
        char body_closer = s->params[i];
        // The innermost group's closer folds into content; the BODY's closer
        // wins over unbalanced pending groups (recovery semantics).
        bool group_folds = (s->kinds[s->top - 1] == CTX_MACRO_GROUP && lexer->lookahead == s->params[s->top - 1]);
        if (!group_folds && (valid_symbols[MACRO_ATTR_CLOSE] || valid_symbols[MACRO_INPUT_CLOSE]) &&
            lexer->lookahead == body_closer) {
            while (s->top > 0 && (s->kinds[s->top - 1] == CTX_MACRO_BODY || s->kinds[s->top - 1] == CTX_MACRO_GROUP)) {
                pop(s);
            }
            advance(lexer);
            lexer->mark_end(lexer);
            lexer->result_symbol = (body_closer == ']') ? MACRO_ATTR_CLOSE : MACRO_INPUT_CLOSE;
            return true;
        }
        if (valid_symbols[MACRO_BODY_CONTENT] && scan_macro_body_content(lexer, s))
            return true;
        if (scan_string_opens(lexer, s, valid_symbols, true))
            return true;
        return false;
    }

    default:
        return false;
    }
}
