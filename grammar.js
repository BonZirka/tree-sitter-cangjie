// Cangjie grammar for tree-sitter. Author BonZer0, MIT license.

const newline = /\r?\n/;

const terminator = ($) => choice($._terminator, ';');

// LET_COND (13) sits between && (12) and | (14): binding-reduce beats && / ||, loses to tighter operators.
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
};

// Keyword-like words, classified by probing cjc in all identifier positions;
// `kind` ∈ {hard, primitive, literal, contextual, modifier}.
const KEYWORDS = [
  { w: 'as', kind: 'hard' },
  { w: 'break', kind: 'hard' },
  { w: 'case', kind: 'hard' },
  { w: 'catch', kind: 'hard' },
  { w: 'class', kind: 'hard' },
  { w: 'const', kind: 'hard' },
  { w: 'continue', kind: 'hard' },
  { w: 'do', kind: 'hard' },
  { w: 'else', kind: 'hard' },
  { w: 'enum', kind: 'hard' },
  { w: 'extend', kind: 'hard' },
  { w: 'finally', kind: 'hard' },
  { w: 'for', kind: 'hard' },
  { w: 'foreign', kind: 'hard' },
  { w: 'func', kind: 'hard' },
  { w: 'if', kind: 'hard' },
  { w: 'import', kind: 'hard' },
  { w: 'in', kind: 'hard' },
  { w: 'init', kind: 'hard' },
  { w: 'inout', kind: 'hard' },
  { w: 'interface', kind: 'hard' },
  { w: 'is', kind: 'hard' },
  { w: 'let', kind: 'hard' },
  { w: 'macro', kind: 'hard' },
  { w: 'match', kind: 'hard' },
  { w: 'mut', kind: 'hard' },
  { w: 'operator', kind: 'hard' },
  { w: 'package', kind: 'hard' },
  { w: 'prop', kind: 'hard' },
  { w: 'quote', kind: 'hard' },
  { w: 'return', kind: 'hard' },
  { w: 'spawn', kind: 'hard' },
  { w: 'static', kind: 'hard' },
  { w: 'struct', kind: 'hard' },
  { w: 'super', kind: 'hard' },
  { w: 'synchronized', kind: 'hard' },
  { w: 'this', kind: 'hard' },
  { w: 'throw', kind: 'hard' },
  { w: 'try', kind: 'hard' },
  { w: 'type', kind: 'hard' },
  { w: 'unsafe', kind: 'hard' },
  { w: 'var', kind: 'hard' },
  { w: 'where', kind: 'hard' },
  { w: 'while', kind: 'hard' },
  { w: 'with', kind: 'hard' },
  { w: 'main', kind: 'hard' },
  { w: 'true', kind: 'literal' },
  { w: 'false', kind: 'literal' },
  { w: 'This', kind: 'hard', token: 'THISTYPE' },
  { w: 'Int8', kind: 'primitive', node: 'Int8' },
  { w: 'Int16', kind: 'primitive', node: 'Int16' },
  { w: 'Int32', kind: 'primitive', node: 'Int32' },
  { w: 'Int64', kind: 'primitive', node: 'Int64' },
  { w: 'IntNative', kind: 'primitive', node: 'IntNative' },
  { w: 'UInt8', kind: 'primitive', node: 'UInt8' },
  { w: 'UInt16', kind: 'primitive', node: 'UInt16' },
  { w: 'UInt32', kind: 'primitive', node: 'UInt32' },
  { w: 'UInt64', kind: 'primitive', node: 'UInt64' },
  { w: 'UIntNative', kind: 'primitive', node: 'UIntNative' },
  { w: 'Float16', kind: 'primitive', node: 'Float16' },
  { w: 'Float32', kind: 'primitive', node: 'Float32' },
  { w: 'Float64', kind: 'primitive', node: 'Float64' },
  { w: 'Rune', kind: 'primitive', node: 'Rune' },
  { w: 'Bool', kind: 'primitive', node: 'Bool' },
  { w: 'Unit', kind: 'primitive', node: 'Unit' },
  { w: 'Nothing', kind: 'primitive', node: 'Nothing' },
  { w: 'features', kind: 'contextual' },
  { w: 'handle', kind: 'contextual' },
  { w: 'perform', kind: 'contextual' },
  { w: 'resume', kind: 'contextual' },
  { w: 'throwing', kind: 'contextual' },
  { w: 'get', kind: 'contextual' },
  { w: 'set', kind: 'contextual' },
  { w: 'public', kind: 'modifier' },
  { w: 'protected', kind: 'modifier' },
  { w: 'private', kind: 'modifier' },
  { w: 'internal', kind: 'modifier' },
  { w: 'abstract', kind: 'modifier' },
  { w: 'sealed', kind: 'modifier' },
  { w: 'redef', kind: 'modifier' },
  { w: 'open', kind: 'modifier' },
  { w: 'override', kind: 'modifier' },
  { w: 'common', kind: 'modifier' },
  { w: 'specific', kind: 'modifier' },
];

const tokenKey = (k) => k.token ?? k.w.toUpperCase();
const words = (...kinds) => KEYWORDS.filter((k) => kinds.includes(k.kind)).map((k) => k.w);

const TOKENS = Object.fromEntries(
  KEYWORDS.filter((k) => k.kind !== 'literal').map((k) => [tokenKey(k), token(k.w)]),
);
TOKENS.NOT_IN = token('!in');

