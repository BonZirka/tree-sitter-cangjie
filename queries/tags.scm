; Definitions

(class_definition (class_name) @name) @definition.class
(struct_definition (struct_name) @name) @definition.struct
(interface_definition (interface_name) @name) @definition.interface
(enum_definition (enum_name) @name) @definition.enum
(enum_body enum_constant: (identifier) @name) @definition.class
(function_definition (func_name) @name) @definition.function
(operator_function_definition name: (_) @name) @definition.function
(primary_init (class_name) @name) @definition.constructor
(macro_definition (macro_name) @name) @definition.macro
(type_alias (type_alias_name) @name) @definition.type
(property_definition (property_name) @name) @definition.property

(variable_declaration
  (variable_name
    (var_binding_pattern)) @name) @definition.variable

(parameter para_name: (identifier) @name) @definition.parameter
(named_parameter para_name: (identifier) @name) @definition.parameter

; References

(postfix_expression
  base: (postfix_expression (identifier) @name)
  suffix: (call_suffix)) @reference.call

(postfix_expression
  base: (postfix_expression (identifier) @name)
  suffix: (type_arguments)) @reference.call

(user_type (identifier) @name) @reference.type
(extend_type (identifier) @name) @reference.type
(enum_constructor) @name @reference.class
