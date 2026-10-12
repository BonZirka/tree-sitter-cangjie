; Capture model per nvim-treesitter's CONTRIBUTING capture taxonomy, split
; the way kotlin/java/rust queries split them: keyword families, punctuation
; vs operators, member/parameter variables, float numbers, attributes.
; Capture resolution relies on ORDER, not (#set! priority): patterns are
; listed general-first, refinements later — the last matching capture wins,
; same convention as tree-sitter-rust/typescript highlights.scm.
; NOTE on @spell: it is an orthogonal attribute in nvim (consumers apply it
; alongside the color capture), but the tree-sitter CLI renderer keeps only
; the LAST capture per node — so @spell comes FIRST on every node it shares
; with a color capture (string content runs, comments).

; ===== Comments =====

(line_comment) @spell @comment
(block_comment) @spell @comment

; ===== Strings =====

; Color the delimiters and content runs, not the whole literal:
; interpolations must keep regular expression coloring inside, and @spell
; must cover only the text runs (never the interpolated code).
(string_start) @string
(string_end) @string
(string_content) @spell
(string_content) @string

; Escape sequences surface as named nodes (see grammar_literal.js).
(escape_sequence) @string.escape

; ===== Literals =====

(boolean_literal) @constant.builtin
(integer_literal) @number
(float_literal) @number.float
; Char-like literals (nvim convention: @character for r''/b'').
(rune_literal) @character
(byte_literal) @character

; The unit () must be captured AFTER the punctuation list: its '(' ')' are
; @punctuation.bracket on the same range, and the last capture wins.
(unit_literal) @constant.builtin

; ===== Variables =====

; `_` in parameter/lambda positions (capture model: @variable.parameter.builtin
; is "special parameters (e.g. `_`)") — BEFORE the wildcard rule so match
; wildcards win the more semantic @variable.builtin below.
"_" @variable.parameter.builtin

(var_binding_pattern) @variable
; this / super (java/rust precedent: @variable.builtin)
(this_super_expression) @variable.builtin
; The match wildcard `_` reads like this: an anonymous stand-in.
(wildcard_pattern) @variable.builtin

; ===== Modifiers =====

(modifiers) @keyword.modifier

; ===== Members =====

; General member reads/writes: obj.field, this.area. Placed BEFORE the call
; refinements so callee positions win by "last capture wins".
(field_access (identifier) @variable.member)

; ===== Parameters =====

(parameter para_name: (identifier) @variable.parameter)
(named_parameter para_name: (identifier) @variable.parameter)
(unnamed_member_param para_name: (identifier) @variable.parameter)
(lambda_parameter (var_binding_pattern) @variable.parameter)
(property_definition setter: (identifier) @variable.parameter)
(macro_parameter name: (identifier) @variable.parameter)

; ===== Calls =====
; The grammar has no call_expression node — a call is a postfix chain ending
; in call_suffix, and generic arguments are ALSO suffixes, so generic calls
; nest one level deeper. Cover the chain shapes so plain, generic and
; trailing-lambda callees color identically. Calls use @function.call /
; @function.method.call (the capture model separates them from definitions).

;   head:      call()  /  call<T>()  /  call<T>  /  f { ... }
(postfix_expression
    base: (postfix_expression (identifier) @function.call)
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression (identifier) @function.call)
    suffix: (type_arguments))

(postfix_expression
    base: (postfix_expression
            base: (postfix_expression (identifier) @function.call)
            suffix: (type_arguments))
    suffix: (call_suffix))

;   member:    a.b(x)  /  a.b<T>(x)  /  a.b<T>  /  a.b { ... }
(postfix_expression
    base: (postfix_expression
            suffix: (field_access (identifier) @function.method.call))
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression
            suffix: (field_access (identifier) @function.method.call))
    suffix: (type_arguments))

(postfix_expression
    base: (postfix_expression
            base: (postfix_expression
                    suffix: (field_access (identifier) @function.method.call))
            suffix: (type_arguments))
    suffix: (call_suffix))

