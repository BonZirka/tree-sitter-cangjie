// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    let a: Int32 = quote(4 + 5 + 6)
    return 0
}

/* SCAN
error: mismatched types
 ==> quoteexpr1.cj:6:20:
  | 
6 |     let a: Int32 = quote(4 + 5 + 6)
  |                    ^^^^^^^^^^^^^^^^ expected 'Int32', found 'Class-Tokens'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
