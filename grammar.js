/**
 * @file Cangjie grammar for tree-sitter
 * @author BonZer0 <sergeykovaltsov@gmail.com>
 * @license MIT
 */


const newline = /\r?\n/;

const terminator = ($) => choice($._terminator, ';');

// Even numbers: LET_COND (13) sits strictly between && (12) and | (14) — the
// conditional-binding reduce must beat && / || shifts but lose to every
// tighter operator, which stays inside the binding's RHS.
const PREC = {
    COMMENT: 0,
    ASSIGN: 2,
    PIPE: 4,
    COALESCE: 6,
    RANGE: 8,
    OR: 10,
    AND: 12,
    LET_COND: 13,
    BIT_OR: 14,
    BIT_XOR: 16,
    BIT_AND: 18,
    EQUALITY: 20,
    REL: 22,
    SHIFT: 24,
    ADD_SUB: 26,
    MUL_DIV: 28,
    POWER: 30,
    UNARY: 32,
    POSTFIX: 34,
    PARENS: 36,
    ARRAY: 38,
    MEMBER: 40,
    MACRO_QUOTE: 44,
    TOKEN: 46,
    INIT: -1,
    STATIC_INIT: -2,
};


const _kw = s => Object.fromEntries(s.split(/\s+/).map(w => [w.toUpperCase(), token(w)]));
const _kwWords = 'as break Bool case catch class const continue Rune do else enum extend features for from func finally foreign handle Float16 Float32 Float64 if in is init inout import interface Int8 Int16 Int32 Int64 IntNative let mut main macro match Nothing operator prop package quote return spawn super static struct synchronized perform resume with throwing try this true type throw unsafe Unit UInt8 UInt16 UInt32 UInt64 UIntNative var where while public protected internal private abstract sealed redef open override common specific';
const TOKENS = {
    ..._kw(_kwWords),
    NOT_IN: token('!in'), THISTYPE: token('This'),
};

const _kwUsed = [
    'as', 'break', 'Bool', 'case', 'catch', 'class', 'const', 'continue', 'Rune', 'do',
    'else', 'enum', 'extend', 'features', 'for', 'func', 'finally', 'foreign', 'handle',
    'Float16', 'Float32', 'Float64', 'if', 'in', 'is', 'init', 'inout', 'import',
    'interface', 'Int8', 'Int16', 'Int32', 'Int64', 'IntNative', 'let', 'mut', 'main',
    'macro', 'match', 'Nothing', 'operator', 'prop', 'package', 'return', 'spawn',
    'super', 'static', 'struct', 'synchronized', 'perform', 'resume', 'with', 'throwing',
    'try', 'this', 'type', 'throw', 'unsafe', 'Unit', 'UInt8', 'UInt16', 'UInt32',
    'UInt64', 'UIntNative', 'var', 'where', 'while',
    'public', 'protected', 'internal', 'private', 'abstract', 'sealed', 'redef',
    'open', 'override', 'common', 'specific',
];

const _primitiveKeywords = new Set([
    'Bool', 'Rune', 'String', 'Unit', 'Nothing',
    'Int8', 'Int16', 'Int32', 'Int64', 'IntNative',
    'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
    'Float16', 'Float32', 'Float64',
]);

const CONTEXTUAL_KEYWORDS = [
    'public', 'protected', 'private', 'internal',
    'abstract', 'sealed', 'redef', 'open', 'override',
    'common', 'specific', 'features', 'handle', 'main'
];

const SOFT_MODIFIER_WORDS = [
    'public', 'protected', 'private', 'internal',
    'abstract', 'sealed', 'redef', 'open', 'override',
    'common', 'specific',
];
const MODIFIER_TOKENS = SOFT_MODIFIER_WORDS.map(w => TOKENS[w.toUpperCase()]);

const GLOBAL_RESERVED = [
    ..._kwUsed.filter(w => !_primitiveKeywords.has(w) && !SOFT_MODIFIER_WORDS.includes(w)),
    'This',
];
const IDENTIFIER_POS_RESERVED = [
    ..._kwUsed.filter(w => !_primitiveKeywords.has(w)
        && !CONTEXTUAL_KEYWORDS.includes(w)),
    'This',
];
const NO_RESERVED = [];

const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));
const commaSep1Trailing = rule => seq(sep1(rule, ','), optional(','));

const hexDigit = /[0-9a-fA-F]/;
const hexDigits = seq(hexDigit, repeat(choice('_', hexDigit)));
const decimalDigits = seq(/[0-9]/, repeat(choice('_', /[0-9]/)));
const decimalLiteral = choice(/[0-9]/, seq(/[1-9]/, repeat1(choice('_', /[0-9]/))));

