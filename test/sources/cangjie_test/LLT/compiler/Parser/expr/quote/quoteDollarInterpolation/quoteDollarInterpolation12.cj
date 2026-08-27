// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    quote($)
    quote(\$``)
    quote($())
    quote($))
    0
}

/* SCAN
error: expected identifier, found '`'
 ==> quoteDollarInterpolation12.cj:7:14:
  | 
7 |     quote(\$``)
  |              ^ expected identifier
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
