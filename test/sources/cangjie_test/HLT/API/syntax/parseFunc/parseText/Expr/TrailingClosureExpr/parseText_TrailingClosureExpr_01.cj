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
    @TestCase
func test_TrailingClosureExpr_01() {
    let str = ##"foo{ i => i * i }"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: TrailingClosureExpr = (sourceNode as TrailingClosureExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"foo{ i => i * i }"##)
    @Assert(expr_1.arguments.size, 0)
    @Assert(expr_1.callee.toString(), ##"foo"##)
    @Assert(expr_1.trailingLambdaExpr.toString(), ##"{ i => i * i }"##)
}
}