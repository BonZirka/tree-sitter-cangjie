/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ForInExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ForInExpr_01() {
    let res = parseFile("./ForInExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    for (i in 0..100 where i % 2 == 0) {
        count++
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: ForInExpr = (mainDecl.body.nodes[0] as ForInExpr).getOrThrow()
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
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 8i32])
    pos = expr_1.getInKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 12i32, 10i32, 14i32])
    pos = expr_1.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 9i32, 10i32, 10i32])
    pos = expr_1.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 38i32, 10i32, 39i32])
    pos = expr_1.getWhereKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 22i32, 10i32, 27i32])
}
}