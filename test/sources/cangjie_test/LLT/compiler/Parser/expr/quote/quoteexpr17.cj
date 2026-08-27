// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f
internal import std.ast.*

main(): Int64 {
    let b: Tokens = quote
    (")
    return 0
}

/* SCAN
error: unterminated single-line string
  ==> quoteexpr17.cj:11:6:
   | 
11 |     (")
   |      ^^^ unterminated single-line string
   | 
   # note: consider using multi-line string if you intended to include '\n' in string

1 error generated, 1 error printed.
*/
