/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: QuoteExpr_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_QuoteExpr_02() {
    let res = parseFile("./QuoteExpr_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    quote((x))
    quote(quote(x))
    quote($(quote(x)))
    quote($(quote($t)))
    quote($x + 2)
    quote(1 + ($x + 1) * 2)
    quote(@PlusOne(x))
    quote(@PlusOne($x))
    quote(1 + @PlusOne(x) * 2)
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: QuoteExpr = (mainDecl.body.nodes[0] as QuoteExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"quote((x))"##)
    @Assert(expr_1.tokensOrRefExpr.size, 1)
    match (expr_1.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "(x)")
            @Assert(QuoteToken.content.toString(), "(x)")
        case _ => @Assert(false)
    }

    var expr_2: QuoteExpr = (mainDecl.body.nodes[1] as QuoteExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"quote(quote(x))"##)
    @Assert(expr_2.tokensOrRefExpr.size, 1)
    match (expr_2.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "quote(x)")
            @Assert(QuoteToken.content.toString(), "quote(x)")
        case _ => @Assert(false)
    }
    var expr_3: QuoteExpr = (mainDecl.body.nodes[2] as QuoteExpr).getOrThrow()
    @Assert(expr_3.toString(), ##"quote($(quote(x)))"##)
    @Assert(expr_3.tokensOrRefExpr.size, 1)
    match (expr_3.tokensOrRefExpr[0]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(quote(x))"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"quote(x)"##)
        case _ => @Assert(false)
    }
    var expr_4: QuoteExpr = (mainDecl.body.nodes[3] as QuoteExpr).getOrThrow()
    @Assert(expr_4.toString(), ##"quote($(quote($t)))"##)
    @Assert(expr_4.tokensOrRefExpr.size, 1)
    match (expr_4.tokensOrRefExpr[0]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(quote($t))"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"quote($t)"##)
        case _ => @Assert(false)
    }

    var expr_5: QuoteExpr = (mainDecl.body.nodes[4] as QuoteExpr).getOrThrow()
    @Assert(expr_5.toString(), ##"quote($x + 2)"##)
    @Assert(expr_5.tokensOrRefExpr.size, 2)
    match (expr_5.tokensOrRefExpr[0]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$x"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"x"##)
        case _ => @Assert(false)
    }
    match (expr_5.tokensOrRefExpr[1]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), "+ 2")
            @Expect(QuoteToken.content.toString(), "+ 2")
        case _ => @Assert(false)
    }

    var expr_6: QuoteExpr = (mainDecl.body.nodes[5] as QuoteExpr).getOrThrow()
    @Assert(expr_6.toString(), ##"quote(1 + ($x + 1) * 2)"##)
    @Assert(expr_6.tokensOrRefExpr.size, 3)
    match (expr_6.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), "1 + (")
            @Expect(QuoteToken.content.toString(), "1 +(")
        case _ => @Assert(false)
    }
    match (expr_6.tokensOrRefExpr[1]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$x"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"x"##)
        case _ => @Assert(false)
    }
    match (expr_6.tokensOrRefExpr[2]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), "+ 1) * 2")
            @Expect(QuoteToken.content.toString(), "+ 1) * 2")
        case _ => @Assert(false)
    }

    var expr_7: QuoteExpr = (mainDecl.body.nodes[6] as QuoteExpr).getOrThrow()
    @Assert(expr_7.toString(), ##"quote(@PlusOne(x))"##)
    @Assert(expr_7.tokensOrRefExpr.size, 1)
    match (expr_7.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "@PlusOne(x)")
            @Assert(QuoteToken.content.toString(), "@PlusOne(x)")
        case _ => @Assert(false)
    }

    var expr_8: QuoteExpr = (mainDecl.body.nodes[7] as QuoteExpr).getOrThrow()
    @Assert(expr_8.toString(), ##"quote(@PlusOne($x))"##)
    @Assert(expr_8.tokensOrRefExpr.size, 3)
    match (expr_8.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), "@PlusOne(")
            @Expect(QuoteToken.content.toString(), "@PlusOne(")
        case _ => @Assert(false)
    }
    match (expr_8.tokensOrRefExpr[1]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$x"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"x"##)
        case _ => @Assert(false)
    }
    match (expr_8.tokensOrRefExpr[2]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), ")")
            @Expect(QuoteToken.content.toString(), ")")
        case _ => @Assert(false)
    }

    var expr_9: QuoteExpr = (mainDecl.body.nodes[8] as QuoteExpr).getOrThrow()
    @Assert(expr_9.toString(), ##"quote(1 + @PlusOne(x) * 2)"##)
    @Assert(expr_9.tokensOrRefExpr.size, 1)
    match (expr_9.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "1 + @PlusOne(x) * 2")
            @Assert(QuoteToken.content.toString(), "1 + @PlusOne(x) * 2")
        case _ => @Assert(false)
    }
}
}