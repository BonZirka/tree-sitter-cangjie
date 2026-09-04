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
    TOKEN: 1,
    COMMENT: 0, ASSIGN: 0, PIPE: 1, COALESCE: 2, OR: 13, AND: 14,
    BIT_OR: 15, BIT_XOR: 16, BIT_AND: 17, EQUALITY: 18, REL: 19,
    // Range binds looser than every arithmetic/logical/bitwise operator
    // (Cangjie spec: just above assignment) — `(x&127)..=(y&127):step` is the
    // corpus's dominant mask-range idiom and misgroups if RANGE is tighter.
    RANGE: 12, SHIFT: 21, ADD_SUB: 22, MUL_DIV: 23, POWER: 24,
    UNARY: 25, POSTFIX: 26, PARENS: 27, ARRAY: 28, MEMBER: 29, MARCO_CALL: 30,
    INIT: -1, STATIC_INIT: -2, RESERVED_ID: -3, MACRO_QUOTE: 9,
};

// Keyword tokens; key = UPPER(value) for all but NOT_IN and THISTYPE.
const _kw = s => Object.fromEntries(s.split(/\s+/).map(w => [w.toUpperCase(), token(w)]));
const TOKENS = {
    ..._kw('as break Bool case catch class const continue Rune do else enum extend features for from func finally foreign handle Float16 Float32 Float64 if in is init inout import interface Int8 Int16 Int32 Int64 IntNative let mut main macro match Nothing operator prop package quote return spawn super static struct synchronized perform resume with throwing try this true type throw unsafe Unit UInt8 UInt16 UInt32 UInt64 UIntNative var where while public protected internal private abstract sealed redef open override common specific'),
    NOT_IN: token('!in'), THISTYPE: token('This'),
};

const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));
const commaSep1Trailing = rule => seq(sep1(rule, ','), optional(','));

const hexDigit = /[0-9a-fA-F]/;
const hexDigits = seq(hexDigit, repeat(choice('_', hexDigit)));
const decimalDigits = seq(/[0-9]/, repeat(choice('_', /[0-9]/)));
const decimalLiteral = choice(/[0-9]/, seq(/[1-9]/, repeat1(choice('_', /[0-9]/))));

const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');

// Single-line string of one quote kind. The body chunk is token.immediate()
// so extras (whitespace/newlines) can never be skipped between body items —
// otherwise the body repeat would silently absorb following lines into an
// unclosed string. The closer is immediate too: a line string must close on
// its opening line.
const lineStr = ($, q, body) => seq(q, repeat(choice(token.immediate(prec(PREC.TOKEN, body)), token.immediate('$'), uniCharacterLiteral, $.escape_sequence, $.inline_expression)), q);
// Multi-line string opened/closed by a triple-quote token (""" or ''').
const multiLineStr = ($, open) => seq(seq(open, /\r?\n/), repeat(choice(/[^\\]/, uniCharacterLiteral, $.escape_sequence, $.in_multi_line_string_expression)), open);

// Binary operator production: one precedence class, shared operand shape.
const bop = ($, p, ops, right) => (right ? prec.right : prec.left)(p, seq(
    field('left', $._expression),
    field('operator', choice(...ops.map(o => typeof o === 'string' ? token(o) : o))),
    field('right', $._expression)));

