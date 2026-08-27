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
func test_ParenExpr_01() {
    let _quote_1 = quote((()))
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote((a_b))
    let res_2 = parseTokens(_quote_2)

    var expr_1: ParenExpr = (res_1.node.getOrThrow() as ParenExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"(())"##)
    @Expect(expr_1.subExpr.toString(), ##"()"##)

    var expr_2: ParenExpr = (res_2.node.getOrThrow() as ParenExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"(a_b)"##)
    @Expect(expr_2.subExpr.toString(), ##"a_b"##)

    var pos = expr_2.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 2i32])
    pos = expr_2.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 5i32, 1i32, 6i32])
}
}