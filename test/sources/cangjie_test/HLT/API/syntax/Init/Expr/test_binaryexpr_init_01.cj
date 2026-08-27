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
    lhs in [
        LitConstExpr(LitConstKind.IntergerLiteral, "123"),
        ParenExpr(AsExpr(LitConstExpr(LitConstKind.IntergerLiteral, "123"), AtomicType(Int64Type)))
    ],
    opKind in [
        BinaryOpKind.Add,
        BinaryOpKind.And,
        BinaryOpKind.BitAnd,
        BinaryOpKind.BitOr,
        BinaryOpKind.BitXor,
        BinaryOpKind.Coalescing,
        BinaryOpKind.Composition,
        BinaryOpKind.Div,
        BinaryOpKind.Equal,
        BinaryOpKind.Exp,
        BinaryOpKind.Ge,
        BinaryOpKind.Gt,
        BinaryOpKind.Le,
        BinaryOpKind.LShift,
        BinaryOpKind.Lt,
        BinaryOpKind.Mod,
        BinaryOpKind.Mul,
        BinaryOpKind.NotEq,
        BinaryOpKind.Or,
        BinaryOpKind.Pipeline,
        BinaryOpKind.RShift,
        BinaryOpKind.Sub
    ],
    rhs in [
        LitConstExpr(LitConstKind.IntergerLiteral, "123"),
        (parseText("if (a) {b} else {c}").node.getOrThrow() as Expr).getOrThrow()
    ],
    comments in [
        [], 
//         [Comment(##"/* 
// a 
// */"##)],
//         [Comment("//1"), Comment("// 2")]
    ]
]
func test_BinaryExpr_Init_01(lhs: Expr, opKind: BinaryOpKind, rhs: Expr, comments: Array<Comment>): Unit {
    let BinaryExpr = BinaryExpr(lhs, opKind, rhs, comments: comments)
    println(BinaryExpr.toString())
    println()
}
}