// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

func call():Unit{
}

main(): Int64 {
    let c2 = quote(\ 1 + 2)
    let c = quote(\expr)
    let c1 = quote(\parseExpr(tokens))
    0
}

/* SCAN
error: unknown start of token: \
 ==> quoteDollarInterpolation5.cj:9:20:
  | 
9 |     let c2 = quote(\ 1 + 2)
  |                    ^ unknown start of token: \
  | 

error: unknown start of token: \
  ==> quoteDollarInterpolation5.cj:10:19:
   | 
10 |     let c = quote(\expr)
   |                   ^ unknown start of token: \
   | 

error: unknown start of token: \
  ==> quoteDollarInterpolation5.cj:11:20:
   | 
11 |     let c1 = quote(\parseExpr(tokens))
   |                    ^ unknown start of token: \
   | 

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
