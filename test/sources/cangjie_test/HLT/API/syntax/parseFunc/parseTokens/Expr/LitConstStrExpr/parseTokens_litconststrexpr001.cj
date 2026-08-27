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
class test_01 {
    @TestCase
func test_litconststrexpr_001() {
    let _quote = quote('Hello Cangjie Lang')
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var litconststrexpr = (sourceNode as LitConstStrExpr).getOrThrow()

    //toString()
    @Assert(litconststrexpr.toString(), "'Hello Cangjie Lang'")

    //rawValue
    @Assert(litconststrexpr.rawValue,"Hello Cangjie Lang")

    //kind
    match (litconststrexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }

    //delimiterNum
    @Assert(litconststrexpr.delimiterNum, 0)

    //isSingleQuote
    @Assert(litconststrexpr.isSingleQuote,true)

    // strPartExprs 
    @Assert(litconststrexpr.hasInterpolation(), false)

    // strKind
    match (litconststrexpr.strKind) {
        case LitConstStrKind.StringLiteral => ()
        case _ => @Assert(false)
    }
}
}