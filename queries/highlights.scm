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

(string_literal) @string
(boolean_literal) @constant.builtin
(integer_literal) @number
(float_literal) @number

; Escape sequences surface as named nodes (see grammar_literal.js).
(escape_sequence) @string.escape

(var_binding_pattern) @variable
(this_super_expression) @keyword

(modifiers) @keyword

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
    ; Soft modifiers (public/private/abstract/...) have no keyword tokens —
    ; they surface via the (modifiers) node captured above, and as bare
    ; identifiers elsewhere.
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

; VArray<T, $N> — not a keyword, matched by name
(user_type (identifier) @type.builtin (#eq? @type.builtin "VArray"))

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
    "::"
    "&&="
    "||="
] @operator

; ++/-- are a single named token (not anonymous "+"-style literals)
(inc_or_dec) @operator

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

; ===== Macro quote(...) DSL =====
; Refinements over the operator list above: delimiters inside quote(...) are
; verbatim template text, not code punctuation.

(quote_raw_token) @markup.raw

; $name splices and $( ... ) delimiters: colored like `this`
; (@variable.builtin). Expressions inside $( ) keep regular coloring.
(quote_expression
    "$" @variable.builtin .
    (identifier) @variable.builtin)


; ===== Macro call arguments: raw token streams per spec =====

(macro_raw_token) @markup.raw

; ===== String interpolation =====

; ${ } delimiters inside interpolations.
(string_interpolation) @punctuation.special

; $( ) delimiters inside quote interpolations.
(quote_interpolation) @punctuation.special

; ===== Macro calls =====

(macro_call_sigil) @punctuation.special
(quote_keyword) @keyword


