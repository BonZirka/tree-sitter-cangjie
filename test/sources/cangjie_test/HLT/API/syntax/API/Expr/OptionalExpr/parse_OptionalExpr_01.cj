/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: OptionalExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_OptionalExpr_01() {
    let res = parseFile("./OptionalExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    a?.b
    a?(b)
    a()?[b]
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: MemberAccess = (mainDecl.body.nodes[0] as MemberAccess).getOrThrow()
    @Expect(expr_1.toTokens().toString(), ##"a?.b"##)
    @Expect(expr_1.base is OptionalExpr)
    @Expect(expr_1.base.toString(), ##"a?"##)

    var expr_2: CallExpr = (mainDecl.body.nodes[1] as CallExpr).getOrThrow()
    @Expect(expr_2.callee is OptionalExpr)
    @Expect(expr_2.callee.toString(), ##"a?"##)

    var expr_3: SubscriptExpr = (mainDecl.body.nodes[2] as SubscriptExpr).getOrThrow()
    @Expect(expr_3.base is OptionalExpr)
    @Expect(expr_3.base.toString(), ##"a()?"##)
    var pos = (expr_3.base as OptionalExpr).getOrThrow().getQuestionPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 8i32, 12i32, 9i32])
}
}