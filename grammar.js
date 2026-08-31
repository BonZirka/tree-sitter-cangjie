/**
 * @file Cangjie grammar for tree-sitter
 * @author BonZer0 <sergeykovaltsov@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

const newline = /\r?\n/;

const terminator = ($) => choice($._terminator, ';');

const PREC = {
    COMMENT: 0,           // //  /*  */
    ASSIGN: 0,            // = += ... (loosest; looser than pipeline)
    PIPE: 1,              // |> ~>  (Tokens.inc priority 1, lowest binary)
    OR: 13,               // ||
    COALESCE: 2,          // ??   (Tokens.inc priority 2, looser than ||)
    AND: 14,              // &&
    BIT_OR: 15,           // |
    BIT_XOR: 16,          // ^
    BIT_AND: 17,          // &
    EQUALITY: 18,         // ==  !=
    REL: 19,              // > < >= <= is as
    RANGE: 20,            // .. ..=
    SHIFT: 21,            // <<  >>
    ADD_SUB: 22,          // +  -
    MUL_DIV: 23,          // *  /  %
    POWER: 24,            // **
    UNARY: 25,            // ! -  + 
    POSTFIX: 26,          // ++  -- ?
    PARENS: 27,           // (Expression)
    ARRAY: 28,            // [index]
    MEMBER: 29,           // .
    MARCO_CALL: 30,       // @
};

const TOKENS = {
    AS            :     token('as'),
    BREAK         :     token('break'),
    BOOL          :     token('Bool'),
    CASE          :     token('case'),
    CATCH         :     token('catch'),
    CLASS         :     token('class'),
    CONST         :     token('const'),
    CONTINUE      :     token('continue'),
    RUNE          :     token('Rune'),
    DO            :     token('do'),
    ELSE          :     token('else'),
    ENUM          :     token('enum'),
    EXTEND        :     token('extend'),
    FEATURES      :     token('features'),
    FOR           :     token('for'),
    FROM          :     token('from'),
    FUNC          :     token('func'),
    FINALLY       :     token('finally'),
    FOREIGN       :     token('foreign'),
    HANDLE        :     token('handle'),
    FLOAT16       :     token('Float16'),
    FLOAT32       :     token('Float32'),
    FLOAT64       :     token('Float64'),
    IF            :     token('if'),
    IN            :     token('in'),
    NOT_IN        :     token('!in'),
    IS            :     token('is'),
    INIT          :     token('init'),
    INOUT         :     token('inout'),
    IMPORT        :     token('import'),
    INTERFACE     :     token('interface'),
    INT8          :     token('Int8'),
    INT16         :     token('Int16'),
    INT32         :     token('Int32'),
    INT64         :     token('Int64'),
    INTNATIVE     :     token('IntNative'),
    LET           :     token('let'),
    MUT           :     token('mut'),
    MAIN          :     token('main'),
    MACRO         :     token('macro'),
    MATCH         :     token('match'),
    NOTHING       :     token('Nothing'),
    OPERATOR      :     token('operator'),
    PROP          :     token('prop'),
    PACKAGE       :     token('package'),
    QUOTE         :     token('quote'),
    RETURN        :     token('return'),
    SPAWN         :     token('spawn'),
    SUPER         :     token('super'),
    STATIC        :     token('static'),
    STRUCT        :     token('struct'),
    SYNCHRONIZED  :     token('synchronized'),
    PERFORM       :     token('perform'),
    RESUME        :     token('resume'),
    WITH          :     token('with'),
    THROWING      :     token('throwing'),
    TRY           :     token('try'),
    THIS          :     token('this'),
    TRUE          :     token('true'),
    TYPE          :     token('type'),
    THROW         :     token('throw'),
    THISTYPE      :     token('This'),
    UNSAFE        :     token('unsafe'),
    UNIT          :     token('Unit'),
    UINT8         :     token('UInt8'),
    UINT16        :     token('UInt16'),
    UINT32        :     token('UInt32'),
    UINT64        :     token('UInt64'),
    UINTNATIVE    :     token('UIntNative'),
    VAR           :     token('var'),
    VARRAY        :     token('VArray'),
    WHERE         :     token('where'),
    WHILE         :     token('while'),
    PUBLIC        :     token('public'),
    PROTECTED     :     token('protected'),
    INTERNAL      :     token('internal'),
    PRIVATE       :     token('private'),
    ABSTRACT      :     token('abstract'),
    SEALED        :     token('sealed'),
    REDEF         :     token('redef'),
    OPEN          :     token('open'),
    OVERRIDE      :     token('override'),
    COMMON        :     token('common'),
    SPECIFIC      :     token('specific'),
}

function commaSep1(rule) {
    return seq(rule, repeat(seq(',', rule)));
}

function commaSep1Trailing(rule) {
    return seq(rule, repeat(seq(',', rule)), optional(','));
}

function commaSepTrailing(rule) {
    return optional(commaSep1Trailing(rule));
}

