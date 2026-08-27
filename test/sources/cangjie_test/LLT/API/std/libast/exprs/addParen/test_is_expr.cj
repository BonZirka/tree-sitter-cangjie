// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt

import std.ast.*

@Test
class Test_IsExpr {
    @TestCase
    func test_isExpr_01(): Unit {
        let expr = IsExpr(quote(a is b))
        expr.expr = IsExpr(quote(a is b))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "(a is b) is b")
    }

    @TestCase
    func test_isExpr_02(): Unit {
        let expr = IsExpr(quote(a is b))
        expr.expr = BinaryExpr(quote(2 ** 4))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "2 ** 4 is b")
    }

    @TestCase
    func test_isExpr_03(): Unit {
        let expr = IsExpr(quote(a is b))
        expr.expr = BinaryExpr(quote(a | b))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "(a | b) is b")
    }

    @TestCase
    func test_isExpr_04(): Unit {
        let expr = IsExpr(quote(a is b))
        expr.expr = BinaryExpr(quote(a < b))
        let tokens = expr.toTokens()
        println(tokens)
        @Expect(tokens.toString(), "(a < b) is b")
    }
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
