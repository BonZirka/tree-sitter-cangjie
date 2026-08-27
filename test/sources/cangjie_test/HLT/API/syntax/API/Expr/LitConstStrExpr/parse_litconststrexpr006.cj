/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: litconststrexpr006.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconststrexpr_006() {
    let res = parseFile("./litconststrexpr006.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("\"hello, \${x}, \${y}\""))
    @Assert(sourcefile.name, "litconststrexpr006.cj")
    @Assert(sourcefile.path.contains("litconststrexpr006.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconststrexpr = (maindecl.body.nodes[0] as LitConstStrExpr).getOrThrow()
    //toString()
    @Assert(litconststrexpr.toString(), "\"hello, \${x}, \${y}\"")
    //rawValue
    @Expect(litconststrexpr.rawValue,"hello, \${x}, \${y}")
    //kind
    match (litconststrexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }
    //delimiterNum
    @Assert(litconststrexpr.delimiterNum, 0)
    //isSingleQuote
    @Assert(litconststrexpr.isSingleQuote, false)
    //strPartExprs 
    @Assert(litconststrexpr.strPartExprs.size, 4)
    match (litconststrexpr.strPartExprs[0]) {
        case StrLiteralPart.LitConstPart(litConstExpr) => @Assert(litConstExpr.toString(), "hello, ")
        case _ => @Assert(false)
    }
    match (litconststrexpr.strPartExprs[1]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), "\${x}")
        case _ => @Assert(false)
    }
    match (litconststrexpr.strPartExprs[2]) {
        case StrLiteralPart.LitConstPart(litConstExpr) => @Assert(litConstExpr.toString(), ", ")
        case _ => @Assert(false)
    }
    match (litconststrexpr.strPartExprs[3]) {
        case StrLiteralPart.StrInterpolation(strInterpolationContent) => @Assert(strInterpolationContent.toString(), "\${y}")
        case _ => @Assert(false)
    }
    // strKind 
    match (litconststrexpr.strKind) {
        case LitConstStrKind.StringLiteral => ()
        case _ => @Assert(false)
    }
}
}