/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01 {
    @TestCase
func test_QuoteExpr_02() {
    let _quote_1 = quote(quote((x)))
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(quote(quote(x)))
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(quote(\$(quote(x))))
    let res_3 = parseTokens(_quote_3)

    let _quote_4 = quote(quote(\$(quote(\$t))))
    let res_4 = parseTokens(_quote_4)

    let _quote_5 = quote(quote(\$x + 2))
    let res_5 = parseTokens(_quote_5)

    let _quote_6 = quote(quote(1 + (\$x + 1) * 2))
    let res_6 = parseTokens(_quote_6)

    let _quote_7 = quote(quote(@PlusOne(x)))
    let res_7 = parseTokens(_quote_7)

    let _quote_8 = quote(quote(@PlusOne(\$x)))
    let res_8 = parseTokens(_quote_8)

    let _quote_9 = quote(quote(1 + @PlusOne(x) * 2))
    let res_9 = parseTokens(_quote_9)

    var expr_1: QuoteExpr = (res_1.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"quote((x))"##)
    @Assert(expr_1.tokensOrRefExpr.size, 1)
    match (expr_1.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "(x)")
            @Assert(QuoteToken.content.toString(), "(x)")
        case _ => @Assert(false)
    }

    var expr_2: QuoteExpr = (res_2.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"quote(quote(x))"##)
    @Assert(expr_2.tokensOrRefExpr.size, 1)
    match (expr_2.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "quote(x)")
            @Assert(QuoteToken.content.toString(), "quote(x)")
        case _ => @Assert(false)
    }
    var expr_3: QuoteExpr = (res_3.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_3.toString(), ##"quote($(quote(x)))"##)
    @Assert(expr_3.tokensOrRefExpr.size, 1)
    match (expr_3.tokensOrRefExpr[0]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(quote(x))"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"quote(x)"##)
        case _ => @Assert(false)
    }
    var expr_4: QuoteExpr = (res_4.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_4.toString(), ##"quote($(quote($t)))"##)
    @Assert(expr_4.tokensOrRefExpr.size, 1)
    match (expr_4.tokensOrRefExpr[0]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(quote($t))"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"quote($t)"##)
        case _ => @Assert(false)
    }

    var expr_5: QuoteExpr = (res_5.node.getOrThrow() as QuoteExpr).getOrThrow()
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

    var expr_6: QuoteExpr = (res_6.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_6.toString(), ##"quote(1 +($x + 1) * 2)"##)
    @Assert(expr_6.tokensOrRefExpr.size, 3)
    match (expr_6.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), "1 +(")
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

    var expr_7: QuoteExpr = (res_7.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_7.toString(), ##"quote(@PlusOne(x))"##)
    @Assert(expr_7.tokensOrRefExpr.size, 1)
    match (expr_7.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "@PlusOne(x)")
            @Assert(QuoteToken.content.toString(), "@PlusOne(x)")
        case _ => @Assert(false)
    }

    var expr_8: QuoteExpr = (res_8.node.getOrThrow() as QuoteExpr).getOrThrow()
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

    var expr_9: QuoteExpr = (res_9.node.getOrThrow() as QuoteExpr).getOrThrow()
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