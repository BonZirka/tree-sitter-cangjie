; Classes and similar constructs
[
  (class_definition (class_body) @class.inside)
  (struct_definition (struct_body) @class.inside)
  (interface_definition (interface_body) @class.inside)
  (enum_definition (enum_body) @class.inside)
  (extend_definition (extend_body) @class.inside)
] @class.around

; Functions
[
  (function_definition (block) @function.inside)
  (operator_function_definition (block) @function.inside)
  (main_definition (block) @function.inside)
  (property_definition) ; TODO
  (macro_definition (block) @function.inside)
  (init (block) @function.inside)
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
  (primary_init_param_list)
] @parameter.around
