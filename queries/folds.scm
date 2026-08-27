; Fold ranges for Cangjie
;
; Captures mark the node whose span should be collapsible. Convention
; (nvim-treesitter): fold the smallest node that spans the whole construct,
; including its header — never fold single-line constructs (tree-sitter
; collapses zero-gain ranges anyway, but keeping the list tight avoids
; fold-marker churn while typing).

; Type and extension bodies
(class_definition body: (declaration_body) @fold)
(struct_definition body: (declaration_body) @fold)
(interface_definition body: (declaration_body) @fold)
(enum_definition body: (enum_body) @fold)
(extend_definition body: (declaration_body) @fold)
(foreign_declaration body: (declaration_body) @fold)

; Primary constructors (`init C(...) { ... }`)
(primary_init) @fold

; Blocks
(block) @fold

; Control flow
(if_expression) @fold
(while_expression) @fold
(do_while_expression) @fold
(for_in_expression) @fold
(match_expression) @fold
(try_expression) @fold

; Lambdas and permissive blocks
(lambda_expression) @fold
(lambda_expression) @fold
(synchronized_expression) @fold
(unsafe_expression) @fold

; Properties (`prop Name: T { get() { ... } }`)
(property_definition) @fold

; Macro and quote bodies (raw token streams)
(macro_expression) @fold
(quote_expression) @fold
