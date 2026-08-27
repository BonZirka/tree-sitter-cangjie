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
func test_ReturnExpr_02() {
    let _quote = quote(return if (a) {b} else {b})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var expr_3: ReturnExpr = (sourceNode as ReturnExpr).getOrThrow()

    @Assert(expr_3.toString(), "return if(a) { b } else { b }")
    @Expect(expr_3.retVal.isSome())
    @Expect(expr_3.retVal.getOrThrow().toString(), "if(a) { b } else { b }")
}
}