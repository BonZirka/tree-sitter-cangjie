// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    quote($(var a: Int32 = 3))
    0
}

/* SCAN
error: invalid expression after the operator '$'
 ==> quoteDollarInterpolation15.cj:6:11:
  | 
6 |     quote($(var a: Int32 = 3))
  |           ^ 
  | 

error: unclosed delimiter: '('
 ==> quoteDollarInterpolation15.cj:6:13:
  | 
6 |     quote($(var a: Int32 = 3))
  |           ~ ^ expected ')' here
  |           |
  |           to match this opening '('
  | 

error: expected expression after '(', found keyword 'var'
 ==> quoteDollarInterpolation15.cj:6:13:
  | 
6 |     quote($(var a: Int32 = 3))
  |             ^^^ expected expression here
  | 

error: unmatched delimiter: ')'
 ==> quoteDollarInterpolation15.cj:6:30:
  | 
6 |     quote($(var a: Int32 = 3))
  |                              ^ unmatched delimiter
  | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
