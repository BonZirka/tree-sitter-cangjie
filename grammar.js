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
};

// Single source of truth for every keyword-like word. The classification is
// validated against the cjc frontend by probing the word in identifier
// positions (`let <w>`, `class <w> {}`, param, member, field access,
// named-arg label). cjc dev builds all report version 1.0.0, so this pins no
// particular release; `kind` records the result:
//   hard       reserved in every identifier position
//   primitive  hard, and additionally a built-in type name
//   literal    hard, produced by a dedicated literal rule (true / false)
//   contextual usable as an identifier everywhere (soft keyword)
//   modifier   contextual declaration modifier
// `token` overrides the derived TOKENS key (default: upper-cased word) and
// `node` is the primitive alias node.
const KEYWORDS = [
  // hard keywords
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
  // `main` is hard as well, but cjc accepts it as a function name (`func main`,
  // nested, or a method) — the exception lives in `_function_tail`.
  { w: 'main', kind: 'hard' },
  // reserved literals / special names
  { w: 'true', kind: 'literal' },
  { w: 'false', kind: 'literal' },
  { w: 'This', kind: 'hard', token: 'THISTYPE' },
  // built-in primitive type names (hard)
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
  // contextual effect-handler words (valid identifiers everywhere)
  { w: 'features', kind: 'contextual' },
  { w: 'handle', kind: 'contextual' },
  { w: 'perform', kind: 'contextual' },
  { w: 'resume', kind: 'contextual' },
  { w: 'throwing', kind: 'contextual' },
  // contextual accessor keywords — only special inside `prop` blocks, valid
  // identifiers everywhere else
  { w: 'get', kind: 'contextual' },
  { w: 'set', kind: 'contextual' },
  // soft declaration modifiers
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

// The hard-keyword primitive types, one list for three users: the type
// world (`_type`), extend targets (`extend_type`) and expression position
// (`_hard_keyword_types`).
const PRIMITIVE_TYPES = KEYWORDS.filter((k) => k.kind === 'primitive').map((k) => [tokenKey(k), k.node]);

const primitiveTokens = () => PRIMITIVE_TYPES.map(([token]) => TOKENS[token]);
const primitiveTypeNodes = ($) => PRIMITIVE_TYPES.map(([token, node]) => alias(TOKENS[token], $[node]));

// cjc ground truth (validated by probing identifier positions): hard words,
// primitives and literals cannot be read as identifiers in ANY position;
// `main` is included here too (its one exception is the function-name
// position, see `_function_tail`); contextual words and modifiers are.
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
    // ===== top-level structure =====
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
        optional(repeat1($.macro_call)),
        optional($.modifiers),
        TOKENS.IMPORT,
        choice($._import_packages, $.package_group, $.sub_group_of_package),
        terminator($),
      ),
    package_alias: ($) => seq(field('package_name', $._name), TOKENS.AS, field('alias', reserved('default', $.identifier))),
    package_full: ($) => seq(field('package_name', $._name), '.', token('*')),
    package_group: ($) => seq('{', seq($._import_packages, repeat(seq(',', $._import_packages))), optional(','), '}'),
    sub_group_of_package: ($) => seq(field('package_name', $._name), '.', $.package_group),

    features_directive: ($) =>
      prec.right(seq(optional(repeat1($.macro_call)), TOKENS.FEATURES, $.features_set, repeat1(terminator($)))),

    features_set: ($) => seq('{', commaSep1Trailing($.feature_id), '}'),

    feature_id: ($) => sep1(reserved('none', $.identifier), '.'),

    // cjc accepts `unsafe main() {}` (type_cast_0.cj) — main takes the same
    // modifier run as any function; validity of each modifier is the
    // semantic pass's job.
    main_definition: ($) =>
      seq(optional($.modifiers), TOKENS.MAIN, $.parameter_list, optional($.return_type), $.block),

    // ===== declarations =====
    modifiers: ($) =>
      prec.left(
        repeat1(
          choice(
            ...MODIFIER_TOKENS.map((t) => reserved('modifier', t)),
            TOKENS.STATIC,
            TOKENS.CONST,
            TOKENS.MUT,
            TOKENS.UNSAFE,
          ),
        ),
      ),
    _modifiers_var: ($) =>
      alias(
        prec.left(
          repeat1(
            choice(...MODIFIER_TOKENS.map((t) => reserved('modifier', t)), TOKENS.STATIC, TOKENS.MUT, TOKENS.UNSAFE),
          ),
        ),
        $.modifiers,
      ),
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
        field('name', reserved('default', $.identifier)),
        optional('!'),
        ':',
        field('type', $._type),
        optional(seq('=', field('default_value', $._expression))),
      ),
    _macro_name: ($) =>
      alias(
        prec.right(seq(repeat(seq(reserved('default', $.identifier), '.')), reserved('default', $.identifier))),
        $.macro_name,
      ),

    class_definition: ($) => seq(typeHeader($, TOKENS.CLASS, $._class_name), field('body', $.declaration_body)),
    struct_definition: ($) =>
      seq(
        typeHeader($, TOKENS.STRUCT, choice(alias(reserved('default', $.identifier), $.struct_name), alias($.unicode_identifier, $.struct_name), alias($.raw_identifier, $.struct_name))),
        field('body', $.declaration_body),
      ),

    interface_definition: ($) =>
      seq(
        typeHeader($, TOKENS.INTERFACE, choice(alias(reserved('default', $.identifier), $.interface_name), alias($.unicode_identifier, $.interface_name), alias($.raw_identifier, $.interface_name))),
        field('body', $.declaration_body),
      ),
    enum_definition: ($) =>
      seq(typeHeader($, TOKENS.ENUM, choice(alias(reserved('default', $.identifier), $.enum_name), alias($.unicode_identifier, $.enum_name), alias($.raw_identifier, $.enum_name))), field('body', $.enum_body)),
    enum_body: ($) =>
      seq(
        '{',
        optional('|'),
        sep1(
          field(
            'enum_constant',
            choice(
              seq(
                optional(repeat1($.macro_call)),
                reserved('default', $.identifier),
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
        field('name', choice(alias(reserved('default', $.identifier), $.type_alias_name), alias($.unicode_identifier, $.type_alias_name), alias($.raw_identifier, $.type_alias_name))),
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
          optional(repeat1(token(';'))),
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
    _class_name: ($) => choice(alias(reserved('default', $.identifier), $.class_name), alias($.unicode_identifier, $.class_name), alias($.raw_identifier, $.class_name)),
    generic_constraints: ($) =>
      prec.right(
        seq(
          TOKENS.WHERE,
          $.generic_constraint,
          repeat(seq(',', optional(repeat1(terminator($))), $.generic_constraint)),
          optional(','),
        ),
      ),
    generic_constraint: ($) =>
      seq(
        choice(reserved('default', $.identifier), alias(TOKENS.THISTYPE, $.Thistype)),
        token('<:'),
        sep1($._type, '&'),
      ),

    // ===== members & functions =====
    function_definition: ($) => seq(optional($.modifiers), $._function_tail),
    // Block-scope functions carry no modifiers (cjc: "unexpected modifier
    // 'private' on function declaration in main function body"). Keeping them
    // out of the local rule also removes the modifier tokens from
    // statement-start states, so soft words like `open` lex as identifiers
    // in call position (`unsafe { open(p, oflag) }`) — see the invariant note
    // on `_expression_or_declarations` before adding anything here.
    _local_function_definition: ($) => $._function_tail,
    _function_tail: ($) =>
      prec.right(
        seq(
          TOKENS.FUNC,
          // `main` is a hard keyword, but cjc still accepts it as a function
          // name (top-level, nested, or a method) — this is its only identifier
          // position, so it is whitelisted here rather than made contextual.
          field('name', alias(choice(reserved('default', $.identifier), TOKENS.MAIN), $.func_name)),
          optional($.type_parameters),
          field('parameters', $.parameter_list),
          optional(field('return_type', $.return_type)),
          optional($.generic_constraints),
          optional(field('body', $.block)),
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
        field('name', choice(alias(reserved('default', $.identifier), $.property_name), alias($.unicode_identifier, $.property_name), alias($.raw_identifier, $.property_name))),
        ':',
        field('type', $._type),
        optional(
          seq(
            '{',
            optional(field('getter', seq(alias(TOKENS.GET, $.get_keyword), '(', ')', $.block))),
            optional(
              field(
                'setter',
                seq(
                  alias(TOKENS.SET, $.set_keyword),
                  '(',
                  reserved('default', $.identifier),
                  ')',
                  $.block,
                ),
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
          // A primary constructor body is a function body, so locals only:
          // cjc rejects modifiers on declarations inside it, same as any block.
          repeat(
            seq(
              choice($._expression, $.variable_declaration, alias($._local_function_definition, $.function_definition)),
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
    // A member parameter may carry annotations before its modifiers
    // (`@M[x] public let a!: T`), as a plain parameter does.
    named_member_parameter: ($) =>
      seq(optional(repeat1($.macro_call)), optional($.modifiers), choice(TOKENS.LET, TOKENS.VAR), $.named_parameter),

    finalizer: ($) => seq('~', TOKENS.INIT, '(', ')', $.block),

    return_type: ($) => seq(':', field('type', $._type)),

    _super_interfaces: ($) =>
      prec.left(
        seq(
          optional(seq($._super_interfaces, '&')),
          seq(alias($._name, $.super_or_interface), optional($.type_arguments)),
        ),
      ),
    extend_type: ($) =>
      choice(
        seq(optional($.type_parameters), $._name, optional($.type_arguments)),
        ...primitiveTokens(),
      ),

    block: ($) => seq('{', optional($._expression_or_declarations), '}'),
    // INVARIANT: nothing reachable here may start with a modifier token.
    // Statement-start states are the ONLY place the soft modifier words
    // (`open`, `public`, `private`, `override`, ...) must fall back to plain
    // identifiers — `unsafe { open(p, oflag) }` depends on it. Adding a
    // modifier-prefixed declaration here (or reusing `$.modifiers` in a
    // statement position) silently re-breaks those identifiers.
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
    // ===== parameters & calls =====
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
        optional(repeat1($.macro_call)),
        choice(
          seq(
            choice(field('parameter_name', choice(reserved('default', $.identifier), '_')), alias($.unicode_identifier, $.identifier), alias($.raw_identifier, $.identifier)),
            ':',
            field('type', $._type),
          ),
          seq('(', $.parameter, ')'),
          seq('(', $.named_parameter, ')'),
        ),
      ),
    named_parameter: ($) =>
      seq(
        optional(repeat1($.macro_call)),
        seq(field('parameter_name', reserved('default', $.identifier)), '!'),
        ':',
        field('type', $._type),
        optional(seq('=', field('default_value', $._expression))),
      ),
    unnamed_member_parameter: ($) =>
      seq(
        optional(repeat1($.macro_call)),
        optional($.modifiers),
        choice(TOKENS.LET, TOKENS.VAR),
        choice(field('parameter_name', choice(reserved('default', $.identifier), '_')), alias($.unicode_identifier, $.identifier), alias($.raw_identifier, $.identifier)),
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
              seq(alias(reserved('default', $.identifier), $.identifier), ':', $._expression),
              $._expression,
              seq(TOKENS.INOUT, optional(seq($._expression, '.')), reserved('default', $.identifier)),
            ),
          ),
        ),
        $._call_tail,
      ),
    // The "whose lambda?" fork, isolated so the conflict is named after it.
    _call_tail: ($) => seq(')', optional($.lambda_expression)),
    // ===== statements & expressions =====
    _primary_expression: ($) =>
      choice(
        $._literal,
        $.array_literal,
        choice(
          alias(reserved('default', $.identifier), $.identifier),
          alias($.unicode_identifier, $.identifier),
          alias($.raw_identifier, $.identifier),
        ),
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
    resource_specification: ($) => seq(reserved('default', $.identifier), optional(seq(':', $._type)), '=', $._expression),

    catch_clause: ($) =>
      seq(
        TOKENS.CATCH,
        choice(seq('(', optional($.catch_pattern), ')'), $.catch_pattern),
        field('catch_body', $.block),
      ),

    handle_clause: ($) =>
      seq(TOKENS.HANDLE, '(', field('command_pattern', $.command_type_pattern), ')', field('handle_body', $.block)),

    command_type_pattern: ($) =>
      seq(
        // cjc: the effect pattern is strictly `pattern ':' Type` — both
        // `handle (e)` and `handle (Eff)` are rejected ("expected ':' in
        // effect type pattern").
        choice($.wildcard_pattern, $._var_binding_pattern),
        ':',
        field('type', $._type),
        optional($.tuple_pattern),
      ),

    synchronized_expression: ($) => seq(TOKENS.SYNCHRONIZED, '(', $._expression, ')', $.block),
    spawn_expression: ($) => seq(TOKENS.SPAWN, optional(seq('(', $._expression, ')')), $.lambda_expression),

    // The hard-keyword primitives in expression position. They can never be
    // callees (they are reserved words), so `T(...)` is a conversion and
    // `T.m` / `T::m` / `T<Ts>(...)` member chains — see type_conversion_expression and the
    // type-name base in postfix_expression. Soft builtin type names (`String`,
    // `VArray`, ...) are deliberately NOT here: they are ordinary identifiers,
    // so `String(x)` is an ordinary call on a name, exactly as in cjc.
    _hard_keyword_types: ($) => choice(...primitiveTypeNodes($)),

    // A type conversion is exactly `T ( expression )` — one operand, no
    // argument list, no trailing lambda. Deliberately spelled out instead of
    // reusing `call_suffix`: a conversion is not a call, and keeping '(' out
    // of `_member_suffix` below means the two productions never overlap, so
    // the parser has nothing to disambiguate (no precedence games).
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

    // prec(LET_COND): the reduce beats && / || shifts — `(let p <- a) && b`,
    // the bound name in scope for the tail; tighter operators stay in the RHS.
    let_pattern_destructor: ($) => prec(PREC.LET_COND, seq(TOKENS.LET, $._pattern, token('<-'), $._expression)),

    _dollar_identifier: ($) => seq('$', reserved('none', $.identifier)),

    // The `@name`/`@name!` head (optionally with an attribute body) shared by
    // macro calls and macro expressions; the only difference between them is
    // the trailing input body that turns a call into an expression.
    _macro_head: ($) =>
      seq(
        alias($._macro_at, $.macro_call_sigil),
        optional('!'),
        $._macro_name,
        optional(alias($._macro_attr_body, $.macro_attribute_body)),
      ),

    // Macro parameters are RAW TOKEN STREAMS (spec); loses to
    // quote_expression, wins over decorators via prec.dynamic.
    macro_expression: ($) =>
      prec.dynamic(-1, seq($._macro_head, optional(alias($._macro_input_body, $.macro_call_body)))),

    quote_expression: ($) =>
      prec(
        PREC.MACRO_QUOTE,
        seq(
          // The scanner is the primary path (it emits _quote_open only for
          // the word `quote` followed by '(', including nested quotes inside
          // interpolations). The bare TOKENS.QUOTE alternative must stay:
          // tree-sitter requires every reserved word to exist as a token,
          // and a captured bare `quote` without '(' then fails on the
          // missing body — matching cjc's rejection.
          choice(alias($._quote_open, $.quote_keyword), TOKENS.QUOTE),
          // Newlines after 'quote(' are ignored (spec); every newline
          // after a token is itself the separator quoteToken.
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

    // Two tiers: REFUTABLE (enum/const/typed/or) for match + `let p <- e`;
    // IRREFUTABLE (wildcard/binding/tuples of the same) for plain let and
    // foreach — tuples recurse with their tier. catch_pattern is outside.
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
    _var_binding_pattern: ($) =>
      choice(
        alias(reserved('default', $.identifier), $.var_binding_pattern),
        alias($.unicode_identifier, $.var_binding_pattern),
        alias($.raw_identifier, $.var_binding_pattern),
      ),
    tuple_pattern: ($) => seq('(', commaSep1Trailing($._pattern), ')'),

    enum_pattern: ($) =>
      choice(
        seq(
          seq($._name, optional($.type_arguments), '.'),
          field('constructor', alias(reserved('default', $.identifier), $.enum_constructor)),
          optional(field('arguments', $.enum_pattern_arguments)),
        ),
        seq(
          field('constructor', alias(reserved('default', $.identifier), $.enum_constructor)),
          field('arguments', $.enum_pattern_arguments),
        ),
      ),
    enum_pattern_arguments: ($) => seq('(', commaSep1Trailing($._pattern), ')'),

    _constant_pattern: ($) => alias(choice($._literal, seq('-', $._literal)), $.constant_pattern),

    type_pattern: ($) => seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', $._type),

    catch_pattern: ($) =>
      choice($.wildcard_pattern, seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', sep1($._type, '|'))),

    // ===== types =====
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
    // Expression world: _generic_lt is a ZERO-WIDTH decision token (Swift
    // follow-set rule, scanner.c); hidden + aliased so both worlds surface
    // ONE node type: type_arguments.
    _generic_arguments: ($) => seq($._generic_lt, '<', $._type_list, '>'),

    _type_list: ($) => commaSep1Trailing($._type),

    _named_or_type_list: ($) => commaSep1Trailing(choice(seq(reserved('default', $.identifier), ':', $._type), $._type)),

    type_parameters: ($) => seq('<', commaSep1Trailing($.type_parameter), '>'),

    type_parameter: ($) => seq(field('name', reserved('default', $.identifier))),

    // ===== names & suffixes =====
    _name: ($) =>
      choice(
        reserved('default', $.identifier),
        alias($.unicode_identifier, $.identifier),
        alias($.raw_identifier, $.identifier),
        $.scoped_identifier,
      ),
    scoped_identifier: ($) =>
      prec.left(seq(field('scope', $._name), '.', field('name', reserved('default', $.identifier)))),
    field_access: ($) =>
      seq(
        '.',
        choice(
          reserved('default', $.identifier),
          alias($.unicode_identifier, $.identifier),
          alias($.raw_identifier, $.identifier),
        ),
      ),
    scope_resolution: ($) => seq('::', reserved('default', $.identifier)),
    index_access: ($) =>
      seq(
        '[',
        choice(
          seq($._expression, optional(token('..'))),
          seq($._expression, choice(token('..'), token('..=')), $._expression, optional(seq(':', $._expression))),
          seq(token('..'), $._expression),
        ),
        ']',
      ),
    quest_access: ($) => seq('?', choice($.field_access, $.index_access, $.call_suffix, $.lambda_expression)),
    inc_or_dec: (_) => token(choice('++', '--')),

    // Member-ish suffixes: what a chain base can be followed by. '(' is
    // absent on purpose — `T(args)` is a type_conversion_expression, not a call on T,
    // so the type-name base and the conversion never compete.
    _member_suffix: ($) =>
      choice(
        prec(PREC.MEMBER, $.field_access),
        prec(PREC.MEMBER, $.scope_resolution),
        alias($._generic_arguments, $.type_arguments),
      ),

    postfix_expression: ($) =>
      choice(
        $._primary_expression,
        // A primitive type name is an expression only as the base of a
        // member chain — `Int64.MAX_VALUE`, `Bool.parse(x)`, `Int64<...>(...)`.
        // It is not a value on its own, so bare `Int64` is not an expression.
        prec.right(
          PREC.MEMBER,
          seq(field('base', $._hard_keyword_types), field('suffix', $._member_suffix)),
        ),
        // NOTE: the primitive-type base above reuses `_member_suffix`, which is
        // a strict subset of this list. The asymmetry is deliberate: a bare
        // type name may be qualified or generic (`Int64.MAX_VALUE`,
        // `Array<T>`), but `T(args)` is a type_conversion_expression parsed elsewhere, so
        // it never needs call/index/inc-dec/lambda suffixes.
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

    // ===== literals & lexicals =====
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
    // Two inline tokens so 'true'/'false' can be reserved like cjc does.
    boolean_literal: (_) => choice(token('true'), token('false')),

    // The delimiters are aliased so queries can color them (anonymous
    // externals are not queryable); content runs keep expression coloring
    // of interpolations intact.
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
        repeat(seq(optional(repeat1(terminator($))), $._interpolation_statement)),
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
    // cjc lexer ground truth (Lexer.cpp ScanIdentifierOrKeyword): bare
    // identifiers are XID_Start/XID_Continue (NFC-normalized by the
    // compiler; tree-sitter keeps source bytes) and keywords are
    // ASCII-only, so a non-ASCII word can never be a keyword.
    //
    // tree-sitter constraint: the `word` token must compile to character
    // sets for the keyword-capture machinery, which means the ASCII-only
    // regex WITHOUT the `u` flag — a \p{...} class, explicit unicode
    // ranges, or the u flag itself silently kill keyword conversion
    // (Int64 lexes as a plain identifier and type conversions collapse).
    // So `identifier` stays the ASCII word token (plus the ASCII raw
    // escape), and unicode/backticked-unicode shapes are separate tokens
    // that the IDENT/NONE_IDENT helpers join at every identifier position.
    // They are their own node types (aliasing them to the word symbol
    // overflows the generator's word analysis) — queries capture them
    // alongside (identifier). They are never keyword-captured — exactly
    // cjc's semantics. cjc additionally
    // lexes `a-b.c` (separators inside backticks) as a PACKAGE_IDENTIFIER
    // token for import paths, which the package rules don't model.
    identifier: (_) => token(choice(/[a-zA-Z_][a-zA-Z0-9_]*/, seq('`', /[a-zA-Z_][a-zA-Z0-9_]*/, '`'))),
    unicode_identifier: ($) => token(/[\p{XID_Start}_][\p{XID_Continue}_]*/u),
    raw_identifier: ($) => token(seq('`', /[\p{XID_Start}_][\p{XID_Continue}_]*/u, '`')),
  },
};

module.exports = grammar(M);
