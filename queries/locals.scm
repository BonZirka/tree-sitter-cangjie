; Locals query for Cangjie
; Defines scope and reference patterns for variable tracking

; Scopes
(block) @local.scope
(function_definition) @local.scope
(class_definition) @local.scope
(interface_definition) @local.scope
(enum_definition) @local.scope
(lambda_expression) @local.scope
(for_in_expression) @local.scope
(while_expression) @local.scope
(match_expression) @local.scope

; Definitions
(variable_declaration
  name: (variable_name) @local.definition)

(parameter
  para_name: (identifier) @local.definition)

; References
(atomic_variable) @local.reference