const SOFT_MODIFIER_WORDS = words('modifier');
const MODIFIER_TOKENS = KEYWORDS.filter((k) => k.kind === 'modifier').map((k) => TOKENS[tokenKey(k)]);

// A modifier run: contextual modifier words plus always-legal extras. The
// local-variable alias omits `const` so `const x` binds through the tail.
const modifierChoice = (...extra) => choice(...extra, ...MODIFIER_TOKENS.map((t) => reserved('modifier', t)));

const PRIMITIVE_TYPES = KEYWORDS.filter((k) => k.kind === 'primitive').map((k) => [tokenKey(k), k.node]);

const primitiveTypeNodes = ($) => PRIMITIVE_TYPES.map(([token, node]) => alias(TOKENS[token], $[node]));

// The identifier alternative at a named position: ASCII + unicode + raw
// (backticked) tokens under one node name; cjc accepts all three everywhere
// and unicode/raw are never keyword-captured, exactly cjc's semantics.
const ident = ($, node) =>
  choice(
    alias(reserved('default', $.identifier), $[node]),
    alias($.unicode_identifier, $[node]),
    alias($.raw_identifier, $[node]),
  );

// Reserved in every identifier position (probed against cjc): hard words,
// primitives and literals; main's one exception is the function-name position.
const GLOBAL_RESERVED = words('hard', 'primitive', 'literal');
const NO_RESERVED = [];

const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));
const commaSep1Trailing = (rule) => seq(sep1(rule, ','), optional(','));

const hexDigit = /[0-9a-fA-F]/;
const hexDigits = seq(hexDigit, repeat(choice('_', hexDigit)));
const decimalDigits = seq(/[0-9]/, repeat(choice('_', /[0-9]/)));
const decimalLiteral = choice(/[0-9]/, seq(/[1-9]/, repeat1(choice('_', /[0-9]/))));

const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');

const bop = ($, p, ops, right, operand) =>
  (right ? prec.right : prec.left)(
    p,
    seq(
      field('left', operand ?? $._expression),
      field('operator', choice(...ops.map((o) => (typeof o === 'string' ? token(o) : o)))),
      field('right', operand ?? $._expression),
    ),
  );

const typeTail = ($) => seq(optional(seq(token('<:'), $._super_interfaces)), optional($.generic_constraints));
const typeHeader = ($, keyword, nameField) =>
  seq(optional($.modifiers), keyword, field('name', nameField), optional($.type_parameters), typeTail($));

