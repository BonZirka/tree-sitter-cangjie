/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: IfExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_IfExpr_01() {
    let res = parseFile("./IfExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    if (a) {} else if (a) {b} else {c}
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: IfExpr = (mainDecl.body.nodes[0] as IfExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"if (a) {} else if (a) {b} else {c}"##)
    @Assert(expr_1.ifBlock.toString(), ##"{}"##)
    @Assert(expr_1.condition.toString(), ##"a"##)
    @Assert(expr_1.elseBlock.isNone())
    @Assert(expr_1.elseIf.isSome())
    @Assert(expr_1.elseIf.getOrThrow().toString(), ##"if (a) {b} else {c}"##)

    var expr_2 = expr_1.elseIf.getOrThrow()
    @Assert(expr_2.ifBlock.toString(), ##"{b}"##)
    @Assert(expr_2.condition.toString(), ##"a"##)
    @Assert(expr_2.elseBlock.isSome())
    @Assert(expr_2.elseBlock.getOrThrow().toString(), "{c}")
    @Assert(expr_2.elseIf.isNone())

    var pos = expr_1.getCondLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 8i32, 10i32, 9i32])
    pos = expr_1.getCondRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 10i32, 10i32, 11i32])
    pos = expr_1.getIfKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 7i32])
    pos = expr_1.getElseKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 15i32, 10i32, 19i32])
}
}