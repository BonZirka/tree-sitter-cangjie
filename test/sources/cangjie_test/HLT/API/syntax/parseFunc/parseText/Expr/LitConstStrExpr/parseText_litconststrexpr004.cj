/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconststrexpr_004() {
    let str = "###\"\nHello,\nCangjie\nLang\"###"
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var litconststrexpr = (sourceNode as LitConstStrExpr).getOrThrow()
    //toString()
    @Assert(litconststrexpr.toString(), "###\"\nHello,\nCangjie\nLang\"###")
    //rawValue
    @Assert(litconststrexpr.rawValue,"\nHello,\nCangjie\nLang")
    //kind
    match (litconststrexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }
    //delimiterNum
    @Assert(litconststrexpr.delimiterNum, 3)
    //isSingleQuote
    @Assert(litconststrexpr.isSingleQuote, false)
    //strPartExprs
    @Assert(litconststrexpr.hasInterpolation(), false)
    @Assert(litconststrexpr.strPartExprs.size, 0)
    // strKind
    match (litconststrexpr.strKind) {
        case LitConstStrKind.MultiLineRawString => ()
        case _ => @Assert(false)
    }
}
}