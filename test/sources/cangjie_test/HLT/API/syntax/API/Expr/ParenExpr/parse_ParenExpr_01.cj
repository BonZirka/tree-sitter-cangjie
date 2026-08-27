/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ParenExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ParenExpr_01() {
    let res = parseFile("./ParenExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    (())
    (a_b)
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: ParenExpr = (mainDecl.body.nodes[0] as ParenExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"(())"##)
    @Expect(expr_1.subExpr.toString(), ##"()"##)

    var expr_2: ParenExpr = (mainDecl.body.nodes[1] as ParenExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"(a_b)"##)
    @Expect(expr_2.subExpr.toString(), ##"a_b"##)

    var pos = expr_2.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 5i32, 11i32, 6i32])
    pos = expr_2.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 9i32, 11i32, 10i32])
}
}