;   scoped:    Foo::create(x)  /  Foo::create<T>(x)
(postfix_expression
    base: (postfix_expression
            suffix: (scope_resolution (identifier) @function.call))
    suffix: (call_suffix))

(postfix_expression
    base: (postfix_expression
            suffix: (scope_resolution (identifier) @function.call))
    suffix: (type_arguments))

;   trailing lambda:  list.map { x => x }  /  a.b { ... }
(postfix_expression
    (postfix_expression (identifier) @function.call)
    (lambda_expression))

(postfix_expression
    (postfix_expression
        (postfix_expression
            (field_access (identifier) @function.method.call)))
    (lambda_expression))

; ===== Names =====

; NOTE: no global (identifier) capture. The grammar wraps type references in
; type_name/_name with identifier children, and a child capture always paints
; over the parent's @type in nvim regardless of pattern order — a global
; @variable would decolor `Foo<Bar>`/`HashMap<T, U>`. Contextual keywords used
; as identifiers (open/main/handle) therefore render uncolored, like any
; other expression identifier. Type positions are captured explicitly below.

(class_name) @type
(struct_name) @type
(interface_name) @type
(enum_name) @type
; kotlin: typealias name → @type.definition
(type_alias_name) @type.definition
(func_name) @function
; main is the entry function's name (the token only occurs in main_definition;
; expression-position mains are bridge-aliased identifier nodes).
(main_definition "main" @function)
(macro_name) @function.macro
(property_name) @variable.member

; Constructor definitions and construction calls (kotlin: `constructor`
; @constructor; c_sharp/go: object creation → @constructor).
"init" @constructor
; The primary_init's name is a class_name node — color it like the call it
; is (let x = C(...)), not like the type position.
(primary_init (class_name) @constructor)

; ===== Types =====

; Capture only the type child so delimiters (: ? -> parens) keep operator color.
(return_type type: (_) @type)

; All user-written type references: parameters, return types, variable
; annotations, super/extend lists, casts, generic arguments. Fielded
; captures avoid painting structural delimiters as type.
(type_name) @type
; The identifier child of a type_name refines the general @variable capture
; (later patterns win over overlapping ranges).
(type_name (identifier) @type)
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

; Hard-keyword primitive types (reserved words in Cangjie). These also color
; conversions like Int64(x) — the type node itself is the matched child.
; NOTE: soft builtin type names (String, Array, ...) are ordinary identifiers;
; see the #any-of? rule below.
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

; Soft built-in types, matched by name (java/rust/kotlin precedent: builtins
; by identifier match). Core cangjie/std library types users expect to read
; as builtins; anything else falls through to plain @type.
((type_name (identifier) @type.builtin)
  (#any-of? @type.builtin
    "String" "StringBuilder"
    "Array" "VArray" "ArrayList" "HashMap" "HashSet" "Range"
    "Option" "Exception" "Error" "CPointer" "CString"
    "Future" "Thread"))

; Enum case names: Red | Green — definitions and pattern references alike.
(enum_body enum_constant: (identifier) @constant)
; enum_constructor is an aliased identifier node itself, not a parent.
(enum_constructor) @constant

; Class/struct/interface members are syntactically visible (declaration_body
; parents), so they color as members, not plain variables — capture the same
; innermost var_binding_pattern node as the general rule above so the later
; pattern wins the range; placed before the const rule so member consts still
; win @constant below.
(declaration_body
    (variable_declaration
        name: (variable_name (var_binding_pattern) @variable.member)))

; const declarations (rust: const_item name → @constant)
(variable_declaration
    "const"
    name: (variable_name (var_binding_pattern) @constant))

; Prop accessor keywords: get()/set()
(getter_keyword) @keyword
(setter_keyword) @keyword

; The '...' member-param wildcard (java: "..." → @punctuation.delimiter)
(ellipsis_parameter) @punctuation.delimiter

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

