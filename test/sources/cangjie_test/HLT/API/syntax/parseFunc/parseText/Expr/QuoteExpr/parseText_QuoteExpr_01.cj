/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_QuoteExpr_01() {
    let str_1 = ##"quote()"##
    let res_1 = parseText(str_1)

    let str_2 = ##"quote(a)"##
    let res_2 = parseText(str_2)

    let str_3 = ##"quote(a = b)"##
    let res_3 = parseText(str_3)

    let str_4 = ##"quote(
    arr = $(intList)
    x = $(float)
    s = $(str)
)"##
    let res_4 = parseText(str_4)

    var expr_1: QuoteExpr = (res_1.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"quote()"##)
    @Assert(expr_1.tokensOrRefExpr.size, 0)
    var expr_2: QuoteExpr = (res_2.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"quote(a)"##)
    @Assert(expr_2.tokensOrRefExpr.size, 1)
    match (expr_2.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "a")
            @Assert(QuoteToken.content.toString(), "a")
        case _ => @Assert(false)
    }
    var expr_3: QuoteExpr = (res_3.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Assert(expr_3.toString(), ##"quote(a = b)"##)
    @Assert(expr_3.tokensOrRefExpr.size, 1)
    match (expr_3.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Assert(QuoteToken.toString(), "a = b")
            @Assert(QuoteToken.content.toString(), "a = b")
        case _ => @Assert(false)
    }
    var expr_4: QuoteExpr = (res_4.node.getOrThrow() as QuoteExpr).getOrThrow()
    @Expect(expr_4.toString().replace("\r",""), ##"quote(
    arr = $(intList)
    x = $(float)
    s = $(str)
)"##)
    @Expect(expr_4.tokensOrRefExpr.size, 7)
    match (expr_4.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString().contains("arr ="))
            @Expect(QuoteToken.content.toString().contains("arr ="))
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[1]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(intList)"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"intList"##)
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[2]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString().contains("x ="))
            @Expect(QuoteToken.content.toString().contains("x ="))
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[3]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(float)"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"float"##)
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[4]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString().contains("s ="))
            @Expect(QuoteToken.content.toString().contains("s ="))
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[5]) {
        case QuoteInterpolation(QuoteInterpolationExpr) =>
            @Assert(QuoteInterpolationExpr.toString(), ##"$(str)"##)
            @Assert(QuoteInterpolationExpr.expr.toString(), ##"str"##)
        case _ => @Assert(false)
    }
    match (expr_4.tokensOrRefExpr[6]) {
        case TokenPart(QuoteToken) => ()
        case _ => @Assert(false)
    }

    var pos = expr_1.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 6i32, 1i32, 7i32])
    pos = expr_1.getQuoteKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 6i32])
    pos = expr_1.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 7i32, 1i32, 8i32])
}
}