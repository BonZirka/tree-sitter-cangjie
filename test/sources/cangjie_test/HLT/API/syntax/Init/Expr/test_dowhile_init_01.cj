/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase[
    body in [
        Block(),
        Block([(parseText("return 1").node.getOrThrow() as Expr).getOrThrow()]),
        Block([(parseText("a + 1").node.getOrThrow() as Expr).getOrThrow(), (parseText("return 1").node.getOrThrow() as Expr).getOrThrow()])
    ],
    condition in [
        (parseText("!a").node.getOrThrow() as Expr).getOrThrow()
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_DoWhileExpr_Init_01(body: Block, condition: Expr, comments: Array<Comment>): Unit {
    let DoWhileExpr = DoWhileExpr(body, condition, comments: comments)
    println(DoWhileExpr.toString())
    println()
}
}