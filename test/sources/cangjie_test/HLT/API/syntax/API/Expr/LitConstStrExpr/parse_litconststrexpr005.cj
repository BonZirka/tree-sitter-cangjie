/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: litconststrexpr005.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconststrexpr_005() {
    let res = parseFile("./litconststrexpr005.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains("#\'\nHello,\nCangjie\nLang\'#"))
    @Assert(sourcefile.name, "litconststrexpr005.cj")
    @Assert(sourcefile.path.contains("litconststrexpr005.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconststrexpr = (maindecl.body.nodes[0] as LitConstStrExpr).getOrThrow()
    //toString()
    @Assert(litconststrexpr.toString().replace("\r",""), ##"###'
Hello,
Cangjie
Lang'###"##)
    //rawValue
    @Assert(litconststrexpr.rawValue.replace("\r",""),"\nHello,\nCangjie\nLang")
    //kind
    match (litconststrexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }
    //delimiterNum
    @Assert(litconststrexpr.delimiterNum, 3)
    //isSingleQuote
    @Assert(litconststrexpr.isSingleQuote,true)
    // strPartExprs 
    @Assert(litconststrexpr.hasInterpolation(), false)
    // strKind 
    match (litconststrexpr.strKind) {
        case LitConstStrKind.MultiLineRawString => ()
        case _ => @Assert(false)
    }
}
}