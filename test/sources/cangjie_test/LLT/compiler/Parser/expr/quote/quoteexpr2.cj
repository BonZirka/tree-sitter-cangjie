// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

func foo(input: Tokens): Tokens {
    var expr = parseExpr(input)
    let a = quote(4 + 5 + 6)
    return a + quote($expr)
}

func bar(input: Int32): Int32 {
    return 0
}

main(): Int64 {
    var ret = bar(foo(quote( 1 + 2 + 3)))
    return 0
}

/* SCAN
error: mismatched types
  ==> quoteexpr2.cj:16:19:
   | 
16 |     var ret = bar(foo(quote( 1 + 2 + 3)))
   |                   ^^^^^^^^^^^^^^^^^^^^^^ expected 'Int32', found 'Class-Tokens'
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