const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');

const bop = ($, p, ops, right, operand) => (right ? prec.right : prec.left)(p, seq(
    field('left', operand ?? $._expression),
    field('operator', choice(...ops.map(o => typeof o === 'string' ? token(o) : o))),
    field('right', operand ?? $._expression)));

const typeTail = $ => seq(
    optional(seq(token('<:'), $._super_interfaces)),
    optional($.generic_constraints),
);
const typeHeader = ($, keyword, nameField) => seq(
    optional($.modifiers), keyword, field('name', nameField),
    optional($.type_parameters),
    typeTail($),
);

const M = {
    name: 'cangjie',

    extras: $ => [
        /\s/,
        $.line_comment,
        $.block_comment,
    ],

    word: $ => $.identifier,
    
    reserved: {
      default: $ => GLOBAL_RESERVED,
      id: $ => IDENTIFIER_POS_RESERVED,
      none: $ => NO_RESERVED,
      modifier: $ => SOFT_MODIFIER_WORDS,
    },

    externals: $ => [
        $._terminator,
        $._block_comment_content,
        $._line_string_start,
        $._line_string_content,
        $._line_string_end,
        $._multiline_string_start,
        $._multiline_string_content,
        $._multiline_string_end,
        $._interp_open,
        $._interp_close,
        $._brace_open,
        $._brace_close,
        $._raw_string_start,
        $._raw_string_content,
        $._raw_string_end,
        $._quote_open,
        $._quote_content,
        $._quote_paren_open,
        $._quote_paren_close,
        $._quote_interp_open,
        $._quote_interp_close,
        $._quote_close,
        $._macro_at,
        $._macro_attr_open,
        $._macro_body_content,
        $._macro_attr_close,
        $._macro_input_open,
        $._macro_input_close,
        $._error_sentinel,
        $._generic_lt,
    ],

    supertypes: $ => [
        $._literal,
        $._expression,
        $._type,
    ],

    inline: $ => [
        $._logical_operand_right,
    ],

    conflicts: $ => [
        [$._call_tail],
        [$.modifiers, $._modifiers_var],
        [$.modifiers, $._var_decl_tail],
        [$.modifiers, $._primary_expression],
        [$._modifiers_var, $._primary_expression],
        [$.modifiers, $._modifiers_var, $._primary_expression],
    ],

    rules: {
// ===== top-level structure =====
        source_file: $ => seq(
            optional($.features_directive),
            optional(choice($.package_declaration, $.macro_package_declaration)),
            repeat($.import_list),
            repeat(seq(optional(token(';')), choice(choice(
                    $.variable_declaration, $.function_definition, $.operator_function_definition,
                    $.class_definition, $.interface_definition, $.struct_definition, $.enum_definition,
                    $.type_alias, $.extend_definition, $.foreign_declaration, $.macro_definition,
                    $.decorated_declaration, $.macro_expression,
                ), $.main_definition))),
            optional(token(';')),
        ),

        package_declaration: $ => seq(
            optional($.modifiers),
            TOKENS.PACKAGE, field('package_name', $._name), terminator($)
        ),
        macro_package_declaration: $ => seq(
            optional($.modifiers),
            TOKENS.MACRO, TOKENS.PACKAGE, field('package_name', $._name), terminator($)
        ),

        _import_packages: $ => choice(
            prec.right(-3, field('package_name', $._name)),
            prec.right(-2, $.package_full),
            prec.right(-1, $.package_alias),
        ),
        import_list: $ => seq(
            optional(repeat1($.macro_call)),
            optional($.modifiers),
            TOKENS.IMPORT,
            choice(
                $._import_packages,
                $.package_group,
                $.sub_group_of_package,
            ),
            terminator($)
        ),
        package_alias: $ => seq(
            field('package_name', $._name),
            TOKENS.AS,
            field('alias', reserved('id', $.identifier)),
        ),
        package_full: $ => seq(field('package_name', $._name), '.', token('*')),
        package_group: $ => seq(
            '{',
            seq($._import_packages, repeat(seq(',', $._import_packages))),
            optional(','),
            '}',
        ),
        sub_group_of_package: $ => seq(field('package_name', $._name), '.', $.package_group),

        features_directive: $ => prec.right(seq(
            optional(repeat1($.macro_call)),
            TOKENS.FEATURES,
            $.features_set,
            repeat1(terminator($))
        )),

        features_set: $ => seq(
            '{',
            commaSep1Trailing($.feature_id),
            '}'
        ),

        feature_id: $ => sep1(reserved('none', $.identifier), '.'),

        main_definition: $ => seq(
            TOKENS.MAIN, $.parameter_list, optional($.return_type),
            $.block
        ),

// ===== declarations =====
        modifiers: $ => prec.left(repeat1(choice(
            ...MODIFIER_TOKENS.map(t => reserved('modifier', t)),
            TOKENS.STATIC, TOKENS.CONST, TOKENS.MUT, TOKENS.UNSAFE,
        ))),
        _modifiers_var: $ => alias(prec.left(repeat1(choice(
            ...MODIFIER_TOKENS.map(t => reserved('modifier', t)),
            TOKENS.STATIC, TOKENS.MUT, TOKENS.UNSAFE,
        ))), $.modifiers),
        decorated_declaration: $ => prec.dynamic(1, prec.right(seq(
            repeat1($.macro_call),
            choice(
                $.class_definition, $.function_definition, $.struct_definition,
                $.interface_definition, $.enum_definition, $.type_alias, $.extend_definition,
                $.foreign_declaration, $.variable_declaration, $.operator_function_definition,
                $.property_definition, $.init, $.static_init, $.finalizer, $.primary_init,
            )
        ))),

        macro_definition: $ => seq(
            optional($.modifiers),
            TOKENS.MACRO, field('name', $._macro_name),
            field('parameters', seq('(', optional(commaSep1Trailing($.macro_parameter)), ')')),
            optional(field('return_type', $.return_type)),
            choice(
                seq('=', field('body', $._expression)),
                field('body', $.block)
            )
        ),

        macro_parameter: $ => seq(
            field('name', reserved('id', $.identifier)),
            optional('!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),
        _macro_name: $ => alias(prec.right(seq(repeat(seq(reserved('id', $.identifier), '.')), reserved('id', $.identifier))), $.macro_name),


        class_definition: $ => seq(typeHeader($, TOKENS.CLASS, $._class_name), field('body', $.declaration_body)),
        struct_definition: $ => seq(typeHeader($, TOKENS.STRUCT, alias(reserved('id', $.identifier), $.struct_name)), field('body', $.declaration_body)),

        interface_definition: $ => seq(typeHeader($, TOKENS.INTERFACE, alias(reserved('id', $.identifier), $.interface_name)), field('body', $.declaration_body)),
        enum_definition: $ => seq(typeHeader($, TOKENS.ENUM, alias(reserved('id', $.identifier), $.enum_name)), field('body', $.enum_body)),
        enum_body: $ => seq(
            '{', optional('|'),
            sep1(field('enum_constant', choice(
                    seq(reserved('id', $.identifier), optional(seq('(', commaSep1Trailing($._type), ')'))),
                    token('...')
                )), '|'),
            optional($._declaration_list),
            '}'
        ),

        extend_definition: $ => seq(
            optional($.modifiers),
            TOKENS.EXTEND,
            $.extend_type,
            typeTail($),
            field('body', $.declaration_body),
        ),

        type_alias: $ => seq(
            optional($.modifiers),
            TOKENS.TYPE,
            field('name', alias(reserved('id', $.identifier), $.type_alias_name)),
            optional($.type_parameters),
            '=',
            field('type', $._type)
        ),

        foreign_declaration: $ => seq(
            TOKENS.FOREIGN,
            choice(
                field('body', $.declaration_body),
                choice(
                        $.class_definition,
                        $.interface_definition,
                        $.function_definition,
                        $.variable_declaration
                    )
            )
        ),

        _declaration_list: $ => repeat1(seq(
            optional(repeat1(token(';'))),
            choice(
                    $.variable_declaration,
                    $.function_definition,
                    $.operator_function_definition,
                    $.property_definition,
                    $.init,
                    $.static_init,
                    $.primary_init,
                    $.finalizer,
                    $.decorated_declaration,
                    $.macro_expression,
                ),
        )),

        declaration_body: $ => seq(
            '{',
            optional($._declaration_list),
            '}'
        ),
        _class_name: $ => alias(reserved('id', $.identifier), $.class_name),
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

// ===== members & functions =====
        function_definition: $ => prec.right(seq(
            optional($.modifiers),
            TOKENS.FUNC,
            field('name', alias(reserved('id', $.identifier), $.func_name)),
            optional($.type_parameters),
            field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)),
            optional($.generic_constraints),
            optional(field('body', $.block))
        )),
        operator_function_definition: $ => seq(
            optional($.modifiers), TOKENS.OPERATOR, optional(TOKENS.CONST), TOKENS.FUNC,
            field('name', alias(choice(
                token(seq('[', ']')), token(seq('(', ')')),
                token('!'), token('+'), token('-'), token('**'), token('*'), token('/'), token('%'),
                token('<<'), token('>>'), token('<'), token('>'), token('<='), token('>='),
                token('=='), token('!='), token('&'), token('^'), token('|'),
            ), $.operator)),
            optional($.type_parameters), field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)), optional($.generic_constraints),
            optional(field('body', $.block)),
        ),

        property_definition: $ => seq(
            optional($.modifiers),
            TOKENS.PROP, field('name', alias(reserved('id', $.identifier), $.property_name)), ':', field('type', $._type),
            optional(seq(
                '{',
                optional(field('getter', seq(alias(reserved('none', $.identifier), $.getter_keyword), '(', ')', $.block))),
                optional(field('setter', seq(alias(reserved('none', $.identifier), $.setter_keyword), '(', reserved('none', $.identifier), ')', $.block))),
                '}',
            )),
        ),

        init: $ => prec(PREC.INIT, seq(
            optional($.modifiers),
            TOKENS.INIT, field('parameters', $.parameter_list),
            optional(field('body', $.block))
        )),
        static_init: $ => prec(PREC.STATIC_INIT, seq(
            TOKENS.STATIC, TOKENS.INIT, '(', ')',
            optional(field('body', $.block)),
        )),
        primary_init: $ => seq(
            optional($.modifiers),
            $._class_name, $.primary_init_param_list,
            '{',
            optional(repeat(seq(
                choice(
                    $._expression,
                    $.variable_declaration,
                    $.function_definition,
                ),
                optional(terminator($))),
            )),
            '}'
        ),
        primary_init_param_list: $ => seq('(',
            optional(commaSep1Trailing(choice(
                $.parameter,
                $.named_parameter,
                $.unnamed_member_param,
                $.named_member_param,
            ))),
            ')',
        ),
        named_member_param: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            $.named_parameter
        ),

        finalizer: $ => seq(
            '~', TOKENS.INIT, '(', ')',
            $.block
        ),

        return_type: $ => seq(':', field('type', $._type)),

        _super_interfaces: $ => seq(optional(seq($._super_interfaces, '&')), seq(alias($._name, $.super_or_interface), optional($.type_arguments))),
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

        block: $ => seq(
            '{',
            optional($._expression_or_declarations),
            '}',
        ),
        _expression_or_declarations: $ => repeat1(seq(
            choice(
                alias($._local_variable_declaration, $.variable_declaration),
                $.function_definition,
                $._expression
            ),
            repeat(terminator($)),
        )),

        _local_variable_declaration: $ => $._var_decl_tail,
        _var_decl_tail: $ => seq(
            choice(TOKENS.LET, TOKENS.VAR, TOKENS.CONST),
            field('name', alias($._pattern_irrefutable, $.variable_name)),
            choice(
                seq(':', field('type', $._type), optional(seq('=', field("initializer", $._expression)))),
                seq('=', field("initializer", $._expression))
            ),
        ),
        variable_declaration: $ => seq(
            optional($._modifiers_var),
            $._var_decl_tail,
        ),
