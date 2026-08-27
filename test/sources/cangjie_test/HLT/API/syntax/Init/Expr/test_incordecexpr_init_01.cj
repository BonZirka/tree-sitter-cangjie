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
    kind in [
        IncOrDecOpKind.Decr,
        IncOrDecOpKind.Incr
    ],
    operand in [
        (parseText("foo.a").node.getOrThrow() as Expr).getOrThrow(),
        (parseText("arr[0]").node.getOrThrow() as Expr).getOrThrow()
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_IncOrDecExpr_Init_01(kind: IncOrDecOpKind, operand: Expr, comments: Array<Comment>): Unit {
    let IncOrDecExpr = IncOrDecExpr(kind, operand, comments: comments)
    println(IncOrDecExpr.toString())
    println()
}
}