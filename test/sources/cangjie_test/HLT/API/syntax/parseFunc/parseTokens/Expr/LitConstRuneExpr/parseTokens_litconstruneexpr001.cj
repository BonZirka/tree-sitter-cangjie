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

import stdx.syntax.*

@Test
class test_01 {
    @TestCase
func test_litconstexpr_001() {
    let _quote = quote(r'a')
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var litconstruneexpr = (sourceNode as LitConstRuneExpr).getOrThrow()

    //toString()
    @Assert(litconstruneexpr.toString().replace("\r",""), "r\'a\'")

    //rawValue
    @Assert(litconstruneexpr.rawValue,"a")

    //isSingleQuote
    @Assert(litconstruneexpr.isSingleQuote, true)

    //kind
    match (litconstruneexpr.kind) {
        case LitConstKind.RuneLiteral => ()
        case _ => @Assert(false)
    }
}
}