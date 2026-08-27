/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ThrowExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ThrowExpr_01() {
    let res = parseFile("./ThrowExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    throw Exception()
    throw IOException("")
    throw IOException("hello, cangjie")
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: ThrowExpr = (mainDecl.body.nodes[0] as ThrowExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"throw Exception()"##)
    @Assert(expr_1.throwVal.toString(), ##"Exception()"##)

    var expr_2: ThrowExpr = (mainDecl.body.nodes[1] as ThrowExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"throw IOException("")"##)
    @Assert(expr_2.throwVal.toString(), ##"IOException("")"##)

    var expr_3: ThrowExpr = (mainDecl.body.nodes[2] as ThrowExpr).getOrThrow()
    @Assert(expr_3.toString(), ##"throw IOException("hello, cangjie")"##)
    @Assert(expr_3.throwVal.toString(), ##"IOException("hello, cangjie")"##)

    var pos = expr_1.getThrowKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 10i32])
}
}