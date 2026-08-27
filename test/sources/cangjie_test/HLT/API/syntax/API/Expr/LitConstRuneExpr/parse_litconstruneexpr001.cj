/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: litconstruneexpr001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconstexpr_001() {
    let res = parseFile("./litconstruneexpr001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("r\'a\'"))
    @Assert(sourcefile.name, "litconstruneexpr001.cj")
    @Assert(sourcefile.path.contains("litconstruneexpr001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconstruneexpr = (maindecl.body.nodes[0] as LitConstRuneExpr).getOrThrow()

    //toString()
    @Assert(litconstruneexpr.toString(), "r\'a\'")

    //rawValue
    @Assert(litconstruneexpr.rawValue,"a")

    //isSingleQuote
    @Assert(litconstruneexpr.isSingleQuote, true)

    //kind
    match (litconstruneexpr.kind) {
        case LitConstKind.RuneLiteral => ()
        case _ => @Assert(false)
    }
}
}