// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f




internal import std.ast.*

main(): Int64 {
    let b: Tokens = quote('
                          ')
    return 0
}

/* SCAN
error: unterminated single-line string
 ==> quoteexpr14.cj:9:27:
  | 
9 |     let b: Tokens = quote('
  |                           ^^ unterminated single-line string
  | 
  # note: consider using multi-line string if you intended to include '\n' in string

error: unterminated single-line string
  ==> quoteexpr14.cj:10:27:
   | 
10 |                           ')
   |                           ^^^ unterminated single-line string
   | 
   # note: consider using multi-line string if you intended to include '\n' in string

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
