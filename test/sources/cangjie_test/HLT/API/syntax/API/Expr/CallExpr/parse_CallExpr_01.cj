/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: CallExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_CallExpr_01() {
    let res = parseFile("./CallExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    foo<Int64>()
    foo<Int64>((a, b))
    foo<Int64>(x, b: y)
    println(length(a.b))
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: CallExpr = (mainDecl.body.nodes[0] as CallExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"foo<Int64>()"##)
    @Expect(expr_1.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_1.arguments.toString(), "[]")

    var expr_2: CallExpr = (mainDecl.body.nodes[1] as CallExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"foo<Int64>((a, b))"##)
    @Expect(expr_2.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_2.arguments.toString(), "[(a, b)]")

    var expr_3: CallExpr = (mainDecl.body.nodes[2] as CallExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"foo<Int64>(x, b: y)"##)
    @Expect(expr_3.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_3.arguments.toString(), "[x, b: y]")

    var expr_4: CallExpr = (mainDecl.body.nodes[3] as CallExpr).getOrThrow()
    @Expect(expr_4.toString(), ##"println(length(a.b))"##)
    @Expect(expr_4.callee.toString(), ##"println"##)
    @Expect(expr_4.arguments.toString(), "[length(a.b)]")

    var pos = expr_1.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 15i32, 10i32, 16i32])
    pos = expr_1.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 16i32, 10i32, 17i32])
}
}