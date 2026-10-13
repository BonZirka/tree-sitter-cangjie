; Classes and similar constructs
[
  (class_definition (declaration_body) @class.inside)
  (struct_definition (declaration_body) @class.inside)
  (interface_definition (declaration_body) @class.inside)
  (enum_definition (enum_body) @class.inside)
  (extend_definition (declaration_body) @class.inside)
] @class.around

; Functions
[
  (function_definition (block) @function.inside)
  (operator_function_definition (block) @function.inside)
  (main_definition (block) @function.inside)
  (macro_definition (block) @function.inside)
  (init (block) @function.inside)
] @function.around

; Property accessors: the get()/set() bodies are function bodies; the whole
; prop declaration stands in for function-around (no node spans just the
; accessor keyword through its block).
[
  (property_definition (block) @function.inside)
  (property_definition)
] @function.around

; Comments
[
  (line_comment)
  (block_comment)
] @comment.inside

[
  (line_comment)+
  (block_comment)+
] @comment.around

; Parameters
[
  (parameter)
  (named_parameter)
] @parameter.inside

[
  (type_parameter (identifier) @parameter.inside)
  (lambda_parameters (lambda_parameter) @parameter.inside)
  (parameter_list)
  (primary_init_parameter_list)
] @parameter.around
