/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: QuoteExpr_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_QuoteExpr_03() {
    let res = parseFile("./QuoteExpr_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Expect(sourcefile.toString().contains(##"quote(var str = #"a"#)"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: QuoteExpr = (mainDecl.body.nodes[0] as QuoteExpr).getOrThrow()
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