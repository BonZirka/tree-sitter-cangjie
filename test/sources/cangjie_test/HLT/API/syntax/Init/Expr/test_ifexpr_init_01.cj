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
    condition in [
        (parseText("if (a && b || c) { a1 + 1 } else { b1 }").node.getOrThrow() as IfExpr).getOrThrow().condition
    ],
    elseBlock in [
        None,
        Block([(parseText("arr").node.getOrThrow() as Expr).getOrThrow()])
    ],
    elseIf in [
        None,
        parseText("if (true) { a1 + 1 }").node.getOrThrow() as IfExpr
    ],
    ifBlock in [
        Block(),
        Block([(parseText("100").node.getOrThrow() as Expr).getOrThrow()])
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_IfExpr_Init_01(condition: DisjunctionCondition, elseBlock: Option<Block>, elseIf: Option<IfExpr>, ifBlock: Block, comments: Array<Comment>): Unit {
    let IfExpr = IfExpr(condition, elseBlock, elseIf, ifBlock, comments: comments)
    println(IfExpr.toString())
    println()
}
}