/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase[
    expr in [
        (parseText("quote(aaa)").node.getOrThrow() as QuoteExpr).getOrThrow(),
    ],
    comments in [
        [], 
//         [Comment(##"/* 
//     ccc
// */"##)]
    ]
]
func test_QuoteInterpolationExpr_Init_01(expr: Expr, comments: Array<Comment>): Unit {
    let QuoteInterpolationExpr = QuoteInterpolationExpr(expr, comments: comments)
    println(QuoteInterpolationExpr.toString())
    println()
}
}