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
    callee in [
        (parseText("foo").node.getOrThrow() as Expr).getOrThrow()
    ],
    arguments in [
        [],
    ],
    trailingLambdaExpr in [
        (parseText("{ => 100}").node.getOrThrow() as Lambda).getOrThrow(),
    ],
    comments in [
        [], 
//         [Comment(##"/* 
//     ccc
// */"##)]
    ]
]
func test_TrailingClosureExpr_Init_01(callee: Expr, arguments: Array<Argument>, trailingLambdaExpr: Lambda, comments: Array<Comment>): Unit {
    let TrailingClosureExpr = TrailingClosureExpr(callee, arguments, trailingLambdaExpr, comments: comments)
    println(TrailingClosureExpr.toString())
    println()
}
}