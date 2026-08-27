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
    @TestCase
func test_IfExpr_04() {
    let _quote = quote(if ((true || true) && let a <- 1) {})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: IfExpr = (sourceNode as IfExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"if((true || true) && let a <- 1) { }"##)
    @Assert(expr_1.ifBlock.toString(), ##"{ }"##)
    @Assert(expr_1.condition.toString(), ##"(true || true) && let a <- 1"##)
    @Assert(expr_1.elseBlock.isNone())
    @Assert(expr_1.elseIf.isNone())
}
}