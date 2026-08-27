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
    elements in [
        [],
        [LitConstExpr(LitConstKind.IntergerLiteral, "123"), LitConstExpr(LitConstKind.IntergerLiteral, "456")],
        [LitConstExpr(LitConstKind.IntergerLiteral, "123"), LitConstExpr(LitConstKind.BoolLiteral, "true")]
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_ArrayLiteral_Init_01(elements: Array<Expr>, comments: Array<Comment>): Unit {
    let ArrayLiteral = ArrayLiteral(elements, comments: comments)
    println(ArrayLiteral.toString())
    println()
}
}