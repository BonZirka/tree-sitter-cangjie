// EXEC: %frontendCompiler %typecheck %cmp_opt %f -o %output 2>&1 | compare %f

macro package view

internal import std.ast.*

public macro test(input: Tokens): Tokens {
    let a: Tokens = quote()
    let b: Tokens = quote(()
    let c: Tokens = quote())
    // ABOVE IS GOOD
}

/* SCAN
error: mismatched types
  ==> test_macro_quote4.cj:9:5:
   | 
9  |       let b: Tokens = quote(()
   |  _____^
10 | |     let c: Tokens = quote())
   | |____________________________^ expected 'Class-Tokens', found 'Unit'
   | 
   # note: definitions and declarations are always of type 'Unit'

1 error generated, 1 error printed.
*/
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
