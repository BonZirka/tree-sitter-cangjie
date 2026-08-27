/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: litconststrexpr001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconststrexpr_001() {
    let res = parseFile("./litconststrexpr001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("'Hello Cangjie Lang'"))
    @Assert(sourcefile.name, "litconststrexpr001.cj")
    @Assert(sourcefile.path.contains("litconststrexpr001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconststrexpr = (maindecl.body.nodes[0] as LitConstStrExpr).getOrThrow()

    //toString()
    @Assert(litconststrexpr.toString(), "'Hello Cangjie Lang'")

    //rawValue
    @Assert(litconststrexpr.rawValue,"Hello Cangjie Lang")

    //kind
    match (litconststrexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }

    //delimiterNum
    @Assert(litconststrexpr.delimiterNum, 0)

    //isSingleQuote
    @Assert(litconststrexpr.isSingleQuote,true)

    // strPartExprs 
    @Assert(litconststrexpr.hasInterpolation(), false)

    // strKind
    match (litconststrexpr.strKind) {
        case LitConstStrKind.StringLiteral => ()
        case _ => @Assert(false)
    }
}
}