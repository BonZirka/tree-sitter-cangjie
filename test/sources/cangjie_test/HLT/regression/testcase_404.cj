/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 



class cls{
  static var a: Int64
  static init(){
    var b: Int64 = 1
    aXEC: %compiler %cmp_opt %n.cj -o %output

class cls{
  static var a: Int64
  static init(){
    var b: Int64 = 1
    a = b
  }
}

main(): Int64 {
  if(cls.a == 1){
    return 0
  }
  return 1
} = b
  }
}

main(): Int64 {
  if(cls.a == 1){
    return 0
  }
  return 1
}
// ASSERT: scan parse_expected_operator_or_end
// ASSERT: scan parse_unexpected_declaration_in_scope
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_expr_or_decl_in


