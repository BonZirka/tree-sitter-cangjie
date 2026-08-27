(class_definition
  (declaration_body) @indent.begin
) 

(struct_definition
  (declaration_body) @indent.begin
)

(interface_definition
  (declaration_body) @indent.begin
)

(init) @indent.begin

; NOTE: whole-node capture — a `(static_init (block))` child pattern trips an
; assertion in the tree-sitter 0.25 query compiler (ts_query__analyze_patterns).
(static_init) @indent.begin

(function_definition
  (block) @indent.begin
)

(operator_function_definition
  (block) @indent.begin
)

(handle_clause
  (block) @indent.begin
)

(catch_clause
  (block) @indent.begin
)

(call_suffix) @indent.begin

 (array_literal) @indent.begin

(lambda_expression) @indent.begin

(trailing_lambda_expression) @indent.begin

(extend_definition
  (extend_body) @indent.begin
)

(primary_init) @indent.begin

(enum_definition
  (enum_body) @indent.begin
)

(if_expression) @indent.begin

(while_expression
  (block) @indent.begin
)

(do_while_expression
  (block) @indent.begin
)

(try_expression
  try_body: (block) @indent.begin
)

(try_expression
  finally_body: (block) @indent.begin
)

(unsafe_expression
  (block) @indent.begin
)

(synchronized_expression
  (block) @indent.begin
)

(match_expression
  (match_case) @indent.begin
)

(match_expression
  (match_case_body) @indent.begin
)

(for_in_expression) @indent.begin

[
  "]"
  ")"
  "}"
] @indent.end @indent.branch

[
   (line_comment)
   (block_comment)
] @indent.auto
