const { terminator } = require("./grammar_common");

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

const intLiteral = seq(
    choice(binaryLiteral, octalLiteral, hexLiteral,decimalLiteral),
    optional(/_?[iu](8|16|32|64)/),
);

const decimalExponent = seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits);
const decimalFloatLiteral = seq(
    choice(
        seq(decimalLiteral, decimalExponent),
        seq(decimalLiteral, '.', decimalDigits, optional(decimalExponent)),
        seq('.', decimalDigits, optional(decimalExponent)),
    ),
    optional(/_?[fF](16|32|64)/),
);

const hexExponent = seq(choice('p', 'P'), optional(choice('+', '-')), decimalDigits);
const hexMantissa = choice(
    seq(hexDigits),
    seq(hexDigits, '.', hexDigits),
    seq('.', hexDigits),
);
const hexFloatLiteral = seq('0', choice('x', 'X'), hexMantissa, hexExponent);

const float_literal = choice(decimalFloatLiteral, hexFloatLiteral);

const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');
const escapedIdentifier = /\\[tbrn'"\\fv0\$]/;

const rune_literal = choice(
    seq('r\'', choice(/[^'\\]/, uniCharacterLiteral, escapedIdentifier), '\''),
    seq('r"', choice(/[^"\\]/, uniCharacterLiteral, escapedIdentifier), '"'),
);

const singleCharByte = /[\u0000-\u0009\u000B\u000C\u000E-\u0021\u0023-\u0026\u0028-\u005B\u005D-\u007F]/;
const byteEscapedIdentifier = /\\[tbrn'"\\fv0]/;
const hexCharByte = seq('\\u{', choice(hexDigit, seq(hexDigit, hexDigit)), '}');

// Byte literal: b'…' (RUNE_BYTE_LITERAL, Tokens.inc:154). Mirrors rune_literal
// with a 'b' prefix; body is a single byte char, a \u{XX} hex, or an escape.
// singleCharByte excludes both quotes + backslash; for b'…' the double-quote
// is a valid body char (e.g. b'"'), so allow it explicitly.
const byte_literal = seq('b\'', choice(singleCharByte, '"', hexCharByte, byteEscapedIdentifier), '\'');

module.exports = function ($) {
    return {
        _literal: $ => choice(
            $.integer_literal,
            $.float_literal,
            $.rune_literal,
            $.byte_literal,
            $.boolean_literal,
            $.string_literal,
            $.unit_literal
        ),

        integer_literal: _ => token(intLiteral),
        float_literal: _ => token(float_literal),
        rune_literal: _ => token(rune_literal),
        byte_literal: _ => token(byte_literal),
        // Escape sequence in string bodies (\n \t \" \' \\ \$ …)
        escape_sequence: _ => token(/\\[tbrn'"\\fv0\$]/),
        boolean_literal: _ => token(prec(1, choice('true', 'false'))),

        string_literal: $ => choice(
            $._line_string_literal,
            $._multi_line_string_literal,
            $._multi_line_raw_string_literal,
        ),

        _line_string_literal: $ => choice(
            seq(
                '\'',
                repeat(choice(
                    token(prec(1, /[^'\\$]+/)),  //string body chars (higher prec than comments)
                    '$',  //literal $ (without {)
                    uniCharacterLiteral,
                    $.escape_sequence,
                    $.inline_expression
                )),
                '\''
            ),
            seq(
                '"',
                repeat(choice(
                    token(prec(1, /[^"\\$]+/)),  //string body chars (higher prec than comments)
                    '$',  //literal $ (without {)
                    uniCharacterLiteral,
                    $.escape_sequence,
                    $.inline_expression
                )),
                '"'
            ),
        ),

        inline_expression: $ => seq(
            '${',
            // Per spec, ${} holes accept declarations too, e.g.
            // "${let PI = 3.14; PI*r*r}" — same statement list as multiline strings.
            seq($._interpolation_statement, repeat(seq(repeat1(';'), $._interpolation_statement))),
            '}'
        ),

        _multi_line_string_literal: $ => choice(
            seq(
                seq('"""', /\r?\n/),
                repeat(choice(
                    /[^\\]/,
                    uniCharacterLiteral,
                    $.escape_sequence,
                    $.in_multi_line_string_expression
                )),
                '"""',
            ),
            seq(
                seq("'''", /\r?\n/),
                repeat(choice(
                    /[^\\]/,
                    uniCharacterLiteral,
                    $.escape_sequence,
                    $.in_multi_line_string_expression
                )),
                "'''",
            ),
        ),

        in_multi_line_string_expression: $ => seq(
            '${',
            optional(seq(
                optional(repeat(terminator($))),
                $._interpolation_statement,
                repeat(seq(repeat(terminator($)), $._interpolation_statement)),
                optional(repeat(terminator($))),
            )),
            '}'
        ),
        _interpolation_statement: $ => choice(
            $.variable_declaration,
            $._expression,
        ),

        _multi_line_raw_string_literal: $ => seq(
            $._multi_line_raw_string_start,
            optional($._multi_line_raw_string_content),
            $._multi_line_raw_string_end
        ),

        unit_literal: _ => seq('(', ')'),
    }
}
