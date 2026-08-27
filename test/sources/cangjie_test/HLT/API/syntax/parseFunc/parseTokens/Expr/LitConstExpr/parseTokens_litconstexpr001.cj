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
func test_litconstexpr_001() {
    let _quote = quote(1234567)
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var litconstexpr = (sourceNode as LitConstExpr).getOrThrow()
    @Assert(litconstexpr.toString(), "1234567")
    @Assert(litconstexpr.rawValue, "1234567")
    match (litconstexpr.kind) {
        case LitConstKind.IntergerLiteral => ()
        case _ => @Assert(false)
    }
}
}