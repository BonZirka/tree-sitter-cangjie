; Capture resolution relies on ORDER, not (#set! priority): patterns are
; listed general-first, refinements later — the last matching capture wins,
; same convention as tree-sitter-rust/typescript/scalas highlights.scm.
; NOTE on @spell: nvim-treesitter spell convention. @spell must appear
; BEFORE the color capture on the same node — consumers differ (neovim
; applies every capture; the tree-sitter CLI renderer keeps only the
; last one per node, so a trailing @spell would erase the color).

; ===== Broad node classes =====

; Spell-check comment and string text (see NOTE above).
(string_literal) @spell

(line_comment) @spell
(block_comment) @spell

; Color the delimiters and content runs, not the whole literal:
; interpolations must keep regular expression coloring inside.
(string_start) @string
(string_end) @string
(string_content) @string
(boolean_literal) @constant.builtin
(integer_literal) @number
(float_literal) @number
; Char-like literals (nvim convention: @character for r''/b'').
(rune_literal) @character
(byte_literal) @character

; Escape sequences surface as named nodes (see grammar_literal.js).
(escape_sequence) @string.escape

(var_binding_pattern) @variable
(this_super_expression) @variable.builtin

(modifiers) @keyword

; General member reads/writes: obj.field, this.area. Placed BEFORE the call
; refinements so callee positions win @function by "last capture wins".
(field_access (identifier) @property)

[
    (line_comment)
    (block_comment)
] @comment

; ===== Names =====

; NOTE: no global (identifier) capture. The grammar wraps type references in
; user_type/_name with identifier children, and a child capture always paints
; over the parent's @type in nvim regardless of pattern order — a global
; @variable would decolor `Foo<Bar>`/`HashMap<T, U>`. Contextual keywords used
; as identifiers (open/main/handle) therefore render uncolored, like any
; other expression identifier. Type positions are captured explicitly below.

; Parameter names (identifier nodes in parameter positions).
(parameter para_name: (identifier) @parameter)
(named_parameter para_name: (identifier) @parameter)
(unnamed_member_param para_name: (identifier) @parameter)
(lambda_parameter (var_binding_pattern) @parameter)
(property_definition setter: (identifier) @parameter)
(macro_parameter name: (identifier) @parameter)

; ===== Calls =====
; The grammar has no call_expression node — a call is a postfix chain ending
; in call_suffix, and generic arguments are ALSO suffixes, so generic calls
; nest one level deeper. Cover the chain shapes so plain and generic callees
; color identically.
;   head:      call()  /  call<T>()  /  call<T>
(postfix_expression
    base: (postfix_expression (identifier) @function)
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression (identifier) @function)
    suffix: (type_arguments))

(postfix_expression
    base: (postfix_expression
            base: (postfix_expression (identifier) @function)
            suffix: (type_arguments))
    suffix: (call_suffix))

;   member:    a.b(x)  /  a.b<T>(x)  /  a.b<T>
(postfix_expression
    base: (postfix_expression
            suffix: (field_access (identifier) @function))
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression
            suffix: (field_access (identifier) @function))
    suffix: (type_arguments))

(postfix_expression
    base: (postfix_expression
            base: (postfix_expression
                    suffix: (field_access (identifier) @function))
            suffix: (type_arguments))
    suffix: (call_suffix))

;   scoped:    Foo::create(x)  /  Foo::create<T>(x)
(postfix_expression
    base: (postfix_expression
            suffix: (scope_resolution (identifier) @function))
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression
            suffix: (scope_resolution (identifier) @function))
    suffix: (type_arguments))

(class_name) @type
; The primary_init's name is a class_name node — color it like the calls
; (let x = C(...)), not like the type position.
(primary_init (class_name) @function)
(struct_name) @type
(interface_name) @type
(enum_name) @type
(type_alias_name) @type
(func_name) @function
(macro_name) @function.macro
(property_name) @property

; ===== Types =====

; Capture only the type child so delimiters (: ? -> parens) keep operator color.
(return_type type: (_) @type)

; All user-written type references: parameters, return types, variable
; annotations, super/extend lists, casts, generic arguments. Fielded
; captures avoid painting structural delimiters as type.
(user_type) @type
; The identifier child of a user_type refines the general @variable capture
; (later patterns win over overlapping ranges).
(user_type (identifier) @type)
(generic_type) @type
(tuple_type type: (_) @type)
(prefix_type type: (_) @type)
(arrow_type type: (_) @type)

; Generic constraints: `where T <: A & B` — the constrained type variable.
(generic_constraint
    (identifier) @type)

; Inheritance: class/interface parents and extend targets
(super_or_interface) @type
(extend_type) @type

; Conditional compilation feature ids (dotted identifier)
(feature_id (identifier) @type)

; Type parameter names: <T>, <F: Float64>
(type_parameter name: (identifier) @type)

; Enum case names: Red | Green — definitions and pattern references alike.
(enum_body enum_constant: (identifier) @constant)
; enum_constructor is an aliased identifier node itself, not a parent.
(enum_constructor) @constant

; Prop accessor keywords: get()/set()
(getter_keyword) @keyword
(setter_keyword) @keyword

; The '...' member-param wildcard: same match-anything class as '_' below.
(ellipsis_parameter) @operator

; VArray<T, $N>: the '$' sigil joins the splice/interp '$' family.
(const_generic "$" @punctuation.special)

; macro package foo — file-level directive name
(macro_package_declaration package_name: (scoped_identifier) @module)

; Import paths and aliases: import std.math.* as M — the path may be a
; single identifier or a dotted chain.
(import_list package_name: [(scoped_identifier) (identifier)] @module)
(package_full package_name: [(scoped_identifier) (identifier)] @module)
(package_group package_name: [(scoped_identifier) (identifier)] @module)
(sub_group_of_package package_name: [(scoped_identifier) (identifier)] @module)
(package_alias package_name: [(scoped_identifier) (identifier)] @module)
(package_alias alias: (identifier) @module)

