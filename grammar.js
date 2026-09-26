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
    COMMENT: 0,
    ASSIGN: 1,
    PIPE: 2,
    COALESCE: 3,
    // Range binds looser than every arithmetic/logical/bitwise operator
    // (Cangjie spec: just above assignment) — `(x&127)..=(y&127):step` is the
    // corpus's dominant mask-range idiom and misgroups if RANGE is tighter.
    RANGE: 4,
    OR: 5,
    AND: 6,
    BIT_OR: 7,
    BIT_XOR: 8,
    BIT_AND: 9,
    EQUALITY: 10,
    REL: 11,
    SHIFT: 12,
    ADD_SUB: 13,
    MUL_DIV: 14,
    POWER: 15,
    UNARY: 16,
    POSTFIX: 17,
    PARENS: 18,
    ARRAY: 19,
    MEMBER: 20,
    MACRO_QUOTE: 22,
    TOKEN: 23,
    INIT: -1,
    STATIC_INIT: -2,
};

// TODO: cleanup

// Keyword tokens; key = UPPER(value) for all but NOT_IN and THISTYPE.
const _kw = s => Object.fromEntries(s.split(/\s+/).map(w => [w.toUpperCase(), token(w)]));
const _kwWords = 'as break Bool case catch class const continue Rune do else enum extend features for from func finally foreign handle Float16 Float32 Float64 if in is init inout import interface Int8 Int16 Int32 Int64 IntNative let mut main macro match Nothing operator prop package quote return spawn super static struct synchronized perform resume with throwing try this true type throw unsafe Unit UInt8 UInt16 UInt32 UInt64 UIntNative var where while public protected internal private abstract sealed redef open override common specific';
const TOKENS = {
    ..._kw(_kwWords),
    NOT_IN: token('!in'), THISTYPE: token('This'),
};

// Keywords whose token is actually used in a rule (reserved words must resolve
// to an existing token). 'from'/'quote'/'true' are declared but never used.
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

// Cangjie primitive-type words double as real type names and constructor calls
// (e.g. `Int32(x)`, `UInt16(y)`), so they must never be forced to keywords.
const _primitiveKeywords = new Set([
    'Bool', 'Rune', 'String', 'Unit', 'Nothing',
    'Int8', 'Int16', 'Int32', 'Int64', 'IntNative',
    'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
    'Float16', 'Float32', 'Float64',
]);

// Cangjie contextual keywords: usable as identifiers in name positions.
// The 11 soft modifier words are consumed by `modifiers` via the exact-word
// `_soft_modifier` token; `features` keeps its token for the features
// directive; `handle` keeps its token for `try {} handle(e: T) {}` clauses
// (stdlib uses `handle` as an ordinary identifier everywhere else —
// cjc-verified by the compiling stdlib corpus).
const CONTEXTUAL_KEYWORDS = [
    'public', 'protected', 'private', 'internal',
    'abstract', 'sealed', 'redef', 'open', 'override',
    'common', 'specific', 'features', 'handle', 'main'
];

// Soft modifier words: no keyword token — pure words. `modifiers` consumes
// them through `reserved('id', $.identifier)`; since that production aliases
// to an anonymous token, tree dumps and queries are unchanged.
const SOFT_MODIFIER_WORDS = [
    'public', 'protected', 'private', 'internal',
    'abstract', 'sealed', 'redef', 'open', 'override',
    'common', 'specific',
];

// Name/expression positions where contextual keywords lex as identifiers:
// every `reserved('id', $.identifier)` below. Outside these rules the global
// set applies and a contextual keyword can NEVER be an identifier (the
// runtime converts a reserved word to its keyword token even when only the
// identifier is valid in the state).
// First (global) reserved word set: every keyword word — keywords everywhere
// by default. Second (`id`) word set drops the contextual keywords so they
// lex as identifiers inside `reserved('id', $.identifier)` name/expression
// positions. Runtime semantics: a word lexed as identifier becomes its
// keyword iff the keyword is valid in the state OR the word is in the
// state's active reserved set. Primitives (Bool, Int8, ...) double as type
// names and constructor calls (`Int32(x)`) and are in no set. NOT_IN ('!in')
// is not a word and cannot be reserved; 'This' is word-shaped and stays
// reserved in both sets.
const GLOBAL_RESERVED = [
    ..._kwUsed.filter(w => !_primitiveKeywords.has(w) && !SOFT_MODIFIER_WORDS.includes(w)),
    'This',
];
const IDENTIFIER_POS_RESERVED = [
    ..._kwUsed.filter(w => !_primitiveKeywords.has(w)
        && !CONTEXTUAL_KEYWORDS.includes(w)),
    'This',
];
// Third word set: NOTHING reserved — positions that accept arbitrary words,
// including hard-keyword spellings (`$where` macro escapes, feature ids).
const NO_RESERVED = [];

