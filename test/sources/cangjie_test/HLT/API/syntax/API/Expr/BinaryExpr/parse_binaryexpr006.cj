/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: binaryexpr006.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_binaryexpr_006() {
    let res = parseFile("./binaryexpr006.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("2**UInt64(3**2)"))
    @Assert(sourcefile.name, "binaryexpr006.cj")
    @Assert(sourcefile.path.contains("binaryexpr006.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var binaryexpr = (maindecl.body.nodes[0] as BinaryExpr).getOrThrow()
    //toString()
    @Assert(binaryexpr.toString(), "2**UInt64(3**2)")

    //lhs
    @Assert(binaryexpr.lhs.toString(),"2")

    //rhs
    @Assert(binaryexpr.rhs.toString(),"UInt64(3**2)")

    //opKind
    match (binaryexpr.opKind) {
        case BinaryOpKind.Exp => ()
        case _ => @Assert(false)
    }
}
}