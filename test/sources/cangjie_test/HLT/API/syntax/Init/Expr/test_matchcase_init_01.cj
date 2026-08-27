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
    patterns in [
        // [],
        [VarPattern("x"), VarPattern("y")]
    ],
    patternGuardCond in [
        None,
        (parseText("true").node.getOrThrow() as Expr).getOrThrow()
    ],
    caseCond in [
        // None,
        (parseText("a + 1").node.getOrThrow() as Expr).getOrThrow()
    ],
    body in [
        [],
        [parseText("()").node.getOrThrow()]
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_MatchCase_Init_01(patterns: Array<Pattern>, patternGuardCond: Option<Expr>, caseCond: Option<Expr>, body: Array<SyntaxTreeNode>, comments: Array<Comment>): Unit {
    let MatchCase = MatchCase(patterns, patternGuardCond, caseCond, body, comments: comments)
    println(MatchCase.toString())
    println()
}
}