// ===== parameters & calls =====
        parameter_list: $ => seq(
            '(',
            optional(choice(
                seq(sep1($.parameter, ','), optional(seq(',', sep1($.named_parameter, ',')))),
                sep1($.named_parameter, ','),
            )),
            optional($.ellipsis_parameter),
            optional(','),
            ')',
        ),

        parameter: $ => seq(
            optional(repeat1($.macro_call)),
            choice(
                seq(field('para_name', choice(reserved('id', $.identifier), '_')), ':', field('type', $._type)),
                seq('(', $.parameter, ')'),
                seq('(', $.named_parameter, ')'),
            )
        ),
        named_parameter: $ => seq(
            optional(repeat1($.macro_call)),
            seq(field('para_name', alias(choice(reserved('id', $.identifier), ...MODIFIER_TOKENS), $.identifier)), '!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),
        unnamed_member_param: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            field('para_name', choice(reserved('id', $.identifier), '_')),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),

        ellipsis_parameter: $ => seq(optional(','), '...'),
        call_suffix: $ => seq(
            '(',
            optional(commaSep1Trailing(choice(
                seq(reserved('id', $.identifier), ':', $._expression),
                $._expression,
                seq(TOKENS.INOUT, optional(seq($._expression, '.')), reserved('id', $.identifier))
            ))),
            $._call_tail
        ),
        // The "whose lambda?" fork, isolated so the conflict is named after it.
        _call_tail: $ => seq(')', optional($.lambda_expression)),
// ===== statements & expressions =====
        _primary_expression: $ => choice(
            $._literal,
            $.array_literal,
            alias(choice(reserved('id', $.identifier), ...MODIFIER_TOKENS), $.identifier),
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
            choice($.for_in_expression, $.while_expression, $.do_while_expression),
            $.try_expression,
            $.quote_expression,
            $.macro_expression,
            $._dollar_identifier,
            seq(
                    token('$('),
                    $._expression,
                    ')',
                ),
        ),

        _expression: $ => choice(
            $.postfix_expression,
            $.unary_expression,
            $.binary_expression,
            $.is_expression,
            $.as_expression,
            $.assignment_expression,
        ),

        assignment_expression: $ => prec.right(PREC.ASSIGN, seq(
            field('variable', prec(1, choice(
                    $.postfix_expression,
                    $.unary_expression,
                    $.binary_expression,
                    $.is_expression,
                    $.as_expression,
                ))),
            field('operator', choice(
                token('='), token('+='), token('-='), token('*='), token('/='), 
                token('%='), token('**='), token('&='), token('|='), token('^='),
                token('<<='), token('>>='), token("&&="), token("||=")
            )),
            field('value', $._expression),
        )),

        binary_expression: $ => prec.dynamic(-1, choice(
            prec.left(PREC.OR, seq(
                field('left', $._expression),
                field('operator', token('||')),
                field('right', $._logical_operand_right))),
            prec.left(PREC.AND, seq(
                field('left', $._expression),
                field('operator', token('&&')),
                field('right', $._logical_operand_right))),
            bop($, PREC.COALESCE,  ['??'], 'right'),
            bop($, PREC.EQUALITY,  ['==', '!=']),
            bop($, PREC.REL,       ['>', '<', '>=', '<=', TOKENS.IN, TOKENS.NOT_IN]),
            bop($, PREC.BIT_OR,    ['|']),
            bop($, PREC.BIT_XOR,   ['^']),
            bop($, PREC.BIT_AND,   ['&']),
            bop($, PREC.SHIFT,     ['<<', '>>']),
            bop($, PREC.ADD_SUB,   ['+', '-']),
            bop($, PREC.MUL_DIV,   ['*', '/', '%']),
            bop($, PREC.POWER,     ['**'], 'right'),
            bop($, PREC.PIPE,      ['|>', '~>']),
        )),

        unary_expression: $ => prec.left(PREC.UNARY, seq(
            field('operator', choice('!', '-')),
            field('argument', $._expression)
        )),

        is_expression: $ => prec.right(PREC.REL, seq(
            field('left', $._expression), TOKENS.IS, field('type', $._type))),
        as_expression: $ => prec.right(PREC.REL, seq(
            field('left', $._expression), TOKENS.AS, field('type', $._type))),

        _logical_operand_right: $ => choice($._expression, $.let_pattern_destructor),
        _cond_tail: $ => seq(
            $.let_pattern_destructor,
            repeat(seq(choice('&&', '||'), $._logical_operand_right))),

        parenthesized_expression: $ => seq('(', choice($._expression, $._cond_tail), ')'),
        tuple_expression: $ => seq('(', $._expression, repeat1(seq(',', $._expression)), optional(','), ')'),
        array_literal: $ => seq('[', optional(commaSep1Trailing(choice($._expression, seq('*', $._expression)))), ']'),

        range_expression: $ => prec.right(PREC.RANGE, seq(
            optional(field('start', $._expression)),
            choice(token('..'), token('..=')),
            optional(field('end', $._expression)),
            optional(seq(':', field('step', $._expression)))
        )),

        lambda_expression: $ => seq(
            choice('{', $._brace_open),
            optional(seq(optional($.lambda_parameters), token('=>'))),
            optional($._expression_or_declarations),
            choice('}', $._brace_close)
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
        if_expression: $ => prec.left(seq(
            TOKENS.IF,
            field('condition', seq('(', choice($._expression, $._cond_tail), ')')),
            field('consequence', $.block),
            optional(field('alternative', seq(TOKENS.ELSE, choice($.if_expression, $.block))))
        )),

        while_expression: $ => seq(
            TOKENS.WHILE, '(', choice($._expression, $._cond_tail), ')',
            $.block
        ),

        do_while_expression: $ => seq(TOKENS.DO, field('body', $.block), TOKENS.WHILE, '(', choice($._expression, $._cond_tail), ')'),

        for_in_expression: $ => seq(
            TOKENS.FOR, '(', $._pattern_irrefutable, TOKENS.IN, $._expression, optional($.pattern_guard), ')', $.block
        ),

        match_expression: $ => choice(
            seq(TOKENS.MATCH,
                '(', field('condition', $._expression), ')',
                '{', repeat1($.case_pattern), '}'),
            seq(TOKENS.MATCH,
                '{', repeat1($.case_expression), '}'),
        ),
        case_pattern: $ => seq(
            TOKENS.CASE, $._pattern, optional($.pattern_guard),
            token('=>'),
            $._expression_or_declarations,
        ),
        case_expression: $ => seq(
            TOKENS.CASE, $._expression, token('=>'),
            $._expression_or_declarations,
        ),

        pattern_guard: $ => seq(TOKENS.WHERE, $._expression),

        try_expression: $ => prec.right(seq(
            TOKENS.TRY,
            optional(seq('(', field('resources', $.resource_specifications), ')')),
            field('try_body', $.block),
            repeat(choice($.catch_clause, $.handle_clause)),
            optional(seq(TOKENS.FINALLY, field('finally_body', $.block)))
        )),


        resource_specifications: $ => commaSep1Trailing($.resource_specification),
        resource_specification: $ => seq(reserved('id', $.identifier), optional(seq(':', $._type)), '=', $._expression),  // $.classType

        catch_clause: $ => seq(
            TOKENS.CATCH,
            choice(
                seq('(', optional($.catch_pattern), ')'),
                $.catch_pattern,
            ),
            field('catch_body', $.block)
        ),

        handle_clause: $ => seq(
            TOKENS.HANDLE, '(',
            field('command_pattern', $.command_type_pattern),
            ')',
            field('handle_body', $.block)
        ),

        command_type_pattern: $ => seq(
            optional(seq(choice($.wildcard_pattern, $._var_binding_pattern), ':')),
            field('type', $._type),
            optional($.tuple_pattern)
        ),

        synchronized_expression: $ => seq(TOKENS.SYNCHRONIZED, '(', $._expression, ')', $.block),
        spawn_expression: $ => seq(TOKENS.SPAWN, optional(seq('(', $._expression, ')')), $.lambda_expression),
        perform_expression: $ => seq(TOKENS.PERFORM, field('argument', $._expression)),

        resume_expression: $ => prec.left(seq(
            TOKENS.RESUME,
            optional(choice(
                seq(TOKENS.WITH, field('with_argument', $._expression)),
                seq(TOKENS.THROWING, field('throwing_argument', $._expression)),
            )),
        )),
        unsafe_expression: $ => seq(TOKENS.UNSAFE, $.block),

        // prec(LET_COND): the reduce beats && / || shifts — `(let p <- a) && b`,
        // the bound name in scope for the tail; tighter operators stay in the RHS.
        let_pattern_destructor: $ => prec(PREC.LET_COND, seq(
            TOKENS.LET, $._pattern, token('<-'), $._expression,
        )),

        _dollar_identifier: $ => seq('$', reserved('none', $.identifier)),

        // Macro parameters are RAW TOKEN STREAMS (spec); loses to
        // quote_expression, wins over decorators via prec.dynamic.
        macro_expression: $ => prec.dynamic(-1, seq(
            alias($._macro_at, $.macro_call_sigil),
            optional('!'),
            $._macro_name,
            optional(alias($._macro_attr_body, $.macro_attribute_body)),
            optional(alias($._macro_input_body, $.macro_call_body)),
        )),

        quote_expression: $ => prec(PREC.MACRO_QUOTE, seq(
            alias($._quote_open, $.quote_keyword),
            repeat($._quote_body_item),
            alias($._quote_close, $.quote_close),
        )),

        _quote_body_item: $ => choice(
            alias($._quote_content, $.quote_raw_token),
            $.escape_sequence,
            $.string_literal,
            $.rune_literal,
            alias($._quote_paren_open, $.quote_paren),
            alias($._quote_paren_close, $.quote_paren),
            $.quote_interpolation,
            $._dollar_identifier,
        ),

        quote_interpolation: $ => seq(
            alias($._quote_interp_open, $.quote_interp_open),
            $._expression,
            alias($._quote_interp_close, $.quote_interp_close),
        ),

        line_comment: _ => token(prec(PREC.COMMENT, seq('//', /[^\r\n\u2028\u2029]*/))),

        // Two tiers: REFUTABLE (enum/const/typed/or) for match + `let p <- e`;
        // IRREFUTABLE (wildcard/binding/tuples of the same) for plain let and
        // foreach — tuples recurse with their tier. catch_pattern is outside.
        _pattern: $ => choice(
            $.or_pattern,
            $._pattern_single,
        ),

        _pattern_single: $ => choice(
            $.wildcard_pattern,
            $._var_binding_pattern,
            $.tuple_pattern,
            $.enum_pattern,
            $._constant_pattern,
            $.type_pattern,
        ),

        wildcard_pattern: _ => token('_'),
        or_pattern: $ => seq($._pattern_single, repeat1(seq('|', $._pattern_single))),

        _pattern_irrefutable: $ => choice(
            $.wildcard_pattern,
            $._var_binding_pattern,
            alias($._tuple_pattern_irrefutable, $.tuple_pattern),
        ),

        _tuple_pattern_irrefutable: $ => seq('(', commaSep1Trailing($._pattern_irrefutable), ')'),
        _var_binding_pattern: $ => alias(choice(reserved('id', $.identifier), ...MODIFIER_TOKENS), $.var_binding_pattern),
        tuple_pattern: $ => seq('(', commaSep1Trailing($._pattern), ')'),

        enum_pattern: $ => choice(
            seq(seq($._name, optional($.type_arguments), '.'), field('constructor', alias(reserved('id', $.identifier), $.enum_constructor)),
                optional(field('arguments', $.enum_pattern_arguments))),
            seq(field('constructor', alias(reserved('id', $.identifier), $.enum_constructor)), field('arguments', $.enum_pattern_arguments)),
        ),
        enum_pattern_arguments: $ => seq('(', commaSep1Trailing($._pattern), ')'),

        _constant_pattern: $ => alias(choice($._literal, seq('-', $._literal)), $.constant_pattern),

        type_pattern: $ => seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', $._type),

        catch_pattern: $ => choice($.wildcard_pattern, seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', sep1($._type, '|'))),

// ===== types =====
        _type: $ => choice(
            $.arrow_type, $.tuple_type, $.prefix_type,
            alias(TOKENS.INT8, $.Int8), alias(TOKENS.INT16, $.Int16), alias(TOKENS.INT32, $.Int32), alias(TOKENS.INT64, $.Int64), alias(TOKENS.INTNATIVE, $.IntNative),
            alias(TOKENS.UINT8, $.UInt8), alias(TOKENS.UINT16, $.UInt16), alias(TOKENS.UINT32, $.UInt32), alias(TOKENS.UINT64, $.UInt64), alias(TOKENS.UINTNATIVE, $.UIntNative),
            alias(TOKENS.FLOAT16, $.Float16), alias(TOKENS.FLOAT32, $.Float32), alias(TOKENS.FLOAT64, $.Float64),
            alias(token('String'), $.String), alias(TOKENS.RUNE, $.Rune), alias(TOKENS.BOOL, $.Bool),
            alias(TOKENS.NOTHING, $.Nothing), alias(TOKENS.UNIT, $.Unit), alias(TOKENS.THISTYPE, $.Thistype),
            $.user_type, $.generic_type,
            $.const_generic,
        ),

        user_type: $ => prec.right(seq($._name, optional($.type_arguments))),
        generic_type: $ => seq(choice(token('Array'), token('Range')), $.type_arguments),

        arrow_type: $ => seq('(', optional($._named_or_type_list), ')', token('->'), field('type', $._type)),

        tuple_type: $ => seq('(', optional(field('type', $._named_or_type_list)), ')'),

        prefix_type: $ => seq('?', field('type', $._type)),

        const_generic: $ => seq(token('$'), $.integer_literal),

        // Type world: '<' is an unambiguous internal token.
        type_arguments: $ => seq('<', $._type_list, '>'),
        // Expression world: _generic_lt is a ZERO-WIDTH decision token (Swift
        // follow-set rule, scanner.c); hidden + aliased so both worlds surface
        // ONE node type: type_arguments.
        _generic_arguments: $ => seq($._generic_lt, '<', $._type_list, '>'),

        _type_list: $ => commaSep1Trailing($._type),

        _named_or_type_list: $ => commaSep1Trailing(choice(
            seq(reserved('id', $.identifier), ':', $._type),
            $._type
        )),

        type_parameters: $ => seq('<', commaSep1Trailing($.type_parameter), '>'),

        type_parameter: $ => seq(
            field('name', reserved('id', $.identifier)),
        ),

// ===== names & suffixes =====
        _name: $ => choice(
            reserved('id', $.identifier),
            $.scoped_identifier,
        ),        scoped_identifier: $ => seq(
            field("scope", $._name), '.', field('name', reserved('id', $.identifier))),
        field_access: $ => seq('.', reserved('id', $.identifier)),
        scope_resolution: $ => seq('::', reserved('id', $.identifier)),
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
            $.lambda_expression,
        )),
        inc_or_dec: _ => token(choice('++', '--')),

        postfix_expression: $ => choice(
            $._primary_expression,
            prec.right(PREC.MEMBER, seq(
                field('base', $.postfix_expression),
                field('suffix', choice(
                        prec(PREC.MEMBER, $.field_access), prec(PREC.MEMBER, $.scope_resolution),
                        prec(PREC.ARRAY, $.index_access), prec(PREC.POSTFIX, $.quest_access),
                        prec(PREC.PARENS, $.call_suffix), prec(PREC.POSTFIX, $.inc_or_dec),
                        alias($._generic_arguments, $.type_arguments),
                        $.lambda_expression,
                    )),
            )),
        ),

// ===== literals & lexicals =====
        _literal: $ => choice(
            $.integer_literal, $.float_literal, $.rune_literal, $.byte_literal,
            $.boolean_literal, $.string_literal, $.unit_literal,
        ),

        integer_literal: _ => token(seq(
            choice(
                seq('0', choice('x', 'X'), hexDigits),
                seq('0', choice('o', 'O'), seq(/[0-7]/, repeat(choice('_', /[0-7]/)))),
                seq('0', choice('b', 'B'), seq(/[01]/, repeat(choice('_', /[01]/)))),
                decimalLiteral,
            ),
            optional(/_?[iu](8|16|32|64)/),
        )),
        float_literal: _ => token(choice(
            seq(
                choice(
                    seq(decimalLiteral, seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits)),
                    seq(decimalLiteral, '.', decimalDigits, optional(seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits))),
                    seq('.', decimalDigits, optional(seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits))),
                ),
                optional(/_?[fF](16|32|64)/),
            ),
            seq(
                '0', choice('x', 'X'),
                choice(hexDigits, seq(hexDigits, '.', hexDigits), seq('.', hexDigits)),
                seq(choice('p', 'P'), optional(choice('+', '-')), decimalDigits),
            ),
        )),
        rune_literal: _ => token(choice(
            seq('r\'', choice(/[^'\\]/, uniCharacterLiteral, /\\./), '\''),
            seq('r"', choice(/[^"\\]/, uniCharacterLiteral, /\\./), '"'),
        )),
        byte_literal: _ => token(seq('b\'', choice(
            /[^\\'\n]/,                      // a single printable character
            seq('\\x', hexDigit, hexDigit),  // the \\xNN byte escape
            /\\./,                            // permissive fallback
        ), '\'')),
        escape_sequence: _ => token(choice(
            /\\u\{[0-9a-fA-F]{1,8}\}/,   // the canonical unicode form
            /\\./,                          // permissive: any other escape
        )),
        boolean_literal: _ => token(prec(PREC.TOKEN, choice('true', 'false'))),

        // The delimiters are aliased so queries can color them (anonymous
        // externals are not queryable); content runs keep expression coloring
        // of interpolations intact.
        string_literal: $ => choice(
            prec.right(seq(
                alias($._line_string_start, $.string_start),
                repeat(choice(alias($._line_string_content, $.string_content), $.escape_sequence, $.string_interpolation)),
                optional(alias($._line_string_end, $.string_end)),
            )),
            prec.right(seq(
                alias($._multiline_string_start, $.string_start),
                optional(seq(optional(/\r/), /\n/)),
                repeat(choice(alias($._multiline_string_content, $.string_content), $.escape_sequence, $.string_interpolation)),
                optional(alias($._multiline_string_end, $.string_end)))),
            seq(alias($._raw_string_start, $.string_start),
               optional(alias($._raw_string_content, $.string_content)),
               optional(alias($._raw_string_end, $.string_end)),
            )),


        string_interpolation: $ => seq(
            alias($._interp_open, $.interp_open),
            repeat(seq(
                optional(repeat1(terminator($))),
                $._interpolation_statement,
            )),
            alias($._interp_close, $.interp_close),
        ),

        _interpolation_statement: $ => choice(alias($._local_variable_declaration, $.variable_declaration), $._expression),

        unit_literal: _ => seq('(', ')'),

        macro_call: $ => prec(1, seq(
            alias($._macro_at, $.macro_call_sigil),
            optional('!'),
            $._macro_name,
            optional(alias($._macro_attr_body, $.macro_attribute_body)),
        )),

        _macro_attr_body: $ => prec.right(seq(
            alias($._macro_attr_open, $.macro_attr_open),
            repeat($._macro_body_item),
            optional(alias($._macro_attr_close, $.macro_attr_close)),
        )),

        _macro_input_body: $ => prec.right(seq(
            alias($._macro_input_open, $.macro_input_open),
            repeat($._macro_body_item),
            optional(alias($._macro_input_close, $.macro_input_close)),
        )),

        _macro_body_item: $ => choice(
            alias($._macro_body_content, $.macro_raw_token),
            $.escape_sequence,
            $.string_literal,
            $.rune_literal,
        ),

        block_comment: $ => seq('/*', $._block_comment_content),
        identifier: _ => token(choice(
            /[a-zA-Z_][a-zA-Z0-9_]*/,
            seq('`', /[a-zA-Z_][a-zA-Z0-9_]*/, '`'),
        )),

    },
};

module.exports = grammar(M);
