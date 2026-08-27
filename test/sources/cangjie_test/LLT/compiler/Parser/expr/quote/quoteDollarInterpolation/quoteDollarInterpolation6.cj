// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    quote($(`))
    quote($(``))
    quote($(()))
    quote($(/**/))
    0
}

/* SCAN
error: expected identifier, found ')'
 ==> quoteDollarInterpolation6.cj:6:14:
  | 
6 |     quote($(`))
  |              ^ expected identifier
  | 

error: expected identifier, found '`'
 ==> quoteDollarInterpolation6.cj:7:14:
  | 
7 |     quote($(``))
  |              ^ expected identifier
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