const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));
const commaSep1Trailing = rule => seq(sep1(rule, ','), optional(','));

const hexDigit = /[0-9a-fA-F]/;
const hexDigits = seq(hexDigit, repeat(choice('_', hexDigit)));
const decimalDigits = seq(/[0-9]/, repeat(choice('_', /[0-9]/)));
const decimalLiteral = choice(/[0-9]/, seq(/[1-9]/, repeat1(choice('_', /[0-9]/))));

const uniCharacterLiteral = seq('\\u{', /[0-9a-fA-F]{1,8}/, '}');

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
    
    reserved: {
      default: $ => GLOBAL_RESERVED,
      id: $ => IDENTIFIER_POS_RESERVED,
      none: $ => NO_RESERVED,
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
        // $._pattern is NOT a valid supertype here: alternatives like
        // type_pattern / enum_pattern yield multiple visible children, and
        // tree-sitter requires each supertype production to have exactly one.
    ],

    conflicts: $ => [
        // "Whose lambda?": the lambda binds to the call's own slot, or
        // floats to the postfix chain / statement level.
        [$._call_tail],
        // Load-bearing: whether a handler's trailing terminators belong to
        // the handler or to the enclosing statement decides whether
        // `try {} catch {}\n(expr)` splits into two statements. Greedy
        // absorption (associativity) statically kills the split reading.
        // `const` floats inside modifier runs (`const static func`,
        // `public const operator func`) yet is the DECLARATION keyword in
        // `public const x = 1` — same prefix, divergence only at the next
        // token, so the two modifier runs (full vs const-less for variable
        // declarations) must coexist as GLR versions until then. Both render
        // the same `modifiers` node, so surviving ties are tree-identical.
        [$.modifiers, $._modifiers_var],
        // Member-level `const`: modifier start (`const func`, `const init`)
        // vs compile-time-constant declaration (`const x = 1`). Same token,
        // divergence only at the following token — GLR must keep both.
        [$.modifiers, $._var_decl_tail],
        // Statement starts: a soft modifier word lexes as an identifier and
        // forks between the modifier run and an expression (`open = 4`);
        // inside primary_init bodies the variable-declaration modifier run
        // joins the fork.
        [$.modifiers, $._primary_expression],
        [$._modifiers_var, $._primary_expression],
        [$.modifiers, $._modifiers_var, $._primary_expression],
        [$._name, $._primary_expression],
        [$._var_binding_pattern, $._primary_expression],
        [$.named_parameter, $.unnamed_member_param],
        [$._constant_pattern, $._primary_expression],
        // `let x: T` in a block: a declaration (`= e`) or a let pattern
        // (`<- e`) — the two read alike up to that token.
        [$.type_pattern, $._patterns_maybe_irrefutable],
    ],

    rules: {
        // Flat repeat: main_definition is an ordinary top-level item. The old
        // `optional(_top_objects) optional(main) optional(_top_objects)` kept
        // GLR versions alive across the whole file (declaration-split-point
        // ambiguity): every version merge structurally compared the
        // accumulated subtree (ts_subtree_compare) — O(n^2) on large files.
        // Newlines are extras; only `;` needs an explicit separator here
        // (requiring _terminator tokens made every item boundary ambiguous).
        // Newlines are extras and `;` is optional in Cangjie — a single
        // optional `;` before each item covers runs via iteration.
        translation_unit: $ => seq(
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

        // prec.right: greedily absorb the terminator run; the repeat
        // self-conflict resolves by associativity, no GLR needed.
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

        // Full modifier run: soft words (public, open, ...) are consumed via
        // the word token — they have no keyword token, so a soft word at a
        // statement start lexes as an identifier and forks cleanly between
        // the modifier run and an expression (see conflicts). Anonymous
        // alias keeps tree dumps identical to the keyword-token era.
        _soft_modifier: _ => token(choice(
            'public', 'protected', 'private', 'internal', 'abstract',
            'sealed', 'redef', 'open', 'override', 'common', 'specific',
        )),
        modifiers: $ => prec.left(repeat1(choice(
            $._soft_modifier,
            TOKENS.STATIC, TOKENS.CONST, TOKENS.MUT, TOKENS.UNSAFE,
        ))),
        // Variable-declaration context: `const` is the compile-time-constant
        // declaration keyword (`const X = 1`), not a modifier — `public
        // const x = 1` must reduce after `public`. Hidden + aliased to the
        // `modifiers` node name so GLR versions that survive side by side
        // (see the [$.modifiers, $._modifiers_var] conflict) render identical
        // trees and merge instead of racing.
        _modifiers_var: $ => alias(prec.left(repeat1(choice(
            $._soft_modifier,
            TOKENS.STATIC, TOKENS.MUT, TOKENS.UNSAFE,
        ))), $.modifiers),
        _name: $ => choice(
            reserved('id', $.identifier),
            $.scoped_identifier,
        ),        scoped_identifier: $ => seq(
            field("scope", $._name), '.', field('name', reserved('id', $.identifier))),
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
        _import_packages: $ => choice(
            prec.right(-3, field('package_name', $._name)),
            prec.right(-2, $.package_full),
            prec.right(-1, $.package_alias),
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
            seq(reserved('id', $.identifier), ':', $._type),
            $._type
        )),

        prefix_type: $ => seq('?', field('type', $._type)),

        // prec.right: `as Foo<Bar>` keeps `<Bar>` in the type instead of
        // spilling into an outer relational continuation (`(x as Foo) < Bar`).
        user_type: $ => prec.right(seq($._name, optional($.type_arguments))),
        // `Array`/`Range` lex as keywords in type positions, so the bare
        // type (`let r: Range`, `AsRange(Range)`) has to be accepted here:
        // user_type can no longer see them as identifiers.
        generic_type: $ => prec.right(seq(choice(token('Array'), token('Range')), optional($.type_arguments))),

        const_generic: $ => seq(token('$'), $.integer_literal),

        // Type world (annotations, user_type, enum patterns): '<' here is
        // unambiguous, internal token.
        type_arguments: $ => seq('<', $._type_list, '>'),
        // Expression world: _generic_lt is a ZERO-WIDTH decision token
        // emitted BEFORE the '<' (Swift follow-set commit, see scanner.c).
        // Because the rule starts with the external token, the internal '<'
        // can never open it — the binary '<' operator keeps its unambiguous
        // path, and the scanner's commit alone selects the generic reading.
        // Hidden and aliased so both worlds surface ONE node type:
        // type_arguments.
        _generic_arguments: $ => seq($._generic_lt, '<', $._type_list, '>'),

        type_parameters: $ => seq('<', commaSep1Trailing($.type_parameter), '>'),

        type_parameter: $ => seq(
            field('name', reserved('id', $.identifier)),
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
                // Both branches rename to var_binding_pattern (no identifier child)
        // so soft-word bindings and plain bindings share one node shape.
        _var_binding_pattern: $ => alias(choice(reserved('id', $.identifier), $._soft_modifier), $.var_binding_pattern),
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

        catch_pattern: $ => choice($.wildcard_pattern, seq(choice($.wildcard_pattern, $._var_binding_pattern), ':', sep1($._type, '|'))),

        main_definition: $ => seq(
            TOKENS.MAIN, $.parameter_list, optional($.return_type),
            $.block
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

        //top level objects
        // Member/top-level form: visibility modifiers allowed. `modifiers_var`
        // excludes `const` — here it is the compile-time-constant declaration
        // keyword, not a modifier.
        variable_declaration: $ => seq(
            optional($._modifiers_var),
            $._var_decl_tail,
        ),
        // Block-local form: Cangjie locals take no visibility modifiers, so
        // `open let x = 1` in a block is unambiguously an expression followed
        // by a declaration (no GLR fork). Aliased so trees keep the
        // `variable_declaration` node name.
        _local_variable_declaration: $ => $._var_decl_tail,
        _var_decl_tail: $ => seq(
            choice(TOKENS.LET, TOKENS.VAR, TOKENS.CONST),
            field('name', alias($._patterns_maybe_irrefutable, $.variable_name)),
            choice(
                seq(':', field('type', $._type), optional(seq('=', field("initializer", $._expression)))),
                seq('=', field("initializer", $._expression))
            ),
        ),
        // prec.right: after a complete signature, a following `{` is always
        // the body — the body-less reading (interfaces) never wins on `{`,
        // so the shift/reduce resolves by associativity and the conflict
        // declaration goes away.
        function_definition: $ => prec.right(seq(
            optional($.modifiers),
            TOKENS.FUNC,
            field('name', alias(reserved('id', $.identifier), $.func_name)),
            optional($.type_parameters),
            field('parameters', $.parameter_list),
            optional(field('return_type', $.return_type)),
            optional($.generic_constraints),
            // No terminator-prefixed body alternative: re-adding it flips the
            // where-clause/next-line-brace ties the wrong way (verified:
            // report_bench_html extend body 0 -> 3 errors). Next-line `{`
            // attachment is handled by terminator suppression in the scanner.
            optional(field('body', $.block))
        )),
        // Ordered groups: unnamed parameters first, named (`x!: T`) after —
        // the split matters for overload resolution, do not flatten into one
        // choice. sep1 groups replace the old left-recursive list rules.
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

        ellipsis_parameter: $ => seq(optional(','), '...'),
        // Parameters may carry stacked annotations (@A0 / @A1[12]) and may be
        // wrapped in parens — `init(@M1 (a: Int64), @M1[x] (b!: Int64))` is the
        // macro-expansion-in-parameter-position shape (cjc-verified). The
        // paren group lives only on `parameter`; its inner contents are
        // disjoint (named_parameter requires `!`), so no GLR conflict.
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
            seq(field('para_name', reserved('id', $.identifier)), '!'),
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

        interface_definition: $ => seq(typeHeader($, TOKENS.INTERFACE, alias(reserved('id', $.identifier), $.interface_name)), field('body', $.declaration_body)),
        _super_interfaces: $ => seq(optional(seq($._super_interfaces, '&')), seq(alias($._name, $.super_or_interface), optional($.type_arguments))),
        // Unified declaration body - permissive, accepts all member types
        declaration_body: $ => seq(
            '{',
            optional($._declaration_list),
            '}'
        ),
        // Flat member list: newline runs are extras, so members need no
        // terminator separators (mirrors the flattened translation_unit).
        // The old left-recursive `optional(seq(list, repeat1(terminator)))`
        // pattern kept a live version per member boundary for whole class
        // bodies, feeding ts_subtree_compare's O(n^2) merges, and required
        // explicit `_terminator` tokens before a next-line `{`.
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

        class_definition: $ => seq(typeHeader($, TOKENS.CLASS, $._class_name), field('body', $.declaration_body)),
        _class_name: $ => alias(reserved('id', $.identifier), $.class_name),
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
            // NOTE: no designated super-call slot. cjc requires super(args)
            // to be the first statement of a primary constructor body, but
            // that is a semantic position check — as an expression statement
            // it parses through the ordinary postfix chain, which also
            // removes the primary_init/this_super_expression GLR fork.
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
        // A member parameter may carry annotations before its modifiers
        // (`@M[x] public let a: T`), as a plain parameter does.
        unnamed_member_param: $ => seq(
            optional(repeat1($.macro_call)),
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            field('para_name', choice(reserved('id', $.identifier), '_')),
            optional('!'),
            ':',
            field('type', $._type),
            optional(seq('=', field('default_value', $._expression)))
        ),

        named_member_param: $ => seq(
            optional(repeat1($.macro_call)),
            optional($.modifiers),
            choice(TOKENS.LET, TOKENS.VAR),
            $.named_parameter
        ),

        finalizer: $ => seq(
            '~', TOKENS.INIT, '(', ')',
            $.block
        ),

        struct_definition: $ => seq(typeHeader($, TOKENS.STRUCT, alias(reserved('id', $.identifier), $.struct_name)), field('body', $.declaration_body)),

        enum_definition: $ => seq(typeHeader($, TOKENS.ENUM, alias(reserved('id', $.identifier), $.enum_name)), field('body', $.enum_body)),
        enum_body: $ => seq(
            '{', optional('|'),
            sep1(field('enum_constant', choice(
                    seq(optional(repeat1($.macro_call)), reserved('id', $.identifier), optional(seq('(', commaSep1Trailing($._type), ')'))),
                    token('...')
                )), '|'),
            optional($._declaration_list),
            '}'
        ),

        type_alias: $ => seq(
            optional($.modifiers),
            TOKENS.TYPE,
            field('name', alias(reserved('id', $.identifier), $.type_alias_name)),
            optional($.type_parameters),
            '=',
            field('type', $._type)
        ),

        extend_definition: $ => seq(
            TOKENS.EXTEND,
            $.extend_type,
            typeTail($),
            field('body', $.declaration_body),
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
        // Macro names may be package-qualified: `@p1.M1[tok](body)` (the
        // standard macro-package form, cjc-verified).
        // prec.right: greedily absorb `.` into the qualified name (@A.B);
        // repeat self-conflict resolved by associativity.
        _macro_name: $ => alias(prec.right(seq(repeat(seq(reserved('id', $.identifier), '.')), reserved('id', $.identifier))), $.macro_name),


        // Assignment targets: everything except the prefix rules that take a
        // bare _expression body (perform/resume) — otherwise `perform x = y`
        // is genuinely ambiguous between `perform (x = y)` and
        // `(perform x) = y`.

        // expressions
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

        _expression: $ => choice(
            $.postfix_expression,
            $.unary_expression,
            $.binary_expression,
            $.is_expression,
            $.as_expression,
            $.assignment_expression,
        ),

        _primary_expression: $ => choice(
            $._literal,
            $.array_literal,
            reserved('id', $.identifier),
            // A soft modifier word lexes as its token whenever a modifier run
            // may start (statement starts), so the expression route must
            // consume the same token to read it as an identifier (`open = 4`).
            alias($._soft_modifier, $.identifier),
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
            $.let_pattern_destructor,
            $._dollar_identifier,
            seq(
                    token('$('),
                    $._expression,
                    ')',
                ),
        ),

        let_pattern_destructor: $ => prec.right(seq(
            // `if (let x: T <- e)`: a let pattern may also be a type pattern.
            TOKENS.LET, choice($._patterns_maybe_irrefutable, $.type_pattern), token('<-'), $._expression,
        )),


        unary_expression: $ => prec.left(PREC.UNARY, seq(
            field('operator', choice('!', '-')),
            field('argument', $._expression)
        )),

        binary_expression: $ => prec.dynamic(-1, choice(
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
        )),

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

        parenthesized_expression: $ => seq('(', $._expression, ')'),
        range_expression: $ => prec.right(PREC.RANGE, seq(
            optional(field('start', $._expression)),
            choice(token('..'), token('..=')),
            optional(field('end', $._expression)),
            optional(seq(':', field('step', $._expression)))
        )),

        postfix_expression: $ => choice(
            $._primary_expression,
            prec.right(PREC.MEMBER, seq(
                field('base', $.postfix_expression),
                field('suffix', choice(
                        prec(PREC.MEMBER, $.field_access), prec(PREC.MEMBER, $.scope_resolution),
                        prec(PREC.ARRAY, $.index_access), prec(PREC.POSTFIX, $.quest_access),
                        prec(PREC.PARENS, $.call_suffix), prec(PREC.POSTFIX, $.inc_or_dec),
                        // Expression-position generics: the zero-width _generic_lt
                        // decision token (Swift follow set, scanner.c) selects between
                        // the generic reading and the binary '<' operator — no GLR.
                        alias($._generic_arguments, $.type_arguments),
                        $.lambda_expression,
                    )),
            )),
        ),


        field_access: $ => seq('.', reserved('id', $.identifier)),
        scope_resolution: $ => seq('::', reserved('id', $.identifier)),
        call_suffix: $ => seq(
            '(',
            optional(commaSep1Trailing(choice(
                seq(choice(reserved('id', $.identifier), alias($._soft_modifier, $.identifier)), ':', $._expression),
                $._expression,
                seq(TOKENS.INOUT, optional(seq($._expression, '.')), choice(reserved('id', $.identifier), alias($._soft_modifier, $.identifier)))
            ))),
            // No comma-form: `f(x, { ... })` parses `{ ... }` as a plain
            // lambda_expression argument. The old
            // `optional(seq(',', trailing_lambda_expression))` made every
            // `, {` after a nested call's `)` spawn a "whose lambda?" GLR
            // version that lived across the whole argument list.
            $._call_tail
        ),
        // The decision point of the "whose lambda?" fork, isolated so the
        // conflict is named after it instead of call_suffix-vs-itself:
        // after `)`, bind the lambda to the call, or end the call here.
        _call_tail: $ => seq(')', optional($.lambda_expression)),
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
            $.lambda_expression,
        )),
        inc_or_dec: _ => token(choice('++', '--')),

        tuple_expression: $ => seq('(', $._expression, repeat1(seq(',', $._expression)), optional(','), ')'),
        lambda_parameters: $ => commaSep1Trailing($.lambda_parameter),
        lambda_parameter: $ => seq(choice($._var_binding_pattern, '_'), optional(seq(':', $._type))),

        jump_expression: $ => choice(
            prec.right(seq(TOKENS.THROW, $._expression)),
            prec.right(seq(TOKENS.RETURN, optional($._expression))),
            TOKENS.CONTINUE,
            TOKENS.BREAK,
        ),

        this_super_expression: _ => choice(TOKENS.THIS, TOKENS.SUPER),
        // Unified lambda: header (params + '=>') is optional here. cjc
        // requires '=>' for standalone lambdas and allows omitting it only
        // in trailing position; the grammar accepts both everywhere
        // (harmless superset, one rule instead of two).
        lambda_expression: $ => seq(
            '{',
            optional(seq(optional($.lambda_parameters), token('=>'))),
            optional($._expression_or_declarations),
            '}'
        ),
        spawn_expression: $ => seq(TOKENS.SPAWN, optional(seq('(', $._expression, ')')), $.lambda_expression),
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
            $._expression_or_declarations,
        ),
        match_case_body: $ => seq(
            TOKENS.CASE, $._expression, token('=>'),
            $._expression_or_declarations,
        ),


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
            repeat(choice($.catch_clause, $.handle_clause)),
            optional(seq(TOKENS.FINALLY, field('finally_body', $.block)))
        )),

        // Each handler consumes its trailing terminators (newlines/`;`) so the
        // handler loop stays sticky across lines (FU-1 fix) without grabbing
        // terminators via a failed "next handler" iteration (which over-consumed
        // trailing newlines in single-catch tries used as assignment RHS).
        // No terminator repeat: newlines between handlers are extras, so the
        // handler loop is sticky across lines for free, and the try's extent
        // ends at the last handler's `}` — the absorb-vs-hand-off newline
        // fork (and its GLR conflict) disappears.

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

        // command_type_pattern: a type optionally followed by a deconstruct tuple,
        // e.g. `Foo` or `Foo(x, y)`. See ParseCommandTypePattern (ParsePattern.cpp).
        command_type_pattern: $ => seq(
            optional(seq(choice($.wildcard_pattern, $._var_binding_pattern), ':')),
            field('type', $._type),
            optional($.tuple_pattern)
        ),

        resource_specifications: $ => commaSep1Trailing($.resource_specification),
        resource_specification: $ => seq(reserved('id', $.identifier), optional(seq(':', $._type)), '=', $._expression),  // $.classType

        // Macro call expression: @Name!?( raw tokens ) and/or @Name!?[ raw tokens ]
        // Per Cangjie spec, macro parameters are RAW TOKEN STREAMS, not expressions.
        // prec(PREC.MACRO_QUOTE): lose to quote_expression (same precedence) when input is
        // quote(...); decorators still win via prec.dynamic on decorated_member.
        macro_expression: $ => prec.dynamic(-1, seq(
            alias($._macro_at, $.macro_call_sigil),
            optional('!'),
            $._macro_name,
            optional(alias($._macro_attr_body, $.macro_attribute_body)),
            optional(alias($._macro_input_body, $.macro_call_body)),
        )),

        _macro_attr_body: $ => prec.right(seq(
            $._macro_attr_open,
            repeat($._macro_body_item),
            optional($._macro_attr_close),
        )),

        _macro_input_body: $ => prec.right(seq(
            $._macro_input_open,
            repeat($._macro_body_item),
            optional($._macro_input_close),
        )),

        _macro_body_item: $ => choice(
            alias($._macro_body_content, $.macro_raw_token),
            $.escape_sequence,
            $.string_literal,
            $.rune_literal,
        ),

        // Macro call prefix attached to a declaration: `@Name` / `@Name[...]`.
        // Per design, `(`-bodies are expression input and never attach; the
        // prefix therefore takes no input body.
        // prec(1): statically beats macro_expression when the fork survives
        // to a tie — the decorated reading always wins (previously GLR).
        macro_call: $ => prec(1, seq(
            alias($._macro_at, $.macro_call_sigil),
            optional('!'),
            $._macro_name,
            optional(alias($._macro_attr_body, $.macro_attribute_body)),
        )),

        // One or more macro-call prefixes attached to a declaration. Lists
        // CONCRETE decl types (not _top_level_object) to avoid recursion.
        decorated_declaration: $ => prec.dynamic(1, prec.right(seq(
            repeat1($.macro_call),
            choice(
                $.class_definition, $.function_definition, $.struct_definition,
                $.interface_definition, $.enum_definition, $.type_alias, $.extend_definition,
                $.foreign_declaration, $.variable_declaration, $.operator_function_definition,
                $.property_definition, $.init, $.static_init, $.finalizer, $.primary_init,
            )
        ))),

        quote_expression: $ => prec(PREC.MACRO_QUOTE, seq(
            alias($._quote_open, $.quote_keyword),
            repeat($._quote_body_item),
            $._quote_close,
        )),

        _quote_body_item: $ => choice(
            alias($._quote_content, $.quote_raw_token),
            $.escape_sequence,
            $.string_literal,
            $.rune_literal,
            $.quote_paren_group,
            $.quote_interpolation,
            $._dollar_identifier,
        ),

        quote_paren_group: $ => seq(
            $._quote_paren_open,
            repeat($._quote_body_item),
            $._quote_paren_close,
        ),

        quote_interpolation: $ => seq(
            $._quote_interp_open,
            $._expression,
            $._quote_interp_close,
        ),

        line_comment: _ => token(prec(PREC.COMMENT, seq('//', /[^\r\n\u2028\u2029]*/))),
        block_comment: $ => seq('/*', $._block_comment_content),
        identifier: _ => token(choice(
            /[a-zA-Z_][a-zA-Z0-9_]*/,
            seq('`', /[a-zA-Z_][a-zA-Z0-9_]*/, '`'),
        )),
        _dollar_identifier: $ => seq('$', reserved('none', $.identifier)),

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

        string_literal: $ => choice(prec.right(seq(
                $._line_string_start,
                repeat(choice($._line_string_content, $.escape_sequence, $.string_interpolation)),
                optional($._line_string_end),
            )), prec.right(seq(
                    $._multiline_string_start,
                    optional(seq(optional(/\r/), /\n/)),
                    repeat(choice($._multiline_string_content, $.escape_sequence, $.string_interpolation)),
                    optional($._multiline_string_end),
                )), seq(
                        $._raw_string_start,
                        optional($._raw_string_content),
                        optional($._raw_string_end),
                    )),

        // prec.right: the scanner pushes the string context at the quote,
        // so content tokens belong to the string — the "bare start" reading
        // is scanner-impossible and the repeat resolves by associativity.



        // ${} holes: full interpolation context — statements, nested brace
        // groups (if/lambda bodies surface as raw groups), strings, raw strings.
        string_interpolation: $ => seq(
            $._interp_open,
            repeat(seq(
                optional(repeat1(terminator($))),
                choice($._interpolation_statement, $.interp_brace_group),
            )),
            $._interp_close,
        ),

        interp_brace_group: $ => seq(
            $._brace_open,
            repeat(seq(
                optional(repeat1(terminator($))),
                choice($._interpolation_statement, $.interp_brace_group),
            )),
            $._brace_close,
        ),

        _interpolation_statement: $ => choice(alias($._local_variable_declaration, $.variable_declaration), $._expression),

        unit_literal: _ => seq('(', ')'),
    },
};

module.exports = grammar(M);
