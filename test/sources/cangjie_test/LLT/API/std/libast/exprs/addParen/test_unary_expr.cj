// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt

import std.ast.*

@Test
class Test_UnaryExpr {
    @TestCase
    func test_unaryExpr_01(): Unit {
        let expr = UnaryExpr(quote(-a))
        expr.expr = BinaryExpr(quote(a + 1))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "-(a + 1)")
    }

    @TestCase
    func test_unaryExpr_02(): Unit {
        let expr = UnaryExpr(quote(!a))
        expr.expr = BinaryExpr(quote(a + 1))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "!(a + 1)")
    }

    @TestCase
    func test_unaryExpr_03(): Unit {
        let expr = UnaryExpr(quote(!a))
        expr.expr = UnaryExpr(quote(-a))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "! - a")
    }
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