const M = {
  name: 'cangjie',

  extras: ($) => [/\s/, $.line_comment, $.block_comment],

  word: ($) => $.identifier,

  reserved: {
    default: ($) => GLOBAL_RESERVED,
    none: ($) => NO_RESERVED,
    modifier: ($) => SOFT_MODIFIER_WORDS,
  },

  externals: ($) => [
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
    $._quote_macro_head,
    $._quote_newline,
    $._perform_dsl,
    $._resume_dsl,
  ],

  supertypes: ($) => [$._literal, $._expression, $._type],

  inline: ($) => [$._logical_operand_right],

  conflicts: ($) => [
    [$._call_tail],
    [$.modifiers, $._modifiers_var],
    [$.modifiers, $._variable_declaration_tail],
  ],

  rules: {
    source_file: ($) =>
      seq(
        optional($.features_directive),
        optional(choice($.package_declaration, $.macro_package_declaration)),
        repeat($.import_list),
        repeat(
          seq(
            optional(token(';')),
            choice(
              choice(
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
                $.decorated_declaration,
                $.macro_expression,
              ),
              $.main_definition,
            ),
          ),
        ),
        optional(token(';')),
      ),

    package_declaration: ($) =>
      seq(optional($.modifiers), TOKENS.PACKAGE, field('package_name', $._name), terminator($)),
    macro_package_declaration: ($) =>
      seq(optional($.modifiers), TOKENS.MACRO, TOKENS.PACKAGE, field('package_name', $._name), terminator($)),

    _import_packages: ($) =>
      choice(
        prec.right(-3, field('package_name', $._name)),
        prec.right(-2, $.package_full),
        prec.right(-1, $.package_alias),
      ),
    import_list: ($) =>
      seq(
        repeat($.macro_call),
        optional($.modifiers),
        TOKENS.IMPORT,
        choice($._import_packages, $.package_group, $.sub_group_of_package),
        terminator($),
      ),
    package_alias: ($) => seq(field('package_name', $._name), TOKENS.AS, field('alias', ident($, 'identifier'))),
    package_full: ($) => seq(field('package_name', choice($._name, $.package_identifier)), '.', token('*')),
    package_group: ($) => seq('{', seq($._import_packages, repeat(seq(',', $._import_packages))), optional(','), '}'),
    sub_group_of_package: ($) => seq(field('package_name', choice($._name, $.package_identifier)), '.', $.package_group),

    features_directive: ($) =>
      prec.right(seq(repeat($.macro_call), TOKENS.FEATURES, $.features_set, repeat1(terminator($)))),

    features_set: ($) => seq('{', commaSep1Trailing($.feature_id), '}'),

    feature_id: ($) => sep1(reserved('none', $.identifier), '.'),

    // cjc accepts `unsafe main() {}` — modifier validity is the semantic pass's job.
    main_definition: ($) =>
      seq(optional($.modifiers), TOKENS.MAIN, $.parameter_list, optional($.return_type), $.block),
    modifiers: ($) => prec.left(repeat1(modifierChoice(TOKENS.STATIC, TOKENS.CONST, TOKENS.MUT, TOKENS.UNSAFE))),
    _modifiers_var: ($) =>
      alias(prec.left(repeat1(modifierChoice(TOKENS.STATIC, TOKENS.MUT, TOKENS.UNSAFE))), $.modifiers),
    decorated_declaration: ($) =>
      prec.dynamic(
        1,
        prec.right(
          seq(
            repeat1($.macro_call),
            choice(
              $.class_definition,
              $.function_definition,
              $.struct_definition,
              $.interface_definition,
              $.enum_definition,
              $.type_alias,
              $.extend_definition,
              $.foreign_declaration,
              $.variable_declaration,
              $.operator_function_definition,
              $.property_definition,
              $.init,
              $.finalizer,
              $.primary_init,
            ),
          ),
        ),
      ),

    macro_definition: ($) =>
      seq(
        optional($.modifiers),
        TOKENS.MACRO,
        field('name', $._macro_name),
        field('parameters', seq('(', optional(commaSep1Trailing($.macro_parameter)), ')')),
        optional(field('return_type', $.return_type)),
        choice(seq('=', field('body', $._expression)), field('body', $.block)),
      ),

    macro_parameter: ($) =>
      seq(
        field('name', ident($, 'identifier')),
        optional('!'),
        ':',
        field('type', $._type),
        optional(seq('=', field('default_value', $._expression))),
      ),
    _macro_name: ($) =>
      // One macro_name node; ident()'s inner aliases cannot nest here (the generator drops the outer alias).
      alias(
        prec.right(
          seq(
            repeat(seq(reserved('default', $.identifier), '.')),
            choice(reserved('default', $.identifier), $.unicode_identifier, $.raw_identifier),
          ),
        ),
        $.macro_name,
      ),

    class_definition: ($) => seq(typeHeader($, TOKENS.CLASS, $._class_name), field('body', $.declaration_body)),
    struct_definition: ($) => seq(typeHeader($, TOKENS.STRUCT, ident($, 'struct_name')), field('body', $.declaration_body)),

    interface_definition: ($) =>
      seq(typeHeader($, TOKENS.INTERFACE, ident($, 'interface_name')), field('body', $.declaration_body)),
    enum_definition: ($) => seq(typeHeader($, TOKENS.ENUM, ident($, 'enum_name')), field('body', $.enum_body)),
    enum_body: ($) =>
      seq(
        '{',
        optional('|'),
        sep1(
          field(
            'enum_constant',
            choice(
              seq(
                repeat($.macro_call),
                ident($, 'identifier'),
                optional(seq('(', commaSep1Trailing($._type), ')')),
              ),
              token('...'),
            ),
          ),
          '|',
        ),
        optional($._declaration_list),
        '}',
      ),

    extend_definition: ($) =>
      seq(optional($.modifiers), TOKENS.EXTEND, $.extend_type, typeTail($), field('body', $.declaration_body)),

    type_alias: ($) =>
      seq(
        optional($.modifiers),
        TOKENS.TYPE,
        field('name', ident($, 'type_alias_name')),
        optional($.type_parameters),
        '=',
        field('type', $._type),
      ),

    foreign_declaration: ($) =>
      seq(
        TOKENS.FOREIGN,
        choice(
          field('body', $.declaration_body),
          choice($.class_definition, $.interface_definition, $.function_definition, $.variable_declaration),
        ),
      ),

    _declaration_list: ($) =>
      repeat1(
        seq(
          repeat(token(';')),
          choice(
            $.variable_declaration,
            $.function_definition,
            $.operator_function_definition,
            $.property_definition,
            $.init,
            $.primary_init,
            $.finalizer,
            $.decorated_declaration,
            $.macro_expression,
          ),
        ),
      ),

    declaration_body: ($) => seq('{', optional($._declaration_list), '}'),
    _class_name: ($) => ident($, 'class_name'),
    generic_constraints: ($) =>
      prec.right(
        seq(
          TOKENS.WHERE,
          $.generic_constraint,
          repeat(seq(',', repeat(terminator($)), $.generic_constraint)),
          optional(','),
        ),
      ),
    generic_constraint: ($) =>
      seq(
        choice(ident($, 'identifier'), alias(TOKENS.THISTYPE, $.Thistype)),
        token('<:'),
        sep1($._type, '&'),
      ),
    function_definition: ($) => seq(optional($.modifiers), $._function_tail),
    // Block-scope functions carry no modifiers (cjc) — see the statement-start invariant.
    _local_function_definition: ($) => $._function_tail,
    _function_tail: ($) =>
      choice(
        // The with-body version outranks the body-less one: at an unclosed
        // trailing '{' (EOF while typing) both versions cost one error, and
        // the dynamic precedence makes MISSING '}' win over flagging the '{'.
        prec.dynamic(
          1,
          prec.right(
            seq(
              TOKENS.FUNC,
              // main is hard, but cjc accepts it as a function name — its only identifier position.
              field('name', alias(choice(reserved('default', $.identifier), $.unicode_identifier, $.raw_identifier, TOKENS.MAIN), $.func_name)),
              optional($.type_parameters),
              field('parameters', $.parameter_list),
              optional(field('return_type', $.return_type)),
              optional($.generic_constraints),
              field('body', $.block),
            ),
          ),
        ),
        prec.right(
          seq(
            TOKENS.FUNC,
            field('name', alias(choice(reserved('default', $.identifier), $.unicode_identifier, $.raw_identifier, TOKENS.MAIN), $.func_name)),
            optional($.type_parameters),
            field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)),
            optional($.generic_constraints),
          ),
        ),
      ),
    operator_function_definition: ($) =>
      seq(
        optional($.modifiers),
        TOKENS.OPERATOR,
        optional(TOKENS.CONST),
        TOKENS.FUNC,
        field(
          'name',
          alias(
            choice(
              token(seq('[', ']')),
              token(seq('(', ')')),
              token('!'),
              token('+'),
              token('-'),
              token('**'),
              token('*'),
              token('/'),
              token('%'),
              token('<<'),
              token('>>'),
              token('<'),
              token('>'),
              token('<='),
              token('>='),
              token('=='),
              token('!='),
              token('&'),
              token('^'),
              token('|'),
            ),
            $.operator,
          ),
        ),
        optional($.type_parameters),
        field('parameters', $.parameter_list),
        optional(field('return_type', $.return_type)),
        optional($.generic_constraints),
        optional(field('body', $.block)),
      ),

    property_definition: ($) =>
      seq(
        optional($.modifiers),
        TOKENS.PROP,
        field('name', ident($, 'property_name')),
        ':',
        field('type', $._type),
        optional(
          seq(
            '{',
            optional(field('getter', seq(alias(TOKENS.GET, $.get_keyword), '(', ')', $.block))),
            optional(
                field(
                  'setter',
                  seq(alias(TOKENS.SET, $.set_keyword), '(', ident($, 'identifier'), ')', $.block),
                ),
            ),
            '}',
          ),
        ),
      ),

    init: ($) =>
      seq(
        optional($.modifiers),
        TOKENS.INIT,
        field('parameters', $.parameter_list),
        optional(field('body', $.block)),
      ),
    primary_init: ($) =>
      seq(
        optional($.modifiers),
        $._class_name,
        $.primary_init_parameter_list,
        '{',
        optional(
          // Function-body locals only: cjc rejects modifiers in primary-ctor bodies.
          repeat(
            seq(
              choice(
                $._expression,
                alias($._local_variable_declaration, $.variable_declaration),
                alias($._local_function_definition, $.function_definition),
              ),
              optional(terminator($)),
            ),
          ),
        ),
        '}',
      ),
    primary_init_parameter_list: ($) =>
      seq(
        '(',
        optional(
          commaSep1Trailing(choice($.parameter, $.named_parameter, $.unnamed_member_parameter, $.named_member_parameter)),
        ),
        ')',
      ),
    named_member_parameter: ($) =>
      seq(repeat($.macro_call), optional($.modifiers), choice(TOKENS.LET, TOKENS.VAR), $.named_parameter),

    finalizer: ($) => seq('~', TOKENS.INIT, '(', ')', $.block),

    return_type: ($) => seq(':', field('type', $._type)),

    _super_interfaces: ($) =>
      prec.left(
        seq(
          optional(seq($._super_interfaces, '&')),
          seq(alias($._name, $.super_or_interface), optional($.type_arguments)),
        ),
      ),
    // cjc's parser accepts a full type (tuple/arrow dies in its semantic pass): plain type + optional parameters.
    extend_type: ($) => seq(optional($.type_parameters), $._type),

    block: ($) => seq('{', optional($._expression_or_declarations), '}'),
    // INVARIANT: nothing reachable may start with a modifier token — statement
    // starts are the only place soft modifiers fall back to identifiers (unsafe { open(p, oflag) }).
    _expression_or_declarations: ($) =>
      repeat1(
        seq(
          choice(
            alias($._local_variable_declaration, $.variable_declaration),
            alias($._local_function_definition, $.function_definition),
            $._expression,
          ),
          repeat(terminator($)),
        ),
      ),

    _local_variable_declaration: ($) => $._variable_declaration_tail,
    _variable_declaration_tail: ($) =>
      seq(
        choice(TOKENS.LET, TOKENS.VAR, TOKENS.CONST),
        field('name', alias($._pattern_irrefutable, $.variable_name)),
        choice(
          seq(':', field('type', $._type), optional(seq('=', field('initializer', $._expression)))),
          seq('=', field('initializer', $._expression)),
        ),
      ),
    variable_declaration: ($) => seq(optional($._modifiers_var), $._variable_declaration_tail),
    parameter_list: ($) =>
      seq(
        '(',
        optional(
          choice(
            seq(sep1($.parameter, ','), optional(seq(',', sep1($.named_parameter, ',')))),
            sep1($.named_parameter, ','),
          ),
        ),
        optional($.ellipsis_parameter),
        optional(','),
        ')',
      ),

    parameter: ($) =>
      seq(
        repeat($.macro_call),
        choice(
          seq(
            field('parameter_name', choice(ident($, 'identifier'), token('_'))),
            ':',
            field('type', $._type),
          ),
          seq('(', $.parameter, ')'),
          seq('(', $.named_parameter, ')'),
        ),
      ),
    named_parameter: ($) =>
      seq(
        repeat($.macro_call),
        seq(field('parameter_name', ident($, 'identifier')), '!'),
        ':',
        field('type', $._type),
        optional(seq('=', field('default_value', $._expression))),
      ),
    unnamed_member_parameter: ($) =>
      seq(
        repeat($.macro_call),
        optional($.modifiers),
        choice(TOKENS.LET, TOKENS.VAR),
        field('parameter_name', choice(ident($, 'identifier'), token('_'))),
        ':',
        field('type', $._type),
        optional(seq('=', field('default_value', $._expression))),
      ),

    ellipsis_parameter: ($) => seq(optional(','), '...'),
    call_suffix: ($) =>
      seq(
        '(',
        optional(
          commaSep1Trailing(
            choice(
              seq(ident($, 'identifier'), ':', $._expression),
              $._expression,
              seq(TOKENS.INOUT, optional(seq($._expression, '.')), ident($, 'identifier')),
            ),
          ),
        ),
        $._call_tail,
      ),
    // The "whose lambda?" fork, isolated so the conflict is named after it.
    _call_tail: ($) => seq(')', optional($.lambda_expression)),
    _primary_expression: ($) =>
      choice(
        $._literal,
        $.array_literal,
        ident($, 'identifier'),
        $.type_conversion_expression,
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
        seq(token('$('), $._expression, ')'),
      ),

    _expression: ($) =>
      choice(
        $.postfix_expression,
        $.unary_expression,
        $.binary_expression,
        $.is_expression,
        $.as_expression,
        $.assignment_expression,
      ),

    assignment_expression: ($) =>
      prec.right(
        PREC.ASSIGN,
        seq(
          field(
            'variable',
            prec(
              1,
              choice($.postfix_expression, $.unary_expression, $.binary_expression, $.is_expression, $.as_expression),
            ),
          ),
          field(
            'operator',
            choice(
              token('='),
              token('+='),
              token('-='),
              token('*='),
              token('/='),
              token('%='),
              token('**='),
              token('&='),
              token('|='),
              token('^='),
              token('<<='),
              token('>>='),
              token('&&='),
              token('||='),
            ),
          ),
          field('value', $._expression),
        ),
      ),

    binary_expression: ($) =>
      prec.dynamic(
        -1,
        choice(
          prec.left(
            PREC.OR,
            seq(field('left', $._expression), field('operator', token('||')), field('right', $._logical_operand_right)),
          ),
          prec.left(
            PREC.AND,
            seq(field('left', $._expression), field('operator', token('&&')), field('right', $._logical_operand_right)),
          ),
          bop($, PREC.COALESCE, ['??'], 'right'),
          bop($, PREC.EQUALITY, ['==', '!=']),
          bop($, PREC.REL, ['>', '<', '>=', '<=', TOKENS.IN, TOKENS.NOT_IN]),
          bop($, PREC.BIT_OR, ['|']),
          bop($, PREC.BIT_XOR, ['^']),
          bop($, PREC.BIT_AND, ['&']),
          bop($, PREC.SHIFT, ['<<', '>>']),
          bop($, PREC.ADD_SUB, ['+', '-']),
          bop($, PREC.MUL_DIV, ['*', '/', '%']),
          bop($, PREC.POWER, ['**'], 'right'),
          bop($, PREC.PIPE, ['|>', '~>']),
        ),
      ),

    unary_expression: ($) =>
      prec.left(PREC.UNARY, seq(field('operator', choice('!', '-')), field('argument', $._expression))),

    is_expression: ($) => prec.right(PREC.REL, seq(field('left', $._expression), TOKENS.IS, field('type', $._type))),
    as_expression: ($) => prec.right(PREC.REL, seq(field('left', $._expression), TOKENS.AS, field('type', $._type))),

    _logical_operand_right: ($) => choice($._expression, $.let_pattern_destructor),
    _cond_tail: ($) => seq($.let_pattern_destructor, repeat(seq(choice('&&', '||'), $._logical_operand_right))),

    parenthesized_expression: ($) => seq('(', choice($._expression, $._cond_tail), ')'),
    tuple_expression: ($) => seq('(', $._expression, repeat1(seq(',', $._expression)), optional(','), ')'),
    array_literal: ($) => seq('[', optional(commaSep1Trailing(choice($._expression, seq('*', $._expression)))), ']'),

    range_expression: ($) =>
      prec.right(
        PREC.RANGE,
        seq(
          optional(field('start', $._expression)),
          choice(token('..'), token('..=')),
          optional(field('end', $._expression)),
          optional(seq(':', field('step', $._expression))),
        ),
      ),

    lambda_expression: ($) =>
      seq(
        choice('{', $._brace_open),
        optional(seq(optional($.lambda_parameters), token('=>'))),
        optional($._expression_or_declarations),
        choice('}', $._brace_close),
      ),
    lambda_parameters: ($) => commaSep1Trailing($.lambda_parameter),
    lambda_parameter: ($) => seq(choice($._var_binding_pattern, '_'), optional(seq(':', $._type))),

    jump_expression: ($) =>
      choice(
        prec.right(seq(TOKENS.THROW, $._expression)),
        prec.right(seq(TOKENS.RETURN, optional($._expression))),
        TOKENS.CONTINUE,
        TOKENS.BREAK,
      ),

    this_super_expression: (_) => choice(TOKENS.THIS, TOKENS.SUPER),
    if_expression: ($) =>
      prec.left(
        seq(
          TOKENS.IF,
          field('condition', seq('(', choice($._expression, $._cond_tail), ')')),
          field('consequence', $.block),
          optional(field('alternative', seq(TOKENS.ELSE, choice($.if_expression, $.block)))),
        ),
      ),

    while_expression: ($) => seq(TOKENS.WHILE, '(', choice($._expression, $._cond_tail), ')', $.block),

    do_while_expression: ($) =>
      seq(TOKENS.DO, field('body', $.block), TOKENS.WHILE, '(', choice($._expression, $._cond_tail), ')'),

    for_in_expression: ($) =>
      seq(TOKENS.FOR, '(', $._pattern_irrefutable, TOKENS.IN, $._expression, optional($.pattern_guard), ')', $.block),

    match_expression: ($) =>
      choice(
        seq(TOKENS.MATCH, '(', field('condition', $._expression), ')', '{', repeat1($.case_pattern), '}'),
        seq(TOKENS.MATCH, '{', repeat1($.case_expression), '}'),
      ),
    case_pattern: ($) =>
      seq(TOKENS.CASE, $._pattern, optional($.pattern_guard), token('=>'), $._expression_or_declarations),
    case_expression: ($) => seq(TOKENS.CASE, $._expression, token('=>'), $._expression_or_declarations),

    pattern_guard: ($) => seq(TOKENS.WHERE, $._expression),

    try_expression: ($) =>
      prec.right(
        seq(
          TOKENS.TRY,
          optional(seq('(', field('resources', $.resource_specifications), ')')),
          field('try_body', $.block),
          repeat(choice($.catch_clause, $.handle_clause)),
          optional(seq(TOKENS.FINALLY, field('finally_body', $.block))),
        ),
      ),

    resource_specifications: ($) => commaSep1Trailing($.resource_specification),
    resource_specification: ($) => seq(ident($, 'identifier'), optional(seq(':', $._type)), '=', $._expression),

    // Parens required (cjc rejects `catch e {}`); the optional pattern localizes errors.
    catch_clause: ($) => seq(TOKENS.CATCH, '(', optional($.catch_pattern), ')', field('catch_body', $.block)),

    handle_clause: ($) =>
      seq(TOKENS.HANDLE, '(', field('command_pattern', $.command_type_pattern), ')', field('handle_body', $.block)),

    command_type_pattern: ($) =>
      seq(
        // cjc: strictly `pattern ':' Type` — `handle (e)` / `handle (Eff)` are rejected.
        choice($.wildcard_pattern, $._var_binding_pattern),
        ':',
        field('type', $._type),
        optional($.tuple_pattern),
      ),

    synchronized_expression: ($) => seq(TOKENS.SYNCHRONIZED, '(', $._expression, ')', $.block),
    spawn_expression: ($) => seq(TOKENS.SPAWN, optional(seq('(', $._expression, ')')), $.lambda_expression),

    // Hard-keyword primitives: never callees (reserved words), so T(...) is a conversion; soft builtins (String) are plain calls.
    _hard_keyword_types: ($) => choice(...primitiveTypeNodes($)),

    // Exactly T(expr): '(' kept out of _member_suffix so conversion and call never overlap.
    type_conversion_expression: ($) => seq(field('type', $._hard_keyword_types), '(', field('argument', $._expression), ')'),

    perform_expression: ($) =>
      seq(alias($._perform_dsl, $.perform_keyword), field('argument', $._expression)),

    resume_expression: ($) =>
      seq(
        alias($._resume_dsl, $.resume_keyword),
        choice(
          seq(TOKENS.WITH, field('with_argument', $._expression)),
          seq(TOKENS.THROWING, field('throwing_argument', $._expression)),
        ),
      ),
    unsafe_expression: ($) => seq(TOKENS.UNSAFE, $.block),

    // prec(LET_COND): the reduce beats && / || shifts — `(let p <- a) && b`.
    let_pattern_destructor: ($) => prec(PREC.LET_COND, seq(TOKENS.LET, $._pattern, token('<-'), $._expression)),

    _dollar_identifier: ($) => seq('$', reserved('none', $.identifier)),

    _macro_head: ($) =>
      seq(
        alias($._macro_at, $.macro_call_sigil),
        optional('!'),
        $._macro_name,
        optional(alias($._macro_attr_body, $.macro_attribute_body)),
      ),

    // Macro parameters are raw token streams (spec); prec.dynamic beats decorators.
    macro_expression: ($) =>
      prec.dynamic(-1, seq($._macro_head, optional(alias($._macro_input_body, $.macro_call_body)))),

    quote_expression: ($) =>
      prec(
        PREC.MACRO_QUOTE,
        seq(
          // The scanner is the primary path; the bare QUOTE alternative must
          // stay: every reserved word needs a token, and a captured bare
          // `quote` without '(' then fails on the missing body, like cjc.
          choice(alias($._quote_open, $.quote_keyword), TOKENS.QUOTE),
          // Newlines after 'quote(' are ignored (spec); each is a quoteToken separator.
          repeat($._quote_newline),
          repeat(seq($._quote_body_item, repeat(alias($._quote_newline, $.quote_newline)))),
          alias($._quote_close, $.quote_close),
        ),
      ),

    _quote_body_item: ($) =>
      choice(
        alias($._quote_content, $.quote_raw_token),
        alias($._quote_macro_head, $.quote_macro_head),
        $.escape_sequence,
        $.string_literal,
        $.rune_literal,
        alias($._quote_paren_open, $.quote_paren),
        alias($._quote_paren_close, $.quote_paren),
        $.quote_interpolation,
        $._dollar_identifier,
      ),

    quote_interpolation: ($) =>
      seq(
        alias($._quote_interp_open, $.quote_interp_open),
        $._expression,
        alias($._quote_interp_close, $.quote_interp_close),
      ),

    line_comment: (_) => token(prec(PREC.COMMENT, seq('//', /[^\r\n\u2028\u2029]*/))),

    // REFUTABLE patterns for match + let-destructure; IRREFUTABLE for let/foreach.
    _pattern: ($) => choice($.or_pattern, $._pattern_single),

    _pattern_single: ($) =>
      choice(
        $.wildcard_pattern,
        $._var_binding_pattern,
        $.tuple_pattern,
        $.enum_pattern,
        $._constant_pattern,
        $.type_pattern,
      ),

    wildcard_pattern: (_) => token('_'),
    or_pattern: ($) => seq($._pattern_single, repeat1(seq('|', $._pattern_single))),

    _pattern_irrefutable: ($) =>
      choice($.wildcard_pattern, $._var_binding_pattern, alias($._tuple_pattern_irrefutable, $.tuple_pattern)),

    _tuple_pattern_irrefutable: ($) => seq('(', commaSep1Trailing($._pattern_irrefutable), ')'),
    _var_binding_pattern: ($) => ident($, 'var_binding_pattern'),
    tuple_pattern: ($) => seq('(', commaSep1Trailing($._pattern), ')'),

    enum_pattern: ($) =>
      choice(
        seq(
          seq($._name, optional($.type_arguments), '.'),
          field('constructor', ident($, 'enum_constructor')),
          optional(field('arguments', $.enum_pattern_arguments)),
        ),
        seq(
          field('constructor', ident($, 'enum_constructor')),
          field('arguments', $.enum_pattern_arguments),
        ),
      ),
    enum_pattern_arguments: ($) => seq('(', commaSep1Trailing($._pattern), ')'),

    _constant_pattern: ($) => alias(choice($._literal, seq('-', $._literal)), $.constant_pattern),

    type_pattern: ($) => seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', $._type),

    catch_pattern: ($) =>
      choice($.wildcard_pattern, seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', sep1($._type, '|'))),
    _type: ($) =>
      choice(
        $.arrow_type,
        $.tuple_type,
        $.prefix_type,
        ...primitiveTypeNodes($),
        alias(TOKENS.THISTYPE, $.Thistype),
        $.type_name,
        $.const_generic,
      ),

    type_name: ($) => prec.right(seq($._name, optional($.type_arguments))),

    arrow_type: ($) => seq('(', optional($._named_or_type_list), ')', token('->'), field('type', $._type)),

    tuple_type: ($) => seq('(', optional(field('type', $._named_or_type_list)), ')'),

    prefix_type: ($) => seq('?', field('type', $._type)),

    const_generic: ($) => seq(token('$'), $.integer_literal),

    // Type world: '<' is an unambiguous internal token.
    type_arguments: ($) => seq('<', $._type_list, '>'),
    // Expression world: _generic_lt is a ZERO-WIDTH decision token (scanner.c); both worlds surface type_arguments.
    _generic_arguments: ($) => seq($._generic_lt, '<', $._type_list, '>'),

    _type_list: ($) => commaSep1Trailing($._type),

    _named_or_type_list: ($) => commaSep1Trailing(choice(seq(ident($, 'identifier'), ':', $._type), $._type)),

    type_parameters: ($) => seq('<', commaSep1Trailing($.type_parameter), '>'),

    type_parameter: ($) => seq(field('name', ident($, 'identifier'))),
    _name: ($) => choice(ident($, 'identifier'), $.scoped_identifier),
    scoped_identifier: ($) =>
      prec.left(
        seq(
          field('scope', choice($._name, $.package_identifier)),
          choice('.', '::'),
          field('name', ident($, 'identifier')),
        ),
      ),
    field_access: ($) => seq('.', ident($, 'identifier')),
    scope_resolution: ($) => seq('::', ident($, 'identifier')),
    index_access: ($) =>
      seq(
        '[',
        choice(
          $._expression,
          seq(optional($._expression), choice('..', '..='), optional($._expression)),
        ),
        ']',
      ),
    quest_access: ($) => seq('?', choice($.field_access, $.index_access, $.call_suffix, $.lambda_expression)),
    inc_or_dec: (_) => token(choice('++', '--')),

    // Member-ish suffixes; '(' absent on purpose — T(args) is a conversion, never a call on a type base.
    _member_suffix: ($) =>
      choice(
        prec(PREC.MEMBER, $.field_access),
        prec(PREC.MEMBER, $.scope_resolution),
        alias($._generic_arguments, $.type_arguments),
      ),

    postfix_expression: ($) =>
      choice(
        $._primary_expression,
        // A primitive name is an expression only as a member-chain base; bare Int64 is not a value.
        prec.right(
          PREC.MEMBER,
          seq(field('base', $._hard_keyword_types), field('suffix', $._member_suffix)),
        ),
        prec.right(
          PREC.MEMBER,
          seq(
            field('base', $.postfix_expression),
            field(
              'suffix',
              choice(
                prec(PREC.MEMBER, $.field_access),
                prec(PREC.MEMBER, $.scope_resolution),
                prec(PREC.ARRAY, $.index_access),
                prec(PREC.POSTFIX, $.quest_access),
                prec(PREC.PARENS, $.call_suffix),
                prec(PREC.POSTFIX, $.inc_or_dec),
                alias($._generic_arguments, $.type_arguments),
                $.lambda_expression,
              ),
            ),
          ),
        ),
      ),
    _literal: ($) =>
      choice(
        $.integer_literal,
        $.float_literal,
        $.rune_literal,
        $.byte_literal,
        $.boolean_literal,
        $.string_literal,
        $.unit_literal,
      ),

    integer_literal: (_) =>
      token(
        seq(
          choice(
            seq('0', choice('x', 'X'), hexDigits),
            seq('0', choice('o', 'O'), seq(/[0-7]/, repeat(choice('_', /[0-7]/)))),
            seq('0', choice('b', 'B'), seq(/[01]/, repeat(choice('_', /[01]/)))),
            decimalLiteral,
          ),
          optional(/_?[iu](8|16|32|64)/),
        ),
      ),
    float_literal: (_) =>
      token(
        choice(
          seq(
            choice(
              seq(decimalLiteral, seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits)),
              seq(
                decimalLiteral,
                '.',
                decimalDigits,
                optional(seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits)),
              ),
              seq('.', decimalDigits, optional(seq(choice('e', 'E'), optional(choice('+', '-')), decimalDigits))),
            ),
            optional(/_?[fF](16|32|64)/),
          ),
          seq(
            '0',
            choice('x', 'X'),
            choice(hexDigits, seq(hexDigits, '.', hexDigits), seq('.', hexDigits)),
            seq(choice('p', 'P'), optional(choice('+', '-')), decimalDigits),
          ),
        ),
      ),
    rune_literal: (_) =>
      token(
        choice(
          seq("r'", choice(/[^'\\]/, uniCharacterLiteral, /\\./), "'"),
          seq('r"', choice(/[^"\\]/, uniCharacterLiteral, /\\./), '"'),
        ),
      ),
    byte_literal: (_) =>
      token(
        seq(
          "b'",
          choice(
            /[^\\'\n]/, // a single printable character
            seq('\\x', hexDigit, hexDigit), // the \\xNN byte escape
            /\\./, // permissive fallback
          ),
          "'",
        ),
      ),
    escape_sequence: (_) =>
      token(
        choice(
          /\\u\{[0-9a-fA-F]{1,8}\}/, // the canonical unicode form
          /\\./, // permissive: any other escape
        ),
      ),
    boolean_literal: (_) => choice(token('true'), token('false')),

    // Delimiters aliased so queries can color them (anonymous externals are not queryable).
    string_literal: ($) =>
      choice(
        prec.right(
          seq(
            alias($._line_string_start, $.string_start),
            repeat(choice(alias($._line_string_content, $.string_content), $.escape_sequence, $.string_interpolation)),
            optional(alias($._line_string_end, $.string_end)),
          ),
        ),
        prec.right(
          seq(
            alias($._multiline_string_start, $.string_start),
            optional(seq(optional(/\r/), /\n/)),
            repeat(
              choice(alias($._multiline_string_content, $.string_content), $.escape_sequence, $.string_interpolation),
            ),
            optional(alias($._multiline_string_end, $.string_end)),
          ),
        ),
        seq(
          alias($._raw_string_start, $.string_start),
          optional(alias($._raw_string_content, $.string_content)),
          optional(alias($._raw_string_end, $.string_end)),
        ),
      ),

    string_interpolation: ($) =>
      seq(
        alias($._interp_open, $.interp_open),
        repeat(seq(repeat(terminator($)), $._interpolation_statement)),
        alias($._interp_close, $.interp_close),
      ),

    _interpolation_statement: ($) =>
      choice(alias($._local_variable_declaration, $.variable_declaration), $._expression),

    unit_literal: (_) => seq('(', ')'),

    macro_call: ($) => prec(1, $._macro_head),

    _macro_attr_body: ($) =>
      prec.right(
        seq(
          alias($._macro_attr_open, $.macro_attr_open),
          repeat($._macro_body_item),
          optional(alias($._macro_attr_close, $.macro_attr_close)),
        ),
      ),

    _macro_input_body: ($) =>
      prec.right(
        seq(
          alias($._macro_input_open, $.macro_input_open),
          repeat($._macro_body_item),
          optional(alias($._macro_input_close, $.macro_input_close)),
        ),
      ),

    _macro_body_item: ($) =>
      choice(alias($._macro_body_content, $.macro_raw_token), $.escape_sequence, $.string_literal, $.rune_literal),

    block_comment: ($) => seq('/*', $._block_comment_content),
    // cjc: identifiers are XID (NFC-normalized by cjc; tree-sitter keeps bytes),
    // keywords are ASCII-only. tree-sitter: the `word` token must compile to
    // character sets WITHOUT the u flag — \p{...} classes, unicode ranges or
    // the flag itself silently kill keyword conversion (Int64 stops being a
    // keyword). unicode_identifier/raw_identifier join via ident(); do NOT
    // alias either to the word symbol (overflows the word analysis).
    identifier: (_) => token(/[a-zA-Z_][a-zA-Z0-9_]*/),
    unicode_identifier: ($) => token(/[\p{XID_Start}_][\p{XID_Continue}_]*/u),
    raw_identifier: ($) => token(seq('`', /[\p{XID_Start}_][\p{XID_Continue}_]*/u, '`')),
    // cjc's PACKAGE_IDENTIFIER: a backticked import-path segment containing at
    // least one separator ('-', '.', space) — plain backticked names are raw
    // identifiers, keeping the tokens disjoint (no lookahead in tree-sitter).
    // Raw LAST import segments are rejected by cjc; the scoped chain enforces
    // it. Accepted divergences: '::' in type chains, raw package headers.
    package_identifier: ($) =>
      token(seq('`', /[\p{XID_Continue}.\- ]*/u, choice('.', '-', ' '), /[\p{XID_Continue}.\- ]*/u, '`')),
  },
};

module.exports = grammar(M);
