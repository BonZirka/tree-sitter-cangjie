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
func test_ForInExpr_01() {
    let str = ##"for (i in 0..100 where i % 2 == 0) {
    count++
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: ForInExpr = (sourceNode as ForInExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"for (i in 0..100 where i % 2 == 0) {
    count++
}"##)
    @Assert(expr_1.body.toString().replace("\r",""), ##"{
    count++
}"##)
    @Assert(expr_1.expr.toString(), ##"0..100"##)
    @Assert(expr_1.expr is RangeExpr)
    @Assert(expr_1.pattern is VarPattern)
    @Assert(expr_1.patternGuard.isSome())
    @Assert(expr_1.patternGuard.getOrThrow().toString(), "i % 2 == 0")

    var pos = expr_1.getForKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 4i32])
    pos = expr_1.getInKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 8i32, 1i32, 10i32])
    pos = expr_1.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 5i32, 1i32, 6i32])
    pos = expr_1.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 34i32, 1i32, 35i32])
    pos = expr_1.getWhereKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 18i32, 1i32, 23i32])
}
}