/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: MemberAccess_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MemberAccess_01() {
    let res = parseFile("./MemberAccess_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    a.b1
    a().b1
    a(a).b1
    a(a:a).b1
    a<T>().b1
    a.b.b1
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1 = (maindecl.body.nodes[0] as MemberAccess).getOrThrow()
    @Assert(expr_1.base.toString(), "a")
    @Assert(expr_1.field.toString(), "b1")

    var expr_2 = (maindecl.body.nodes[1] as MemberAccess).getOrThrow()
    @Assert(expr_2.base.toString(), "a()")
    @Assert(expr_2.field.toString(), "b1")

    var expr_3 = (maindecl.body.nodes[2] as MemberAccess).getOrThrow()
    @Assert(expr_3.base.toString(), "a(a)")
    @Assert(expr_3.field.toString(), "b1")

    var expr_4 = (maindecl.body.nodes[3] as MemberAccess).getOrThrow()
    @Assert(expr_4.base.toString(), "a(a:a)")
    @Assert(expr_4.field.toString(), "b1")

    var expr_5 = (maindecl.body.nodes[4] as MemberAccess).getOrThrow()
    @Assert(expr_5.base.toString(), "a<T>()")
    @Assert(expr_5.field.toString(), "b1")

    var expr_6 = (maindecl.body.nodes[5] as MemberAccess).getOrThrow()
    @Assert(expr_6.base.toString(), "a.b")
    @Assert(expr_6.field.toString(), "b1")

    var pos = expr_1.getDotPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 6i32, 10i32, 7i32])
}
}