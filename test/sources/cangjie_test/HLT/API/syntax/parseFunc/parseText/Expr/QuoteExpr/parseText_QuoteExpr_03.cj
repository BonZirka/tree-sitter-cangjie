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

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_QuoteExpr_03() {
    let str = ##"quote(var str = #"a"#)"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var expr_1: QuoteExpr = (sourceNode as QuoteExpr).getOrThrow()
    
    @Assert(expr_1.toString(), ##"quote(var str = #"a"#)"##)
    @Assert(expr_1.tokensOrRefExpr.size, 1)
    match (expr_1.tokensOrRefExpr[0]) {
        case TokenPart(QuoteToken) =>
            @Expect(QuoteToken.toString(), ##"var str = #"a"#"##)
            @Expect(QuoteToken.content.toString(), ##"var str = #"a"#"##)
        case _ => @Assert(false)
    }
}
}