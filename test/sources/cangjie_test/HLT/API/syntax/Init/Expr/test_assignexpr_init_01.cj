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
    assignOpKind in [
        AddAssign,
        AndAssign,
        Assign,
        BitAndAssign,
        BitOrAssign,
        BitXorAssign,
        DivAssign,
        ExpAssign,
        LShiftAssign,
        ModAssign,
        MulAssign,
        OrAssign,
        RShiftAssign,
        SubAssign
    ],
    lhs in [
        LitConstExpr(LitConstKind.IntergerLiteral, "123"),
        ParenExpr(AsExpr(LitConstExpr(LitConstKind.IntergerLiteral, "123"), AtomicType(Int64Type)))
    ],
    rhs in [
        LitConstExpr(LitConstKind.IntergerLiteral, "123"),
        (parseText("if (a) {b} else {c}").node.getOrThrow() as Expr).getOrThrow()
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_AssignExpr_Init_01(assignOpKind: AssignOpKind, lhs: Expr, rhs: Expr, comments: Array<Comment>): Unit {
    let AssignExpr = AssignExpr(assignOpKind, lhs, rhs, comments: comments)
    println(AssignExpr.toString())
    println()
}
}