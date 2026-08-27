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

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SubscriptExpr_01() {
    let _quote_1 = quote(a[0])
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(a.b[a])
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(a.b.c[a..b:2])
    let res_3 = parseTokens(_quote_3)

    let _quote_4 = quote(a?.b[a..b])
    let res_4 = parseTokens(_quote_4)

    let _quote_5 = quote(a[0][a..=b])
    let res_5 = parseTokens(_quote_5)

    let _quote_6 = quote(a[0][0][0])
    let res_6 = parseTokens(_quote_6)

    var expr_1 = (res_1.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_1.base.toString(), "a")
    @Assert(expr_1.indexs.toString(), "[0]")

    var expr_2 = (res_2.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_2.base.toString(), "a.b")
    @Assert(expr_2.indexs.toString(), "[a]")

    var expr_3 = (res_3.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_3.base.toString(), "a.b.c")
    @Assert(expr_3.indexs.toString(), "[a .. b: 2]")

    var expr_4 = (res_4.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_4.base.toString(), "a?.b")
    @Assert(expr_4.indexs.toString(), "[a .. b]")

    var expr_5 = (res_5.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_5.base.toString(), "a[0]")
    @Assert(expr_5.indexs.toString(), "[a ..= b]")

    var expr_6 = (res_6.node.getOrThrow() as SubscriptExpr).getOrThrow()
    @Assert(expr_6.base.toString(), "a[0][0]")
    @Assert(expr_6.base is SubscriptExpr)
    @Assert(expr_6.indexs.toString(), "[0]")
}
}