; ===== Attributes & macros =====
; Cangjie cannot semantically separate annotations from macro calls — both
; are `@Name(...)` macro heads — so they color as one family (julia precedent:
; the sigil joins the macro color). The input/attribute body delimiters join
; the family too, so the whole head @Name(...) reads as one macro unit; only
; the raw argument stream inside stays verbatim.

(macro_call_sigil) @function.macro
(macro_input_open) @function.macro
(macro_input_close) @function.macro
(macro_attr_open) @function.macro
(macro_attr_close) @function.macro

; ===== Keywords =====

; Type-declaration keywords (kotlin: class/object/interface → @keyword.type)
[
    "struct"
    "enum"
    "class"
    "interface"
    "type"
] @keyword.type

"func" @keyword.function
"return" @keyword.return

; Loops (kotlin: for/do/while/continue/break → @keyword.repeat)
[
    "for"
    "do"
    "while"
    "continue"
    "break"
] @keyword.repeat

; Exceptions (kotlin: try/catch/throw/finally → @keyword.exception); the
; effect-handler family joins it — perform/resume are resumable control
; transfer in the try/handle family.
[
    "try"
    "catch"
    "finally"
    "throw"
    "handle"
    "with"
    "throwing"
] @keyword.exception

; Conditionals (kotlin: if/else/when → @keyword.conditional; java: case)
[
    "if"
    "else"
    "match"
    "case"
] @keyword.conditional

; English-word operators (capture model: @keyword.operator)
[
    "is"
    "as"
    "in"
    "!in"
] @keyword.operator

"import" @keyword.import
"spawn" @keyword.coroutine

; Bindings and everything without a closer family
[
    "let"
    "var"
    "const"
    "where"
    "extend"
    "macro"
    "static"
    "operator"
    "foreign"
    "inout"
    "prop"
    "mut"
    "unsafe"
    "synchronized"
    ; conditional compilation / macro DSL
    "features"
] @keyword

; The 11 soft modifier words (public/open/...) have keyword tokens too
; (reserved('modifier') set, active only in modifier-run states) and are
; colored via the (modifiers) node above. The bridge aliases turn the same
; tokens into named identifier nodes at expression positions, which the
; literal patterns above do NOT match (they match anonymous nodes only).

; ===== Operators =====

[
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
    "&&="
    "||="
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
    "|>"
    "~>"
    "~"
] @operator

; ++/-- are a single named token (not anonymous "+"-style literals)
(inc_or_dec) @operator

; ===== Punctuation =====

[
    "("
    ")"
    "["
    "]"
    "{"
    "}"
] @punctuation.bracket

; java/kotlin: dot, comma, semicolon, colon → @punctuation.delimiter
[
    "."
    ","
    ";"
    ":"
    "::"
] @punctuation.delimiter

; Generic angle brackets read as delimiters, not comparison operators
; (kotlin: type_arguments/type_parameters "<"/">" → @punctuation.delimiter).
; After the operator list so it wins by order.
(type_arguments
    [
        "<"
        ">"
    ] @punctuation.delimiter)

(type_parameters
    [
        "<"
        ">"
    ] @punctuation.delimiter)

; Not operators: the enum-constructor separator and the import wildcard
; (cjls leaves both unmarked; zed's highlights.zed.scm does the same).
(enum_body "|" @punctuation.delimiter)
(package_full "*" @punctuation.special)

; ===== Macro quote(...) DSL =====
; Refinements over the punctuation above: delimiters inside quote(...) are
; verbatim template text, not code punctuation.

(quote_raw_token) @markup.raw

; Macro calls inside quotes stay raw tokens (the compiler keeps them inert
; until the token sequence is evaluated); the scanner splits the @Name head
; into its own quote_macro_head node so it can stand out. Arguments stay raw.
(quote_macro_head) @function.macro

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

; ===== Effect handler DSL =====

(perform_keyword) @keyword.exception
(resume_keyword) @keyword.exception
(quote_keyword) @keyword
(quote_close) @keyword
