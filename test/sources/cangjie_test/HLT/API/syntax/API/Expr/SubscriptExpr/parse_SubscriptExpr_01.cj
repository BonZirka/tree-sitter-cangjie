/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: SubscriptExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SubscriptExpr_01() {
    let res = parseFile("./SubscriptExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    a[0]
    a.b[a]
    a.b.c[a..b:2]
    a?.b[a..b]
    a[0][a..=b]
    a[0][0][0]
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1 = (maindecl.body.nodes[0] as SubscriptExpr).getOrThrow()
    @Assert(expr_1.base.toString(), "a")
    @Assert(expr_1.indexs.toString(), "[0]")

    var expr_2 = (maindecl.body.nodes[1] as SubscriptExpr).getOrThrow()
    @Assert(expr_2.base.toString(), "a.b")
    @Assert(expr_2.indexs.toString(), "[a]")

    var expr_3 = (maindecl.body.nodes[2] as SubscriptExpr).getOrThrow()
    @Assert(expr_3.base.toString(), "a.b.c")
    @Assert(expr_3.indexs.toString(), "[a..b:2]")

    var expr_4 = (maindecl.body.nodes[3] as SubscriptExpr).getOrThrow()
    @Assert(expr_4.base.toString(), "a?.b")
    @Assert(expr_4.indexs.toString(), "[a..b]")

    var expr_5 = (maindecl.body.nodes[4] as SubscriptExpr).getOrThrow()
    @Assert(expr_5.base.toString(), "a[0]")
    @Assert(expr_5.indexs.toString(), "[a..=b]")

    var expr_6 = (maindecl.body.nodes[5] as SubscriptExpr).getOrThrow()
    @Assert(expr_6.base.toString(), "a[0][0]")
    @Assert(expr_6.base is SubscriptExpr)
    @Assert(expr_6.indexs.toString(), "[0]")

    @Assert(expr_1.getCommasPos().size == 0, true)
    var pos = expr_1.getLSquarePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 6i32, 10i32, 7i32])
    pos = expr_1.getRSquarePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 8i32, 10i32, 9i32])
}
}