/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: binaryexpr009.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_binaryexpr_007() {
    let res = parseFile("./binaryexpr009.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("10<<1<<1"))
    @Assert(sourcefile.name, "binaryexpr009.cj")
    @Assert(sourcefile.path.contains("binaryexpr009.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var binaryexpr = (maindecl.body.nodes[0] as BinaryExpr).getOrThrow()
    //toString()
    @Assert(binaryexpr.toString(), "10<<1<<1")

    //lhs
    @Assert(binaryexpr.lhs.toString(),"10<<1")

    //rhs
    @Assert(binaryexpr.rhs.toString(),"1")

    //opKind
    match (binaryexpr.opKind) {
        case BinaryOpKind.LShift => ()
        case _ => @Assert(false)
    }
}
}