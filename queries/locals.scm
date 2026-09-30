; Locals query for Cangjie
;
; Scope / definition / reference model for symbol lookup and rename support.
; Scopes are containers that introduce bindings; definitions capture the
; *name node* of each binding; references capture identifier uses.

; ===== Scopes =====

(source_file) @local.scope
(block) @local.scope
(declaration_body) @local.scope
(function_definition) @local.scope
(operator_function_definition) @local.scope
(macro_definition) @local.scope
(primary_init) @local.scope
(class_definition) @local.scope
(struct_definition) @local.scope
(interface_definition) @local.scope
(enum_definition) @local.scope
(extend_definition) @local.scope

; Expressions that introduce bindings or nest scopes
(lambda_expression) @local.scope
(lambda_expression) @local.scope
(for_in_expression) @local.scope
(while_expression) @local.scope
(do_while_expression) @local.scope
(match_expression) @local.scope
(try_expression) @local.scope
(catch_clause) @local.scope

; ===== Definitions =====

; `let x = ...` / `var x: T` / `const x = ...`
(variable_declaration
  name: (variable_name) @local.definition)

; Parameters
(parameter
  para_name: (identifier) @local.definition)

(named_parameter
  para_name: (identifier) @local.definition)

(unnamed_member_param
  para_name: (identifier) @local.definition)

(macro_parameter
  name: (identifier) @local.definition)

; Lambda parameters: `{ x => ... }` / `{ x: Int64 => ... }`
(lambda_parameter
  (var_binding_pattern) @local.definition)

; `try (r = expr)` resources
(resource_specification
  (identifier) @local.definition)

; `for (x <- expr)` / `for (x in expr)` bindings
(for_in_expression
  (var_binding_pattern) @local.definition)

; `catch (e: T)` bindings
(catch_clause
  (catch_pattern
    (var_binding_pattern) @local.definition))

; Type parameters: `func f<T>()` / `class C<T> <: B<T>`
(type_parameter
  name: (identifier) @local.definition)

; ===== References =====

(identifier) @local.reference
