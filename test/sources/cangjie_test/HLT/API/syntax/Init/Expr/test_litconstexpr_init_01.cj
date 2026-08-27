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
    pairs in [
        (LitConstKind.BoolLiteral, "true"),
        (LitConstKind.BoolLiteral, "false"),
        (LitConstKind.FloatLiteral, "0.1f32"),
        (LitConstKind.IntergerLiteral, "-1"),
        (LitConstKind.UnitLiteral, "()")
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_LitConstExpr_Init_01(pairs: (LitConstKind, String), comments: Array<Comment>): Unit {
    let (kind, rawValue) = pairs
    let LitConstExpr = LitConstExpr(kind, rawValue, comments: comments)
    println(LitConstExpr.toString())
    println()
}
}