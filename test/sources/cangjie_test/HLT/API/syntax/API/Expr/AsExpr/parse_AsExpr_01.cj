/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: AsExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_AsExpr_01() {
    let res = parseFile("./AsExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    fun() as Option<Int64>
    a.b as ??T
    a as (C1, C2)
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: AsExpr = (mainDecl.body.nodes[0] as AsExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"fun() as Option<Int64>"##)
    @Expect(expr_1.toTokens().toString(), ##"fun() as Option < Int64 >"##)
    @Expect(expr_1.srcVal.toString(), ##"fun()"##)
    @Expect(expr_1.targetTypeAnnotation is CompositeType)
    @Expect(expr_1.targetTypeAnnotation.toString(), "Option<Int64>")

    var expr_2: AsExpr = (mainDecl.body.nodes[1] as AsExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"a.b as ??T"##)
    @Expect(expr_2.srcVal.toString(), ##"a.b"##)
    @Expect(expr_2.targetTypeAnnotation.toString(), "??T")
    @Expect(expr_2.targetTypeAnnotation is PrefixType)

    var expr_3: AsExpr = (mainDecl.body.nodes[2] as AsExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"a as (C1, C2)"##)
    @Expect(expr_3.srcVal.toString(), ##"a"##)
    @Expect(expr_3.targetTypeAnnotation.toString(), "(C1, C2)")
    @Expect(expr_3.targetTypeAnnotation is TupleType)

    var pos = expr_1.getAsKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 11i32, 10i32, 13i32])
}
}