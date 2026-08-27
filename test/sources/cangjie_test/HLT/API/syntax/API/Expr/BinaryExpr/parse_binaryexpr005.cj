/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: binaryexpr005.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_binaryexpr_005() {
    let res = parseFile("./binaryexpr005.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("a-b*(a/b)"))
    @Assert(sourcefile.name, "binaryexpr005.cj")
    @Assert(sourcefile.path.contains("binaryexpr005.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var binaryexpr = (maindecl.body.nodes[0] as BinaryExpr).getOrThrow()
    //toString()
    @Assert(binaryexpr.toString(), "a-b*(a/b)")

    //lhs
    @Assert(binaryexpr.lhs.toString(),"a")

    //rhs
    @Assert(binaryexpr.rhs.toString(),"b*(a/b)")

    //opKind
    match (binaryexpr.opKind) {
        case BinaryOpKind.Sub => ()
        case _ => @Assert(false)
    }
}
}