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

// Per-kind behavior profile: the stack machine's transition table. Entering
// a context pushes a frame; the frame's info decides how the shared
// expression dispatcher treats it. Capability flags are context facts, NOT
// derivable from valid_symbols alone (e.g. quote bodies keep raw-string
// syntax as verbatim content even though the grammar could lex it).
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

// Pop the top frame and emit its close token.
static bool emit_close(TSLexer *lexer, Scanner *s, uint8_t sym) {
    pop(s);
    advance(lexer);
    lexer->mark_end(lexer);
    lexer->result_symbol = sym;
    return true;
}

// Raw-string and line/multiline string opens, valid_symbols-gated, so
// contexts that lack a capability simply never take the branch. allow_raw
// is a context capability, not derivable from valid_symbols: quote bodies
// lex raw-string syntax as verbatim content, so they pass false.
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

// Trivia skipper for speculative trailing-context peeks. Consumes spaces,
// tabs, newlines, CRs and both comment kinds (block comments nest). Returns
// false on a bare '/' (division): the trailing context is not trivia then.
// All consumption past a token's mark_end is discarded and re-lexed by the
// parser (cf. scan_generic_lt), so declining after arbitrary peeking is safe.
static bool skip_peek_trivia(TSLexer *lexer) {
    for (;;) {
        while (lexer->lookahead == ' ' || lexer->lookahead == '\t' ||
               lexer->lookahead == '\r' || lexer->lookahead == '\n')
            skip(lexer);
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

// Conservative superset of the characters that can begin an expression
// (cf. _primary_expression / unary alternatives). Over-approximating is
// safe: a false fire yields an error inside perform_expression, while a
// false decline would break legal `perform\nEff()` ASI.
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

// `perform` is a soft keyword: it is the effect-perform prefix only when an
// expression (the command argument) actually follows, across trivia. The
// DSL token is offerable exactly where perform_expression is reachable
// (single grammar occurrence), so valid_symbols is the state-axis gate and
// this word+peek is the lexical axis. On decline the word re-lexes as a
// plain identifier (`let x = perform`, `f(perform: 1)`, `class perform {}`).
static bool scan_perform_dsl(TSLexer *lexer) {
    if (lexer->lookahead != 'p')
        return false;
    advance(lexer);
    if (!match_word_tail(lexer, "erform", 6))
        return false;
    lexer->mark_end(lexer);
    if (!skip_peek_trivia(lexer))
        return false;
    if (!is_expression_start_char(lexer->lookahead))
        return false;
    lexer->result_symbol = PERFORM_DSL;
    return true;
}

// `resume` is soft like `perform`: the resumption forms are the keyword-infix
// continuations `with ...` / `throwing ...` (cjc-verified). Bare `resume` and
// `resume(e)` (a plain call) stay identifiers.
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
        if (c == '/' ) {
            // A line comment inside a quote body is raw content to EOL:
            // apostrophes/quotes inside it (they're) must not start strings.
            advance(lexer);
            any = true;
            if (lexer->lookahead == '/') {
                while (lexer->lookahead != 0 && lexer->lookahead != '\n' && lexer->lookahead != '\r') {
                    advance(lexer);
                }
            }
            continue;
        }
        if (c == '\n' || c == '\r') {
            // Every newline inside a quote body is its own token; whether it is
            // a visible separator quoteToken or ignored trivia is decided by the
            // grammar (quote_expression), not here. Advance, never skip: an
            // all-skip token collapses to zero width.
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
            // Split an unescaped @Name head into its own token (QUOTE_MACRO_HEAD)
            // so queries can make macro calls inside quotes visible; their
            // arguments stay raw. \@ escapes never reach here.
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

// Shared expression-position dispatch: one stack-machine state for top
// level, interpolations, braces and quote interps. The frame's info
// decides capabilities; the caller guarantees top is expr-mode.
static bool scan_expr_frame(TSLexer *lexer, Scanner *s, const bool *valid_symbols, const FrameInfo *info) {
    if (info->generic_lt && valid_symbols[GENERIC_LT]) {
        // Spaces/tabs only: a '\n' here must stay for scan_terminator (ASI) —
        // a generic '<' never starts across a newline in cangjie.
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
            // Nested group: a bookkeeping frame, pushed mid-token so the
            // delimiter stays inside the content it spans (byte-identical
            // token streams).
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
            // Body closer: the MACRO_BODY frame sits below any pending groups.
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
            // Line comment inside a macro body: raw content to EOL, so an
            // apostrophe inside it cannot start a string token.
            advance(lexer);
            any = true;
            if (lexer->lookahead == '/') {
                while (lexer->lookahead != 0 && lexer->lookahead != '\n' && lexer->lookahead != '\r') {
                    advance(lexer);
                }
            }
            continue;
        }
        if (c == '#' || c == '"' || c == '\'' || c == '\\') {
            lexer->mark_end(lexer);
            return any;
        }
        advance(lexer);
        any = true;
    }
    // EOF inside the body: drop the body and its pending groups.
    while (s->top > 0 && (s->kinds[s->top - 1] == CTX_MACRO_BODY || s->kinds[s->top - 1] == CTX_MACRO_GROUP)) {
        pop(s);
    }
    lexer->mark_end(lexer);
    return any;
}

static bool ws(char c) { return c == ' ' || c == '\t' || c == '\r' || c == '\n'; }

// Swift's ParseExpr.cpp rule (SO 36387657): favor the operator '<' unless a
// generic clause balances to '>' and the next token is in the follow set.
// '(' '[' '.' count only immediately after '>'; ')',']','{','}',',',';'
// count across whitespace.
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
    // Follow set: Swift's *_following adapted to cangjie ASI — after
    // whitespace the expression-continuation tokens ('.' '?' '{' '|' '&' '~',
    // cf. scan_terminator) keep the generic reading; '==' etc. favor the
    // comparison. Comments are trivia here; a newline counts as crossing.
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
    // A newline after a well-formed clause ends the statement (cangjie ASI):
    // the generic reading wins regardless of what the next line starts with.
    if (newline || c == 0)
        follow = true;
    // '(' and '=' are accepted across whitespace too (corpus compatibility —
    // spaced `Array<Int64> (args)` — and machine-generated macrocall spacing);
    // '.' stays Swift-strict (period_following).
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
        // Nested quote expressions are legal inside interpolations
        // (cjc-verified: quote($(quote(t))) compiles); the inner `quote(`
        // pushes its own CTX_QUOTE frame below this interp frame.
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
        // The innermost group's closer folds into content; the BODY's
        // closer closes the body, winning over any unbalanced pending
        // groups (recovery semantics).
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
