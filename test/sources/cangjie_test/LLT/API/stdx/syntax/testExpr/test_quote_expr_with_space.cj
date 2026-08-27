/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// DEPENDENCE: sourceFile/quote_expr_with_space.cj
// (not Windows) EXEC: dos2unix quote_expr_with_space.cj
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
func test_QuoteExpr_01() {
    let res = parseFile("quote_expr_with_space.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile : SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r\n", "\n").contains(##"main() {
    quote()
    quote(a)
    quote(a = b)
    quote(     arr =      $(intList)
    x = $(float)
    s = $(str)
)
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: QuoteExpr = (mainDecl.body.nodes[0] as QuoteExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r\n", "\n"), ##"quote()"##)
    @Assert(expr_1.tokensOrRefExpr.size, 0)
    var expr_2: QuoteExpr = (mainDecl.body.nodes[1] as QuoteExpr).getOrThrow()
    @Assert(expr_2.toString().replace("\r\n", "\n"), ##"quote(a)"##)
    @Assert(expr_2.tokensOrRefExpr.size, 1)
    match(expr_2.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) => 
            @Assert(QuoteToken.toString().replace("\r\n", "\n"), "a")
        case _ => @Assert(false)
    }
    var expr_3: QuoteExpr = (mainDecl.body.nodes[2] as QuoteExpr).getOrThrow()
    @Assert(expr_3.toString().replace("\r\n", "\n"), ##"quote(a = b)"##)
    @Assert(expr_3.tokensOrRefExpr.size, 1)
    match(expr_3.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) => 
            @Assert(QuoteToken.toString().replace("\r\n", "\n"), "a = b")
        case _ => @Assert(false)
    }
    var expr_4: QuoteExpr = (mainDecl.body.nodes[3] as QuoteExpr).getOrThrow()
    @Expect(expr_4.toString().replace("\r\n", "\n"), ##"quote(     arr =      $(intList)
    x = $(float)
    s = $(str)
)"##)
    @Expect(expr_4.tokensOrRefExpr.size, 7)
    match(expr_4.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) => 
            @Expect(QuoteToken.toString().replace("\r\n", "\n"), ##"arr ="##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[1]) {
        case QuoteInterpolation(QuoteInterpolationExpr) => 
            @Assert(QuoteInterpolationExpr.toString().replace("\r\n", "\n"), ##"$(intList)"##)
            @Assert(QuoteInterpolationExpr.expr.toString().replace("\r\n", "\n"), ##"intList"##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[2]) {
        case TokenPart(QuoteToken) => 
            @Expect(QuoteToken.toString().replace("\r\n", "\n"), ##"
    x ="##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[3]) {
        case QuoteInterpolation(QuoteInterpolationExpr) => 
            @Assert(QuoteInterpolationExpr.toString().replace("\r\n", "\n"), ##"$(float)"##)
            @Assert(QuoteInterpolationExpr.expr.toString().replace("\r\n", "\n"), ##"float"##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[4]) {
        case TokenPart(QuoteToken) => 
            @Expect(QuoteToken.toString().replace("\r\n", "\n"), ##"
    s ="##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[5]) {
        case QuoteInterpolation(QuoteInterpolationExpr) => 
            @Assert(QuoteInterpolationExpr.toString().replace("\r\n", "\n"), ##"$(str)"##)
            @Assert(QuoteInterpolationExpr.expr.toString().replace("\r\n", "\n"), ##"str"##)
        case _ => @Assert(false)
    }
    match(expr_4.tokensOrRefExpr[6]) {
        case TokenPart(QuoteToken) => 
            @Expect(QuoteToken.toString().replace("\r\n", "\n"), ##"
"##)
        case _ => @Assert(false)
    }
}
