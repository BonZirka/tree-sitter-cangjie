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
    srcVal in [
        LitConstExpr(LitConstKind.IntergerLiteral, "123"),
        ParenExpr(IsExpr(LitConstExpr(LitConstKind.IntergerLiteral, "123"), AtomicType(Int64Type)))
    ],
    targetTypeAnnotation in [
        AtomicType(Int64Type)
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_IsExpr_Init_01(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments: Array<Comment>): Unit {
    let IsExpr = IsExpr(srcVal, targetTypeAnnotation, comments: comments)
    println(IsExpr.toString())
    println()
}
}