; ===== Keywords =====

[
    "struct"
    "enum"
    "package"
    "import"
    "class"
    "interface"
    "func"
    "main"
    "let"
    "var"
    "const"
    "init"
    "super"
    "if"
    "else"
    "case"
    "try"
    "catch"
    "finally"
    "for"
    "do"
    "while"
    "throw"
    "return"
    "continue"
    "break"
    "is"
    "as"
    "in"
    "!in"
    "match"
    "where"
    "extend"
    "macro"
    "static"
    ; The 11 soft modifier words (public/open/...) DO have keyword tokens now
    ; (reserved('modifier') set, active only in modifier-run states) and are
    ; colored via the (modifiers) node above. The bridge aliases turn the same
    ; tokens into named identifier nodes at expression positions, which the
    ; literal patterns below do NOT match (they match anonymous nodes only).
    "operator"
    "foreign"
    "inout"
    "prop"
    "mut"
    "unsafe"
    "spawn"
    "synchronized"
    "type"
    ; effect handlers
    "perform"
    "resume"
    "handle"
    "with"
    "throwing"
    ; conditional compilation / macro DSL
    "features"
] @keyword

; Hard-keyword primitive types (reserved words in Cangjie).
; NOTE: String is NOT here — it is an ordinary (soft) type name.
[
    (Int8)
    (Int16)
    (Int32)
    (Int64)
    (IntNative)
    (UInt8)
    (UInt16)
    (UInt32)
    (UInt64)
    (UIntNative)
    (Float16)
    (Float32)
    (Float64)
    (Rune)
    (Bool)
    (Unit)
    (Nothing)
    (Thistype)
] @type.builtin

; Soft builtin type: ordinary identifier-like name
(String) @type

; ===== Operators & punctuation =====

[
    "."
    ","
    "("
    ")"
    "["
    "]"
    "{"
    "}"
    "**"
    "*"
    "%"
    "/"
    "+"
    "-"
    "&&"
    "||"
    "!"
    "&"
    "|"
    "^"
    "<<"
    ">>"
    ":"
    ";"
    "="
    "+="
    "-="
    "*="
    "**="
    "/="
    "%="
    "&="
    "|="
    "^="
    "<<="
    ">>="
    "->"
    "<-"
    "=>"
    "..="
    ".."
    "?"
    "??"
    "<:"
    "<"
    ">"
    "<="
    ">="
    "!="
    "=="
    "_"
    "|>"
    "~>"
    "~"
    "::"
    "&&="
    "||="
] @operator

; ++/-- are a single named token (not anonymous "+"-style literals)
(inc_or_dec) @operator

; The unit () must be captured AFTER the operator list: its '(' ')' children
; capture @operator on the same range, and the last capture wins.
(unit_literal) @constant.builtin

; ===== Call-shape refinements (must follow broad captures above) =====

; Callee names in calls: foo(...) and obj.method(...)
; Also covers trailing-lambda calls: list.map { x => x }
; The recursive postfix rule wraps each base in its own node, hence the
; nesting depth: callee of a call sits two levels down (three for methods).
(postfix_expression
    (postfix_expression
        (identifier) @function)
    [(call_suffix) (lambda_expression)])
(postfix_expression
    (postfix_expression
        (postfix_expression
            (field_access
                (identifier) @function)))
    [(call_suffix) (lambda_expression)])

; Numeric casts look like bare calls: Int64(x), Float64(y), Rune(n).
; Placed after the callee rules above so it wins by order, not priority.
((
    (postfix_expression
        (postfix_expression
            (identifier) @type.builtin)
        (call_suffix)))
 (#any-of? @type.builtin
    "Int8" "Int16" "Int32" "Int64" "IntNative"
    "UInt8" "UInt16" "UInt32" "UInt64" "UIntNative"
    "Float16" "Float32" "Float64"
    "Rune"))

; VArray<T, $N> — matched by name; after the callee refinements so the
; construction call VArray<Int64, $N>() still colors as the builtin type.
(user_type (identifier) @type.builtin (#eq? @type.builtin "VArray"))

; ===== Macro quote(...) DSL =====
; Refinements over the operator list above: delimiters inside quote(...) are
; verbatim template text, not code punctuation.

(quote_raw_token) @markup.raw

; The '(' ')' delimiters inside quote(...) are template text like the raw
; runs — same @markup.raw. (They are named nodes because anonymous externals
; are not queryable.)
(quote_paren) @markup.raw

; $name splices: '$' and the spliced name share @variable.builtin ("colored
; like this"). The '$(' of quote interpolations is a single external token,
; so it cannot share the split coloring and stays @punctuation.special.
(quote_expression
    "$" @variable.builtin .
    (identifier) @variable.builtin)


; ===== Macro call arguments: raw token streams per spec =====

(macro_raw_token) @markup.raw

; ===== String interpolation =====

; Interpolation delimiters only: the inner expressions must color like
; regular code, so the whole interpolation node is never captured.
(interp_open) @punctuation.special
(interp_close) @punctuation.special
; The quote interpolation delimiters join the $identifier splice family.
(quote_interp_open) @variable.builtin
(quote_interp_close) @variable.builtin

; ===== Macro calls =====

(macro_call_sigil) @punctuation.special
; Macro input/attribute body delimiters join the @-sigil's color so the
; whole call head @Name(...) reads as one unit.
(macro_input_open) @punctuation.special
(macro_input_close) @punctuation.special
(macro_attr_open) @punctuation.special
(macro_attr_close) @punctuation.special
(quote_keyword) @keyword
(quote_close) @keyword


