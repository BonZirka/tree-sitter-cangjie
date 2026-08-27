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
    expr in [
        (parseText("arr").node.getOrThrow() as Expr).getOrThrow()
    ],
    pattern in [
        VarPattern("i")
    ],
    patternGuard in [
        None,
        (parseText("a.b").node.getOrThrow() as Expr).getOrThrow()
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_ForInExpr_Init_01(body: Block, expr: Expr, pattern: Pattern, patternGuard: Option<Expr>, comments: Array<Comment>): Unit {
    let ForInExpr = ForInExpr(body, expr, pattern, patternGuard, comments: comments)
    println(ForInExpr.toString())
    println()
}
}