function sep1(rule, separator) {
    return seq(rule, repeat(seq(separator, rule)));
}

function commaSep(rule) {
    return optional(commaSep1(rule));
}

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

const BINARY_OPERATORS = [
    ['>', PREC.REL],
    ['<', PREC.REL],
    ['>=', PREC.REL],
    ['<=', PREC.REL],
    ['==', PREC.EQUALITY],
    ['!=', PREC.EQUALITY],
    ['&&', PREC.AND],
    ['||', PREC.OR],
    ['+', PREC.ADD_SUB],
    ['-', PREC.ADD_SUB],
    ['*', PREC.MUL_DIV],
    ['/', PREC.MUL_DIV],
    ['**', PREC.POWER, 'right'],
    ['&', PREC.BIT_AND],
    ['|', PREC.BIT_OR],
    ['^', PREC.BIT_XOR],
    ['%', PREC.MUL_DIV],
    ['<<', PREC.SHIFT],
    ['>>', PREC.SHIFT],
    ['is', PREC.REL],
    ['as', PREC.REL],
    ['!in', PREC.REL],
    ['in', PREC.REL],
    ['??', PREC.COALESCE, 'right'],
    ['|>', PREC.PIPE],
    ['~>', PREC.PIPE],
];

const M = {
    name: 'cangjie',

    extras: $ => [
        /\s/,
        $.line_comment,
        $.block_comment,
    ],

    word: $ => $.identifier,

    externals: $ => [
        $._terminator,
        $._block_comment_content,
        $._multi_line_raw_string_start,
        $._multi_line_raw_string_content,
        $._multi_line_raw_string_end,
    ],

    supertypes: $ => [
        $._literal,
    ],

    inline: $ => [
    ],

    conflicts: $ => [
        [$.modifiers],
        [$.modifiers, $.variable_declaration],
        [$.call_suffix],
        [$.function_definition],
        [$._member_declarations],
        [$.interface_body],
        [$._top_objects],
        [$.primary_init, $.this_super_expression],
        [$.atomic_variable],
        [$.macro_expression],
        [$._try_handler],
        [$.named_parameter, $.unnamed_member_param],
        [$._macro_name, $.annotation],
        [$.annotation_list, $.decorated_declaration],
        [$.features_directive],
        [$.translation_unit, $._top_level_object],
    ],

    precedences: $ => [
    ],

    rules: {
        translation_unit: $ => seq(
            optional($.features_directive),
            optional(choice($.package_declaration, $.macro_package_declaration)),
            repeat($.import_list),
            optional($._top_objects),
            optional($.main_definition),
            optional($._top_objects),
        ),
        _top_objects: $ => seq(optional(seq($._top_objects, repeat1(terminator($)))), $._top_level_object, optional(repeat1(terminator($)))),

        package_declaration: $ => seq(
            optional($.modifiers),
            TOKENS.PACKAGE, field('package_name', $._name), terminator($)
        ),
        macro_package_declaration: $ => seq(
            optional($.modifiers),
            TOKENS.MACRO, TOKENS.PACKAGE, field('package_name', $._name), terminator($)
        ),

        features_directive: $ => seq(
            optional($.annotation_list),
            TOKENS.FEATURES,
            $.features_set,
            repeat1(terminator($))
        ),

        features_set: $ => seq(
            '{',
            commaSep1Trailing($.feature_id),
            '}'
        ),

        feature_id: $ => sep1($.identifier, '.'),
        modifiers: _ => repeat1(choice(
            TOKENS.PUBLIC,
            TOKENS.PROTECTED,
            TOKENS.PRIVATE,
            TOKENS.INTERNAL,
            TOKENS.ABSTRACT,
            TOKENS.STATIC,
            TOKENS.SEALED,
            TOKENS.REDEF,
            TOKENS.OPEN,
            TOKENS.OVERRIDE,
            TOKENS.MUT,
            TOKENS.UNSAFE,
            TOKENS.CONST,
            TOKENS.COMMON,
            TOKENS.SPECIFIC,
        )),
        _name: $ => choice(
            $.identifier,
            $._reserved_identifier,
            $.scoped_identifier,
        ),
        scoped_identifier: $ => seq(
            field("scope", $._name), '.', field('name', choice($.identifier, $._reserved_identifier))),
        import_list: $ => seq(
            optional($.annotation_list),
            optional($.modifiers),
            TOKENS.IMPORT,
            choice(
                $._import_packages,
                $.package_group,
                $.sub_group_of_package,
            ),
            terminator($)
        ),
        _import_packages: $ => choice(
            prec.right(-3, field('package_name', $._name)),
            prec.right(-2, $.package_full),
            prec.right(-1, $.package_alias),
        ),
        package_alias: $ => seq(
            field('package_name', $._name),
            TOKENS.AS,
            field('alias', choice($.identifier, $._reserved_identifier)),
        ),
        package_full: $ => seq(field('package_name', $._name), '.', $.asterisk),
        package_group: $ => seq(
            '{',
            seq($._import_packages, repeat(seq(',', $._import_packages))),
            optional(','),
            '}',
        ),
        sub_group_of_package: $ => seq(field('package_name', $._name), '.', $.package_group),
        asterisk: _ => '*',

        //types
        _type: $ => choice(
            $.arrow_type,
            $.tuple_type,
            $.prefix_type,
//            alias(token('Array'), seq($.Array)),
//            alias(token('Range'), $.Range),
            alias(TOKENS.INT8, $.Int8),
            alias(TOKENS.INT16, $.Int16),
            alias(TOKENS.INT32, $.Int32),
            alias(TOKENS.INT64, $.Int64),
            alias(TOKENS.INTNATIVE, $.IntNative),
            alias(TOKENS.UINT8, $.UInt8),
            alias(TOKENS.UINT16, $.UInt16),
            alias(TOKENS.UINT32, $.UInt32),
            alias(TOKENS.UINT64, $.UInt64),
            alias(TOKENS.UINTNATIVE, $.UIntNative),
            alias(TOKENS.FLOAT16, $.Float16),
            alias(TOKENS.FLOAT32, $.Float32),
            alias(TOKENS.FLOAT64, $.Float64),
            alias(token('String'), $.String),
            alias(TOKENS.RUNE, $.Rune),
            alias(TOKENS.BOOL, $.Bool),
            alias(TOKENS.NOTHING, $.Nothing),
            alias(TOKENS.UNIT, $.Unit),
            alias(TOKENS.THISTYPE, $.Thistype),
            $.user_type,
            $.array_type,
            $.range_type,
            $.varray_type,
        ),

        arrow_type: $ => seq('(', optional($._named_or_type_list), ')', token('->'), field('type', $._type)),

        tuple_type: $ => seq('(', field('type', $._named_or_type_list), ')'),

        _type_list: $ => commaSep1Trailing($._type),

        _named_or_type_list: $ => commaSep1Trailing(choice(
            seq($.identifier, ':', $._type),
            $._type
        )),

        prefix_type: $ => seq('?', field('type', $._type)),

        user_type: $ => seq($._name, optional($.type_arguments)),
        array_type: $ => seq(token('Array'), $.type_arguments),
        range_type: $ => seq(token('Range'), $.type_arguments),

        varray_type: $ => seq(
            TOKENS.VARRAY,
            '<',
            field('element_type', $._type),
            ',',
            field('size', seq('$', $.integer_literal)),
            '>'
        ),

        parenthesized_type: $ => seq('(', $._type, ')'),

        type_arguments: $ => seq('<', $._type_list, '>'),

        type_parameters: $ => seq('<', commaSep1Trailing($.type_parameter), '>'),

        type_parameter: $ => seq(
            field('name', $.identifier),
            optional(seq(token('<:'), field('bound', sep1($._type, '&'))))
        ),

        //patterns
        _pattern: $ => choice(
            $.wildcard_pattern,
            $._var_binding_pattern,
            $.tuple_pattern,
            $.enum_pattern,
            $._constant_pattern,
            $.type_pattern,
        ),
        wildcard_pattern: _ => token('_'),
        _constant_pattern: $ => alias(choice($._literal, seq('-', $._literal)), $.constant_pattern),
        _var_binding_pattern: $ => alias(choice($.identifier, $._reserved_identifier), $.var_binding_pattern),
        tuple_pattern: $ => seq('(', commaSep1Trailing($._pattern), ')'),
        enum_pattern: $ => choice(
            seq(seq($._name, optional($.type_arguments), '.'), $._var_binding_pattern, optional($.tuple_pattern)),
            seq($._var_binding_pattern, $.tuple_pattern)
        ),
        type_pattern: $ => seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', $._type),

        _deconstruct_pattern: $ => choice(
            $.wildcard_pattern,
            $._var_binding_pattern,
            $.tuple_pattern,
            $.enum_pattern,
            $._constant_pattern,
        ),

        _patterns_maybe_irrefutable: $ => choice(
            $.wildcard_pattern,
            $._var_binding_pattern,
            $.tuple_pattern,
            $.enum_pattern
        ),

        pattern_guard: $ => seq(TOKENS.WHERE, $._expression),

        catch_pattern: $ => choice($.wildcard_pattern, $._exception_type_pattern),
        _exception_type_pattern: $ => seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', sep1($._type, '|')),

        main_definition: $ => seq(
            TOKENS.MAIN, $.parameter_list, optional($.return_type),
            $.block
        ),

        block: $ => seq(
            '{',
            optional(seq($._expression_or_declarations, optional(repeat1(terminator($))))),
            '}',
        ),
        _expression_or_declarations: $ => seq(
            optional(seq($._expression_or_declarations, repeat(terminator($)))),
            choice(
                $.variable_declaration,
                $.function_definition,
                $.assignment_expression,
                $._expression
            ),
        ),

        //top level objects
        _top_level_object: $ => choice(
            $.variable_declaration,
            $.function_definition,
            $.operator_function_definition,
            $.class_definition,
            $.interface_definition,
            $.struct_definition,
            $.enum_definition,
            $.type_alias,
            $.extend_definition,
            $.foreign_declaration,
            $.macro_definition,
            $.macro_expression,
            $.decorated_declaration,
            $.features_directive
        ),
        variable_declaration: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR, TOKENS.CONST),
            field('name', alias($._patterns_maybe_irrefutable, $.variable_name)),
            choice(
                seq(':', field('type', $._type), optional(seq('=', field("initializer", $._expression)))),
                seq('=', field("initializer", $._expression))
            ),
        ),
        function_definition: $ => seq(
            optional($.modifiers),
            TOKENS.FUNC,
            field('name', $._function_name),
            optional($.type_parameters),
            field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)),
            optional(seq(optional(repeat1(terminator($))), $.generic_constraints)),
            optional(seq(repeat1(terminator($)), field('body', $.block))),
            optional(field('body', $.block))
        ),
        _function_name: $ => alias($.identifier, $.func_name),
        parameter_list: $ => seq(
            '(',
            optional(choice(
                seq($._unnamed_parameter_list, optional(seq(',', $._named_parameter_list))),
                $._named_parameter_list
            )),
            optional($.ellipsis_parameter),
            optional(','),
            ')',
        ),

        ellipsis_parameter: $ => seq(optional(','), '...'),
        _unnamed_parameter_list: $ => seq(optional(seq($._unnamed_parameter_list, ',')), $.parameter),
        _named_parameter_list: $ => seq(optional(seq($._named_parameter_list, ',')), $.named_parameter),
        parameter: $ => seq(
            field('para_name', choice($.identifier, '_')),
            ':',
            field('type', $._type)
        ),
        named_parameter: $ => seq(
            seq(field('para_name', $.identifier), '!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),
        return_type: $ => seq(':', field('type', $._type)),

        generic_constraints: $ => prec.right(seq(
            TOKENS.WHERE,
            $.generic_constraint,
            repeat(seq(',', optional(repeat1(terminator($))), $.generic_constraint)),
            optional(',')
        )),
        generic_constraint: $ => seq(
            choice($.identifier, alias(TOKENS.THISTYPE, $.Thistype)),
            token('<:'),
            sep1($._type, '&')
        ),

        operator_function_definition: $ => seq(
            optional($.modifiers),
            TOKENS.OPERATOR, optional(TOKENS.CONST), TOKENS.FUNC,
            field('name', alias(choice(
                token(seq('[', ']')),
                token(seq('(', ')')),
                token('!'), token('+'), token('-'), token('**'), token('*'), token('/'), token('%'), 
                token('<<'), token('>>'), token('<'), token('>'), token('<='), token('>='), 
                token('=='), token('!='), token('&'), token('^'), token('|')
            ), $.operator)),
            optional($.type_parameters),
            field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)),
            optional($.generic_constraints),
            optional(field('body', $.block))
        ),

        interface_definition: $ => seq(
            optional($.modifiers),
            TOKENS.INTERFACE,
            field('name', $._interface_name),
            optional($.type_parameters),
            optional(seq(token('<:'), $._super_interfaces)),
            optional($.generic_constraints),
            '{',
            optional(field('body', $.interface_body)),
            '}',
        ),
        _interface_name: $ => alias($.identifier, $.interface_name),
        _super_interfaces: $ => seq(optional(seq($._super_interfaces, '&')), $._interface_type),
        _interface_type: $ => seq(alias($._name, $.super_or_interface), optional($.type_arguments)),
        interface_body: $ => seq(
            optional(seq($.interface_body, repeat1(terminator($)))),
            $._interface_body_statement,
            optional(repeat1(terminator($))),
        ),
        _interface_body_statement: $ => choice(
            $.function_definition,
            $.operator_function_definition,
            $.property_definition,
            $.decorated_member,
            $.macro_expression,
        ),

        property_definition: $ => seq(
            optional($.modifiers),
            TOKENS.PROP, field('name', $._property_name), ':', field('type', $._type),
            optional(seq(
                '{',
                optional(field('getter', seq(alias($.identifier, $.getter_keyword), '(', ')', $.block))),
                optional(field('setter', seq(alias($.identifier, $.setter_keyword), '(', $.identifier, ')', $.block))),
                '}',
            )),
        ),
        _property_name: $ => alias($.identifier, $.property_name),

        class_definition: $ => seq(
            optional($.modifiers),
            TOKENS.CLASS, field('name', $._class_name), optional($.type_parameters),
            optional(seq(token('<:'), $._super_interfaces)),
            optional($.generic_constraints),
            field('body', $.class_body),
        ),
        _class_name: $ => alias($.identifier, $.class_name),
        class_body: $ => seq(
            '{',
            optional($._member_declarations),
            optional($.primary_init),
            optional($.finalizer),
            optional($._member_declarations),
            '}'
        ),
        _member_declarations: $ => seq(
            optional(seq($._member_declarations, repeat1(terminator($)))),
            choice(
                $.variable_declaration,
                $.function_definition,
                $.operator_function_definition,
                $.property_definition,
                $.init,
                $.static_init,
                $.macro_expression,
                $.decorated_member,
            ), optional(repeat1(terminator($))),
        ),
        init: $ => prec(-1, seq(
            optional($.modifiers),
            TOKENS.INIT, field('parameters', $.parameter_list),
            optional(field('body', $.block))
        )),
        static_init: $ => prec(-2, seq(
            TOKENS.STATIC, TOKENS.INIT, '(', ')',
            optional(field('body', $.block)),
        )),
        primary_init: $ => seq(
            optional($.modifiers),
            $._class_name, $.primary_init_param_list,
            '{',
            optional(seq(TOKENS.SUPER, $.call_suffix, terminator($))),
            optional(repeat(seq(
                choice(
                    $._expression,
                    $.assignment_expression,
                    $.variable_declaration,
                    $.function_definition,
                ),
                optional(terminator($))),
            )),
            '}'
        ),
        primary_init_param_list: $ => seq('(',
            choice(
                seq($._unnamed_parameter_list, optional(seq(',', $._named_member_param_list))),
                seq($._unnamed_parameter_list, seq(',', $._named_parameter_list), optional(seq(',', $._named_member_param_list))),
                seq($._unnamed_parameter_list, seq(',', $._unnamed_member_param_list), optional(seq(',', $._named_member_param_list))),
                seq($._unnamed_member_param_list, optional(seq(',', $._named_member_param_list))),
                seq($._named_parameter_list, optional(seq(',', $._named_member_param_list))),
                optional($._named_member_param_list)),
            optional(','),
            ')'
        ),
        _unnamed_member_param_list: $ => prec.right(commaSep1Trailing($.unnamed_member_param)),
        unnamed_member_param: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            field('para_name', choice($.identifier, '_')),
            optional('!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),

        _named_member_param_list: $ => prec.right(commaSep1Trailing($.named_member_param)),
        named_member_param: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            $.named_parameter
        ),

        finalizer: $ => seq(
            '~', TOKENS.INIT, '(', ')',
            $.block
        ),

        struct_definition: $ => seq(
            optional($.modifiers),
            TOKENS.STRUCT, field('name', $._struct_name),
            optional($.type_parameters),
            optional(seq(token('<:'), $._super_interfaces)),
            optional($.generic_constraints),
            field('body', $.struct_body),
        ),
        _struct_name: $ => alias($.identifier, $.struct_name),
        struct_body: $ => seq(
            '{',
            optional($._member_declarations),
            optional($.primary_init),
            optional($._member_declarations),
            '}'
        ),

        enum_definition: $ => seq(
            optional($.modifiers),
            TOKENS.ENUM,
            field('name', $._enum_name),
            optional($.type_parameters),
            optional(seq(token('<:'), $._super_interfaces)),
            optional($.generic_constraints),
            field('body', $.enum_body)
        ),
        _enum_name: $ => alias($.identifier, $.enum_name),
        enum_body: $ => seq(
            '{', optional('|'),
            sep1(field('enum_constant', $._case_body), '|'),
            repeat(choice(
                $.function_definition,
                $.operator_function_definition,
                $.property_definition,
                $.init,
                $.decorated_member,
                $.macro_expression
            )),
            '}'
        ),
        _case_body: $ => choice(
            seq($.identifier, optional(seq('(', commaSep1Trailing($._type), ')'))),
            token('...')
        ),

        type_alias: $ => seq(
            optional($.modifiers),
            TOKENS.TYPE,
            field('name', alias($.identifier, $.type_alias_name)),
            optional($.type_parameters),
            '=',
            field('type', $._type)
        ),

        extend_definition: $ => seq(
            TOKENS.EXTEND,
            $.extend_type,
            optional(seq(token('<:'), $._super_interfaces)),
            optional($.generic_constraints),
            field('body', $.extend_body),
        ),

        extend_type: $ => choice(
            seq(
                optional($.type_parameters),
                $._name, optional($.type_arguments)
            ),
            TOKENS.INT8, TOKENS.INT16, TOKENS.INT32, TOKENS.INT64, TOKENS.INTNATIVE,
            TOKENS.UINT8, TOKENS.UINT16, TOKENS.UINT32, TOKENS.UINT64, TOKENS.UINTNATIVE,
            TOKENS.FLOAT16, TOKENS.FLOAT32, TOKENS.FLOAT64,
            TOKENS.RUNE, TOKENS.BOOL, TOKENS.NOTHING, TOKENS.UNIT,
            token('String'), token('Range'),
        ),

        extend_body: $ => seq(
            '{',
            repeat(seq(choice(
                $.function_definition,
                $.operator_function_definition,
                $.property_definition,
                $.decorated_member,
                $.macro_expression
            ), repeat(terminator($)))),
            '}'
        ),

        foreign_declaration: $ => seq(
            TOKENS.FOREIGN,
            choice($.foreign_body, $._foreign_member_declaration)
        ),

        foreign_body: $ => seq(
            '{',
            repeat(seq($._foreign_member_declaration, repeat(terminator($)))),
            '}'
        ),

        _foreign_member_declaration: $ => choice(
            $.class_definition,
            $.interface_definition,
            $.function_definition,
            $.macro_expression,
            $.variable_declaration
        ),

        macro_definition: $ => seq(
            optional($.modifiers),
            TOKENS.MACRO, field('name', $._macro_name),
            field('parameters', $.macro_parameter_list),
            optional(field('return_type', $.return_type)),
            choice(
                seq('=', field('body', $._expression)),
                field('body', $.block)
            )
        ),

        macro_parameter_list: $ => seq('(', optional(commaSep1Trailing($.macro_parameter)), ')'),

        macro_parameter: $ => seq(
            field('name', $.identifier),
            ':',
            field('type', $._type)
        ),
        _macro_name: $ => alias($.identifier, $.macro_name),

        annotation_list: $ => repeat1($.annotation),
        annotation: $ => seq(
            '@', optional('!'),
            alias(seq(repeat(seq($.identifier, '.')), $.identifier), $.annotation_name),
            optional(seq('[', $._annotation_argument_list, ']'))
        ),
        _annotation_argument_list: $ => seq(repeat(seq($.annotation_argument, ',')), $.annotation_argument, optional(',')),
        annotation_argument: $ => choice(
            seq($.identifier, ':', $._expression),
            $._expression
        ),

        // expressions
        assignment_expression: $ => prec.right(PREC.ASSIGN, seq(
            field('variable', $._expression),
            field('operator', choice(
                token('='), token('+='), token('-='), token('*='), token('/='), 
                token('%='), token('**='), token('&='), token('|='), token('^='),
                token('<<='), token('>>='), token("&&="), token("||=")
            )),
            field('value', $._expression),
        )),

        _expression: $ => choice(
            $.unary_expression,
            $.binary_expression,
            $._atomic_expression,
        ),

        _atomic_expression: $ => choice(
            $._literal,
            $.array_literal,
            //seq($.identifier, $.type_arguments),
            $.atomic_variable,
            $.range_expression,
            $.parenthesized_expression,
            $.tuple_expression,
            $.postfix_expression,
            $.jump_expression,
            $.lambda_expression,
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

        let_pattern_destructor: $ => prec.right(seq(
            TOKENS.LET, $._patterns_maybe_irrefutable, token('<-'), $._expression,
        )),

        _dollar_call: $ => seq(
            token('$('),
            $._expression,
            ')',
        ),

        unary_expression: $ => prec.left(PREC.UNARY, seq(
            field('operator', choice('!', '-')),
            field('argument', $._expression)
        )),

        binary_expression: $ => choice(...BINARY_OPERATORS.map(([operator, precedence, associativity]) =>
            associativity === 'right'
                ? prec.right(precedence, seq(
                    field('left', $._expression),
                    //@ts-ignore
                    field('operator', token(operator)),
                    field('right', $._expression)
                ))
                : prec.left(precedence, seq(
                    field('left', $._expression),
                    //@ts-ignore
                    field('operator', token(operator)),
                    field('right', $._expression)
                ))
        )),

        array_literal: $ => seq('[', commaSepTrailing(choice($._expression, seq('*', $._expression))), ']'),

        // _atomic_expression: $ => choice(
        //     $.atomic_variable,
        //     $.range_expression,
        //     $.parenthesized_expression,
        //     $.tuple_expression,
        //     $.postfix_expression,
        // ),
        atomic_variable: $ => seq($._var_binding_pattern, optional($.type_arguments)),
        parenthesized_expression: $ => seq('(', $._expression, ')'),
        range_expression: $ => prec.right(PREC.RANGE, seq(
            optional(field('start', $._expression)),
            choice(token('..'), token('..=')),
            optional(field('end', $._expression)),
            optional(seq(':', field('step', $._expression)))
        )),

        postfix_expression: $ => prec.right(PREC.MEMBER, seq(
            $._expression,
            choice(
                prec(PREC.MEMBER, $.field_access),
                prec(PREC.MEMBER, $.scope_resolution),
                prec(PREC.ARRAY, $.index_access),
                prec(PREC.POSTFIX, $.quest_access),
                prec(PREC.PARENS, $.call_suffix),
                prec(PREC.POSTFIX, $.inc_or_dec),
                $.trailing_lambda_expression,
            )
        )),

        field_access: $ => seq('.', $.atomic_variable),
        scope_resolution: $ => seq('::', $.atomic_variable),
        call_suffix: $ => seq(
            '(',
            commaSepTrailing(choice(
                seq($._var_binding_pattern, ':', $._expression),
                $._expression,
                seq(TOKENS.INOUT, optional(seq($._expression, '.')), $._var_binding_pattern)
            )),
            ')',
            optional(seq(',', $.trailing_lambda_expression))
        ),
        index_access: $ => seq(
            '[',
            choice(
                seq($._expression, optional(token('..'))),
                seq($._expression, choice(token('..'), token('..=')), $._expression, optional(seq(':', $._expression))),
                seq(token('..'), $._expression,)
            ),
            ']'
        ),
        quest_access: $ => seq('?', choice(
            $.field_access,
            $.index_access,
            $.call_suffix,
            // expr?{...} — safe-call with trailing lambda (ParseExpr.cpp:953-954
            // accepts QUEST followed by LCURL).
            $.trailing_lambda_expression,
        )),
        inc_or_dec: _ => choice(token('++'), token('--')),

        tuple_expression: $ => seq('(', $._expression, repeat1(seq(',', $._expression)), optional(','), ')'),
        trailing_lambda_expression: $ => seq(
            '{',
            optional(seq(optional($.lambda_parameters), token('=>'))),
            optional(seq($._expression_or_declarations, repeat(terminator($)))),
            '}'
        ),

        lambda_parameters: $ => commaSep1Trailing($.lambda_parameter),
        lambda_parameter: $ => seq(choice($._var_binding_pattern, '_'), optional(seq(':', $._type))),

        jump_expression: $ => choice(
            prec.right(seq(TOKENS.THROW, $._expression)),
            prec.right(seq(TOKENS.RETURN, optional($._expression))),
            TOKENS.CONTINUE,
            TOKENS.BREAK,
        ),

        this_super_expression: _ => choice(TOKENS.THIS, TOKENS.SUPER),
        //typeConvertExpression: $ => seq($._type, '(', $._expression, ')'),
        lambda_expression: $ => seq(
            '{',
            optional($.lambda_parameters),
            token('=>'),
            optional(seq($._expression_or_declarations, optional(repeat1(terminator($))))),
            '}'
        ),
        spawn_expression: $ => seq(TOKENS.SPAWN, optional(seq('(', $._expression, ')')), $.trailing_lambda_expression),
        synchronized_expression: $ => seq(TOKENS.SYNCHRONIZED, '(', $._expression, ')', $.block),
        unsafe_expression: $ => seq(TOKENS.UNSAFE, $.block),

        perform_expression: $ => seq(TOKENS.PERFORM, field('argument', $._expression)),

        resume_expression: $ => prec.left(seq(
            TOKENS.RESUME,
            optional(choice(
                seq(TOKENS.WITH, field('with_argument', $._expression)),
                seq(TOKENS.THROWING, field('throwing_argument', $._expression)),
            )),
        )),
        if_expression: $ => prec.left(seq(
            TOKENS.IF,
            field('condition', seq('(', $._expression, ')')),
            field('consequence', $.block),
            // `else` on its own line works because the terminator scanner
            // suppresses the newline before the hard keyword `else`
            // (compiler: ParseAtom.cpp SkipBlank(NL) before Skip(ELSE)).
            optional(field('alternative', seq(TOKENS.ELSE, choice($.if_expression, $.block))))
        )),

        match_expression: $ => choice(
            seq(TOKENS.MATCH, '(', $._expression, ')',
                '{',
                repeat1($.match_case),
                '}'
            ),
            seq(
                TOKENS.MATCH,
                '{',
                repeat1($.match_case_body),
                '}'
            )
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

        _loop_expression: $ => choice($.for_in_expression, $.while_expression, $.do_while_expression),

        for_in_expression: $ => seq(
            TOKENS.FOR, '(', $._patterns_maybe_irrefutable, TOKENS.IN, $._expression, optional($.pattern_guard), ')', $.block
        ),

        while_expression: $ => seq(
            TOKENS.WHILE, '(', $._expression, ')',
            $.block
        ),

        do_while_expression: $ => seq(TOKENS.DO, field('body', $.block), TOKENS.WHILE, '(', $._expression, ')'),

        try_expression: $ => prec.right(choice(
            seq(TOKENS.TRY,
                field('try_body', $.block),
                repeat1($._try_handler),
                optional(seq(TOKENS.FINALLY, field('finally_body', $.block)))
            ),
            seq(TOKENS.TRY, '(', $.resource_specifications, ')',
                field('try_body', $.block),
                repeat($._try_handler),
                optional(seq(TOKENS.FINALLY, field('finally_body', $.block)))
            ),
            seq(TOKENS.TRY,
                field('try_body', $.block),
                TOKENS.FINALLY,
                field('finally_body', $.block)
            ),
        )),

        // Each handler consumes its trailing terminators (newlines/`;`) so the
        // handler loop stays sticky across lines (FU-1 fix) without grabbing
        // terminators via a failed "next handler" iteration (which over-consumed
        // trailing newlines in single-catch tries used as assignment RHS).
        _try_handler: $ => seq(
            choice($.catch_clause, $.handle_clause),
            repeat(terminator($))
        ),

        catch_clause: $ => seq(
            TOKENS.CATCH, '(', $.catch_pattern, ')',
            field('catch_body', $.block)
        ),

        handle_clause: $ => seq(
            TOKENS.HANDLE, '(',
            field('command_pattern', $.command_type_pattern),
            ')',
            field('handle_body', $.block)
        ),

        // command_type_pattern: a type optionally followed by a deconstruct tuple,
        // e.g. `Foo` or `Foo(x, y)`. See ParseCommandTypePattern (ParsePattern.cpp).
        command_type_pattern: $ => seq(
            field('type', $._type),
            optional($.tuple_pattern)
        ),

        resource_specifications: $ => commaSep1Trailing($.resource_specification),
        resource_specification: $ => seq($.identifier, optional(seq(':', $._type)), '=', $._expression),  // $.classType

        // Macro call expression: @Name!?( raw tokens ) and/or @Name!?[ raw tokens ]
        // Per Cangjie spec, macro parameters are RAW TOKEN STREAMS, not expressions:
        //  - unpaired ( ) [ ] are forbidden unless escaped \( \) \[ \]
        //  - bare @ in parameters requires escape: \@
        //  - literal backslash requires escape: \\
        // prec(9): lose to quote_expression (same precedence) when input is
        // quote(...); decorators still win via prec.dynamic on decorated_member.
        macro_expression: $ => prec(9, seq(
            '@', optional('!'), $._macro_name,
            optional($.macro_attribute_body),
            optional($.macro_call_body),
        )),

        // Attribute-macro form: @Name[ ... ]
        macro_attribute_body: $ => seq('[', repeat($._macro_body_item), ']'),
        // Call form: @Name( ... )
        macro_call_body: $ => seq('(', repeat($._macro_body_item), ')'),

        _macro_body_item: $ => choice(
            $.macro_escape,
            $.string_literal,
            $.rune_literal,
            $.macro_paren_group,
            $.macro_bracket_group,
            $.macro_raw_token,
        ),

        macro_paren_group: $ => seq('(', repeat($._macro_body_item), ')'),
        macro_bracket_group: $ => seq('[', repeat($._macro_body_item), ']'),

        macro_escape: _ => token(choice('\\(', '\\)', '\\[', '\\]', '\\@', '\\\\')),

        macro_raw_token: $ => token(prec(1, /[^()\\\[\]@'"]+/)),

        // One or more macro-call prefixes attached to a declaration.
        // Reuses `annotation` (aliased as `macro_call_prefix`) so its already-declared
        // conflicts cover this context too; lists CONCRETE decl types (not
        // _top_level_object) to avoid recursion.
        decorated_declaration: $ => prec.right(seq(
            repeat1(alias($.annotation, $.macro_call_prefix)),
            choice(
                $.class_definition,
                $.function_definition,
                $.struct_definition,
                $.interface_definition,
                $.enum_definition,
                $.type_alias,
                $.extend_definition
            )
        )),

        decorated_member: $ => prec.dynamic(1, prec.right(seq(
            repeat1(alias($.annotation, $.macro_call_prefix)),
            choice(
                $.variable_declaration,
                $.function_definition,
                $.operator_function_definition,
                $.property_definition,
                $.init,
                $.static_init
            )
        ))),

        quote_expression: $ => prec(9, seq(
            TOKENS.QUOTE,
            '(',
            repeat($._quote_body_item),
            ')'
        )),

        _quote_body_item: $ => choice(
            $.quote_interpolation,
            $._dollar_identifier,
            $.quote_escape,
            $.quote_paren_group,
            $.quote_raw_token
        ),

        quote_paren_group: $ => seq('(', repeat($._quote_body_item), ')'),

        quote_interpolation: $ => seq('$', '(', $._expression, ')'),

        quote_escape: $ => seq('\\', choice(/[^\\]/, '\\')),

        quote_raw_token: $ => token(/[^()$\\]+/),

        line_comment: _ => token(prec(PREC.COMMENT, seq('//', /[^\r\n\u2028\u2029]*/))),
        block_comment: $ => seq('/*', $._block_comment_content),
        _reserved_identifier: $ => choice(
            prec(-3, alias(
                choice(
                    TOKENS.PUBLIC,
                    TOKENS.PROTECTED,
                    TOKENS.PRIVATE,
                    TOKENS.INTERNAL,
                    TOKENS.ABSTRACT,
                    TOKENS.SEALED,
                    TOKENS.REDEF,
                    TOKENS.OPEN,
                    TOKENS.OVERRIDE,
                ),
                $.identifier
            ))
        ),
        identifier: _ => token(choice(
            /[a-zA-Z_][a-zA-Z0-9_]*/,
            seq('`', /[a-zA-Z_][a-zA-Z0-9_]*/, '`'),
        )),
        _dollar_identifier: $ => seq('$', $.identifier),

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
    },
};

module.exports = grammar(M);
