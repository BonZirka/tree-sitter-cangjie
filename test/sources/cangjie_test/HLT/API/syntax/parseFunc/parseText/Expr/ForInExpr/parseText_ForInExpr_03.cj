/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ForInExpr_03() {
    let str = ##"for (_ in 0..=-100:2) {
    count++
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: ForInExpr = (sourceNode as ForInExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"for (_ in 0..=-100:2) {
    count++
}"##)
    @Assert(expr_1.body.toString().replace("\r",""), ##"{
    count++
}"##)
    @Assert(expr_1.expr.toString(), ##"0..=-100:2"##)
    @Assert(expr_1.pattern is WildcardPattern)
    @Assert(expr_1.patternGuard.isNone())
}
}