// Shared type-definition tail: supertype clause + generic constraints.
const typeTail = $ => seq(
    optional(seq(token('<:'), $._super_interfaces)),
    optional($.generic_constraints),
);
// Common header for type definitions (class/struct/enum/interface).
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

    externals: $ => [
        $._terminator,
        $._block_comment_content,
        $._multi_line_raw_string_start,
        $._multi_line_raw_string_content,
        $._multi_line_raw_string_end,
        $._line_string_tail_single,
        $._line_string_tail_double,
        $._error_sentinel,
    ],

    supertypes: $ => [
        $._literal,
    ],

    conflicts: $ => [
        [$.modifiers],
        [$.modifiers, $.variable_declaration],
        [$.call_suffix],
        [$.function_definition],
        [$._declaration_list],
        [$._top_objects],
        [$.primary_init, $.this_super_expression],
        [$.atomic_variable],
        [$.macro_expression],
        [$._try_handler],
        [$.named_parameter, $.unnamed_member_param],
        [$._macro_name, $.annotation],
        [$._macro_name],
        [$.annotation_list, $.decorated_declaration],
        [$.features_directive],
        [$.translation_unit, $._top_level_object],
        [$.wildcard_pattern, $.match_case_body],
        [$._name, $._var_binding_pattern],
        [$.enum_pattern, $.atomic_variable],
        [$._pattern, $.atomic_variable],
        [$._constant_pattern, $._atomic_expression],
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
            TOKENS.PUBLIC, TOKENS.PROTECTED, TOKENS.PRIVATE, TOKENS.INTERNAL,
            TOKENS.ABSTRACT, TOKENS.STATIC, TOKENS.SEALED, TOKENS.REDEF,
            TOKENS.OPEN, TOKENS.OVERRIDE, TOKENS.MUT, TOKENS.UNSAFE,
            TOKENS.CONST, TOKENS.COMMON, TOKENS.SPECIFIC,
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
            $.arrow_type, $.tuple_type, $.prefix_type,
            alias(TOKENS.INT8, $.Int8), alias(TOKENS.INT16, $.Int16), alias(TOKENS.INT32, $.Int32), alias(TOKENS.INT64, $.Int64), alias(TOKENS.INTNATIVE, $.IntNative),
            alias(TOKENS.UINT8, $.UInt8), alias(TOKENS.UINT16, $.UInt16), alias(TOKENS.UINT32, $.UInt32), alias(TOKENS.UINT64, $.UInt64), alias(TOKENS.UINTNATIVE, $.UIntNative),
            alias(TOKENS.FLOAT16, $.Float16), alias(TOKENS.FLOAT32, $.Float32), alias(TOKENS.FLOAT64, $.Float64),
            alias(token('String'), $.String), alias(TOKENS.RUNE, $.Rune), alias(TOKENS.BOOL, $.Bool),
            alias(TOKENS.NOTHING, $.Nothing), alias(TOKENS.UNIT, $.Unit), alias(TOKENS.THISTYPE, $.Thistype),
            $.user_type, $.generic_type,
            // Const generic argument (`$5` in `VArray<Bool, $5>`). Only VArray
            // accepts them, but the grammar stays permissive.
            $.const_generic,
        ),

        arrow_type: $ => seq('(', optional($._named_or_type_list), ')', token('->'), field('type', $._type)),

        tuple_type: $ => seq('(', optional(field('type', $._named_or_type_list)), ')'),

        _type_list: $ => commaSep1Trailing($._type),

        _named_or_type_list: $ => commaSep1Trailing(choice(
            seq($.identifier, ':', $._type),
            $._type
        )),

        prefix_type: $ => seq('?', field('type', $._type)),

        // prec.right: `as Foo<Bar>` keeps `<Bar>` in the type instead of
        // spilling into an outer relational continuation (`(x as Foo) < Bar`).
        user_type: $ => prec.right(seq($._name, optional($.type_arguments))),
        generic_type: $ => seq(choice(token('Array'), token('Range')), $.type_arguments),

        const_generic: $ => seq(token('$'), $.integer_literal),

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
                $._expression
            ),
        ),

        //top level objects
        _top_level_object: $ => choice(
            $.variable_declaration, $.function_definition, $.operator_function_definition,
            $.class_definition, $.interface_definition, $.struct_definition, $.enum_definition,
            $.type_alias, $.extend_definition, $.foreign_declaration, $.macro_definition,
            $.macro_expression, $.decorated_declaration, $.features_directive,
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
        // Parameters may carry stacked annotations (@A0 / @A1[12]) and may be
        // wrapped in parens — `init(@M1 (a: Int64), @M1[x] (b!: Int64))` is the
        // macro-expansion-in-parameter-position shape (cjc-verified). The
        // paren group lives only on `parameter`; its inner contents are
        // disjoint (named_parameter requires `!`), so no GLR conflict.
        parameter: $ => seq(
            optional($.annotation_list),
            choice(
                seq(field('para_name', choice($.identifier, '_')), ':', field('type', $._type)),
                seq('(', $.parameter, ')'),
                seq('(', $.named_parameter, ')'),
            )
        ),
        named_parameter: $ => seq(
            optional($.annotation_list),
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

        interface_definition: $ => seq(typeHeader($, TOKENS.INTERFACE, $._interface_name), field('body', $.declaration_body)),
        _interface_name: $ => alias($.identifier, $.interface_name),
        _super_interfaces: $ => seq(optional(seq($._super_interfaces, '&')), $._interface_type),
        _interface_type: $ => seq(alias($._name, $.super_or_interface), optional($.type_arguments)),
        // Unified declaration body - permissive, accepts all member types
        declaration_body: $ => seq(
            '{',
            optional($._declaration_list),
            '}'
        ),
        _declaration_list: $ => seq(
            optional(seq($._declaration_list, repeat1(terminator($)))),
            $._member_declaration,
            optional(repeat1(terminator($))),
        ),
        _member_declaration: $ => choice(
            $.variable_declaration,
            $.function_definition,
            $.operator_function_definition,
            $.property_definition,
            $.init,
            $.static_init,
            $.primary_init,
            $.finalizer,
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

        class_definition: $ => seq(typeHeader($, TOKENS.CLASS, $._class_name), field('body', $.declaration_body)),
        _class_name: $ => alias($.identifier, $.class_name),
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
            optional(seq(TOKENS.SUPER, $.call_suffix, terminator($))),
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
        unnamed_member_param: $ => seq(
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            field('para_name', choice($.identifier, '_')),
            optional('!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
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

        struct_definition: $ => seq(typeHeader($, TOKENS.STRUCT, $._struct_name), field('body', $.declaration_body)),
        _struct_name: $ => alias($.identifier, $.struct_name),

        enum_definition: $ => seq(typeHeader($, TOKENS.ENUM, $._enum_name), field('body', $.enum_body)),
        _enum_name: $ => alias($.identifier, $.enum_name),
        enum_body: $ => seq(
            '{', optional('|'),
            sep1(field('enum_constant', $._case_body), '|'),
            optional($._declaration_list),
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
            typeTail($),
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

        extend_body: $ => seq(field('body', $.declaration_body)),

        foreign_declaration: $ => seq(
            TOKENS.FOREIGN,
            choice(
                field('body', $.declaration_body),
                $._foreign_member_declaration
            )
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
        // Macro names may be package-qualified: `@p1.M1[tok](body)` (the
        // standard macro-package form, cjc-verified).
        _macro_name: $ => alias(seq(repeat(seq($.identifier, '.')), $.identifier), $.macro_name),

        annotation_list: $ => repeat1($.annotation),
        annotation: $ => seq(
            '@', optional('!'),
            alias(seq(repeat(seq($.identifier, '.')), $.identifier), $.annotation_name),
            optional(seq('[', $._annotation_argument_list, ']'))
        ),
        _annotation_argument_list: $ => commaSep1Trailing($.annotation_argument),
        annotation_argument: $ => choice(
            seq($.identifier, ':', $._expression),
            $._expression
        ),

        // Assignment targets: everything except the prefix rules that take a
        // bare _expression body (perform/resume) — otherwise `perform x = y`
        // is genuinely ambiguous between `perform (x = y)` and
        // `(perform x) = y`.
        _assignable: $ => prec(1, choice(
            $._atomic_expression,
            $.unary_expression,
            $.binary_expression,
            $.is_expression,
            $.as_expression,
        )),

        // expressions
        assignment_expression: $ => prec.right(PREC.ASSIGN, seq(
            field('variable', $._assignable),
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
            $.is_expression,
            $.as_expression,
            $.assignment_expression,
            $._atomic_expression,
        ),

        _atomic_expression: $ => choice(
            $._literal, $.array_literal, $.atomic_variable, $.range_expression,
            $.parenthesized_expression, $.tuple_expression, $.postfix_expression,
            $.jump_expression, $.lambda_expression, $.synchronized_expression,
            $.spawn_expression, $.perform_expression, $.resume_expression,
            $.unsafe_expression, $.this_super_expression, $.if_expression,
            $.match_expression, $._loop_expression, $.try_expression,
            $.quote_expression, $.macro_expression, $.let_pattern_destructor,
            $._dollar_identifier, $._dollar_call,
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

        binary_expression: $ => choice(
            bop($, PREC.OR,        ['||']),
            bop($, PREC.AND,       ['&&']),
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
        ),

        // `e is T` / `e as T` take a *type* on the right (Cangjie spec) — a
        // plain bop with $._expression would reject function types like
        // `() -> Range<UInt16>`. prec.right keeps `<`/`.` inside the type
        // operand (`x as Foo<Bar>`, `x as Foo.Bar`) instead of spilling into
        // an outer relational/postfix continuation.
        is_expression: $ => prec.right(PREC.REL, seq(
            field('left', $._expression), TOKENS.IS, field('type', $._type))),
        as_expression: $ => prec.right(PREC.REL, seq(
            field('left', $._expression), TOKENS.AS, field('type', $._type))),

        array_literal: $ => seq('[', optional(commaSep1Trailing(choice($._expression, seq('*', $._expression)))), ']'),

        atomic_variable: $ => seq($._var_binding_pattern, optional($.type_arguments)),
        parenthesized_expression: $ => seq('(', $._expression, ')'),
        range_expression: $ => prec.right(PREC.RANGE, seq(
            optional(field('start', $._expression)),
            choice(token('..'), token('..=')),
            optional(field('end', $._expression)),
            optional(seq(':', field('step', $._expression)))
        )),

        postfix_expression: $ => prec.right(PREC.MEMBER, seq($._expression, choice(
            prec(PREC.MEMBER, $.field_access), prec(PREC.MEMBER, $.scope_resolution),
            prec(PREC.ARRAY, $.index_access), prec(PREC.POSTFIX, $.quest_access),
            prec(PREC.PARENS, $.call_suffix), prec(PREC.POSTFIX, $.inc_or_dec),
            $.trailing_lambda_expression,
        ))),

        field_access: $ => seq('.', $.atomic_variable),
        scope_resolution: $ => seq('::', $.atomic_variable),
        call_suffix: $ => seq(
            '(',
            optional(commaSep1Trailing(choice(
                seq($._var_binding_pattern, ':', $._expression),
                $._expression,
                seq(TOKENS.INOUT, optional(seq($._expression, '.')), $._var_binding_pattern)
            ))),
            ')',
            // No comma-form: `f(x, { ... })` parses `{ ... }` as a plain
            // lambda_expression argument. The old
            // `optional(seq(',', trailing_lambda_expression))` made every
            // `, {` after a nested call's `)` spawn a "whose lambda?" GLR
            // version that lived across the whole argument list.
            optional($.trailing_lambda_expression)
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
        inc_or_dec: _ => token(choice('++', '--')),

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

        _loop_expression: $ => choice($.for_in_expression, $.while_expression, $.do_while_expression),

        for_in_expression: $ => seq(
            TOKENS.FOR, '(', $._patterns_maybe_irrefutable, TOKENS.IN, $._expression, optional($.pattern_guard), ')', $.block
        ),

        while_expression: $ => seq(
            TOKENS.WHILE, '(', $._expression, ')',
            $.block
        ),

        do_while_expression: $ => seq(TOKENS.DO, field('body', $.block), TOKENS.WHILE, '(', $._expression, ')'),

        try_expression: $ => prec.right(seq(
            TOKENS.TRY,
            optional(seq('(', field('resources', $.resource_specifications), ')')),
            field('try_body', $.block),
            repeat($._try_handler),
            optional(seq(TOKENS.FINALLY, field('finally_body', $.block)))
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
        // prec(PREC.MACRO_QUOTE): lose to quote_expression (same precedence) when input is
        // quote(...); decorators still win via prec.dynamic on decorated_member.
        macro_expression: $ => prec(PREC.MACRO_QUOTE, seq(
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

        macro_raw_token: $ => token(prec(PREC.TOKEN, /[^()\\\[\]@'"]+/)),

        // One or more macro-call prefixes attached to a declaration.
        // Reuses `annotation` (aliased as `macro_call_prefix`) so its already-declared
        // conflicts cover this context too; lists CONCRETE decl types (not
        // _top_level_object) to avoid recursion.
        decorated_declaration: $ => prec.right(seq(
            repeat1(alias($.annotation, $.macro_call_prefix)),
            choice(
                $.class_definition, $.function_definition, $.struct_definition,
                $.interface_definition, $.enum_definition, $.type_alias, $.extend_definition,
            )
        )),

        decorated_member: $ => prec.dynamic(1, prec.right(seq(
            repeat1(alias($.annotation, $.macro_call_prefix)),
            choice(
                $.variable_declaration, $.function_definition, $.operator_function_definition,
                $.property_definition, $.init, $.static_init,
            )
        ))),

        quote_expression: $ => prec(PREC.MACRO_QUOTE, seq(
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
            prec(PREC.RESERVED_ID, alias(choice(
                TOKENS.PUBLIC, TOKENS.PROTECTED, TOKENS.PRIVATE, TOKENS.INTERNAL,
                TOKENS.ABSTRACT, TOKENS.SEALED, TOKENS.REDEF, TOKENS.OPEN, TOKENS.OVERRIDE,
            ), $.identifier))
        ),
        identifier: _ => token(choice(
            /[a-zA-Z_][a-zA-Z0-9_]*/,
            seq('`', /[a-zA-Z_][a-zA-Z0-9_]*/, '`'),
        )),
        _dollar_identifier: $ => seq('$', $.identifier),

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
        byte_literal: _ => token(seq('b\'', choice(/./, '"', seq('\\u{', choice(hexDigit, seq(hexDigit, hexDigit)), '}'), /\\./), '\'')),
        escape_sequence: _ => token(/\\./),  // Permissive: any escape sequence
        boolean_literal: _ => token(prec(PREC.TOKEN, choice('true', 'false'))),

        string_literal: $ => choice($._line_string_literal, $._multi_line_string_literal, $._multi_line_raw_string_literal, $._line_string_unterminated_single, $._line_string_unterminated_double),

        _line_string_literal: $ => choice(lineStr($, '\'', /[^'\\\r\n$]+/), lineStr($, '"', /[^"\\\r\n$]+/)),
        // Unterminated line string: the external tail token fires only when
        // no closing quote exists before the newline, so it never competes
        // with the closed path (both share the opener token). The tail is
        // optional so even a bare quote at end of line becomes a zero-cost
        // unterminated string — instead of a MISSING-closer insertion, which
        // cascades into one ERROR blob when several unclosed strings occur
        // in the same block. prec(-2) keeps every closed/multi-line string
        // winning any tie against the bare-opener form.
        _line_string_unterminated_single: $ => prec(-2, seq('\'', optional($._line_string_tail_single))),
        _line_string_unterminated_double: $ => prec(-2, seq('"', optional($._line_string_tail_double))),

        // ${} holes accept declarations too: "${let PI = 3.14; PI*r*r}"
        inline_expression: $ => seq('${', seq($._interpolation_statement, repeat(seq(repeat1(';'), $._interpolation_statement))), '}'),

        _multi_line_string_literal: $ => choice(multiLineStr($, '"""'), multiLineStr($, "'''")),

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
        _interpolation_statement: $ => choice($.variable_declaration, $._expression),

        _multi_line_raw_string_literal: $ => seq($._multi_line_raw_string_start, optional($._multi_line_raw_string_content), $._multi_line_raw_string_end),
        unit_literal: _ => seq('(', ')'),
    },
};

module.exports = grammar(M);
