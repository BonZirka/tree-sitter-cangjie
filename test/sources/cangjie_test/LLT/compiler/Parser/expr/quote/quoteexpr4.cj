// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f
internal import std.ast.*

main(): Int64 {
    let a: Tokens = quote()  
    let b: Tokens = quote(()
    let c: Tokens = quote())

    let d: Tokens = quote(((((()
    let e: Tokens = quote())))))))
    return 0
}

/* SCAN
error: unmatched delimiter: ')'
  ==> quoteexpr4.cj:10:33:
   | 
10 |     let e: Tokens = quote())))))))
   |                                 ^ unmatched delimiter
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
