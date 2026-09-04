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
(this_super_expression) @variable.builtin

(modifiers) @keyword

[
    (line_comment)
    (block_comment)
] @comment

; ===== Names =====

(class_name) @type
(struct_name) @type
(interface_name) @type
(enum_name) @type
(type_alias_name) @type
(func_name) @function
(macro_name) @function.macro
(annotation_name) @function.macro
(property_name) @property

; ===== Types =====

; Capture only the type child so delimiters (: ? -> parens) keep operator color.
(return_type type: (_) @type)

; All user-written type references: parameters, return types, variable
; annotations, super/extend lists, casts, generic arguments. Fielded
; captures avoid painting structural delimiters as type.
(user_type) @type
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
    "public"
    "private"
    "protected"
    "internal"
    "override"
    "redef"
    "sealed"
    "abstract"
    "open"
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
    "quote"
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
    "@"
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
(postfix_expression
    (atomic_variable) @function
    [(call_suffix) (trailing_lambda_expression)])
(postfix_expression
    (postfix_expression
        (field_access
            (atomic_variable) @function))
    [(call_suffix) (trailing_lambda_expression)])

; Numeric casts look like bare calls: Int64(x), Float64(y), Rune(n).
; Placed after the callee rules above so it wins by order, not priority.
((
    (postfix_expression
        (atomic_variable) @type.builtin
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
(quote_escape) @string.escape

; $name splices and $( ... ) delimiters: colored like `this`
; (@variable.builtin). Expressions inside $( ) keep regular coloring.
(quote_expression
    "$" @variable.builtin .
    (identifier) @variable.builtin)
(quote_paren_group
    "$" @variable.builtin .
    (identifier) @variable.builtin)
(quote_interpolation
    "$" @variable.builtin
    "(" @variable.builtin
    ")" @variable.builtin)

; Parenthesis groups inside quote: their delimiters are verbatim text,
; same as the raw tokens around them.
(quote_paren_group
    "(" @markup.raw
    ")" @markup.raw)

; ===== Macro call arguments: raw token streams per spec =====

(macro_raw_token) @markup.raw
(macro_escape) @string.escape
(macro_paren_group
    "(" @markup.raw
    ")" @markup.raw)
(macro_bracket_group
    "[" @markup.raw
    "]" @markup.raw)

; ===== String interpolation =====

; ${ } delimiters inside interpolations.
(inline_expression "${" @punctuation.special)
(inline_expression "}" @punctuation.special)
(in_multi_line_string_expression "${" @punctuation.special)
(in_multi_line_string_expression "}" @punctuation.special)

; Macro call prefix (alias of annotation); after "@" @operator above.
(macro_call_prefix "@" @punctuation.special)
