// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    quote($(\))
    0
}

/* SCAN
error: invalid expression after the operator '$'
 ==> quoteDollarInterpolation11.cj:6:11:
  | 
6 |     quote($(\))
  |           ^ 
  | 

error: expected expression after '(', found ''
 ==> quoteDollarInterpolation11.cj:6:13:
  | 
6 |     quote($(\))
  |             ^ expected expression here
  | 

error: unmatched delimiter: ')'
 ==> quoteDollarInterpolation11.cj:6:15:
  | 
6 |     quote($(\))
  |               ^ unmatched delimiter
  | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
