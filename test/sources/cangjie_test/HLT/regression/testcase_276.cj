/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


enum TimeUnit{
Month |
Year(Int64)|
Day(Int64, Int64)
}

main(){
var a1 = Year(1)
var b = match (a1) {
  case TimeUnit.Month => 3
  case TimeUnit.Year(1) => 4
  case TimeUnit.Year(_) => 5
  case TimeUnit.Day(_, _) => 6
  }

  var a2 = Day(1, 2)
var b2 = match (a2) {
  case TimeUnit.Month => 3
  case TimeUnit.Year(1) => 4
  case TimeUnit.Year(_t64, Int64)
}

main(){
var a1 = Year(1)
var b = match (a1) {
  case TimeUnit.Month => 3
  case TimeUnit.Year(1) => 4
  case TimeUnit.Year(_) => 5
  case TimeUnit.Day(_, _) => 6
  }

  var a2 = Day(1, 2)
var b2 = match (a2) {
  case TimeUnit.Month => 3
  case TimeUnit.Year(1) => 4
  case TimeUnit.Year(_) => 5
  case TimeUnit.Day(_, _) => 6
  }
  r) => 5
  case TimeUnit.Day(_, _) => 6
  }
  return b + b2 - 10
}
// ASSERT: scan parse_expected_pattern
// ASSERT: scan parse_unexpected_declaration_in_scope
// ASSERT: scan parse_unmatched_right_delimiter
// ASSERT: scan parse_expected_expr_or_decl_in


