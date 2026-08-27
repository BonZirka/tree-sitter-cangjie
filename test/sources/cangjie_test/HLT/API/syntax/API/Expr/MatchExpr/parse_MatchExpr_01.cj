/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MatchExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchExpr_01() {
    let res = parseFile("./MatchExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match {
        case true => ()
        case a >= b => a + b
        case _ => ()
    }
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1 = (maindecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"match {
        case true => ()
        case a >= b => a + b
        case _ => ()
    }"##)
    @Assert(expr_1.selector.isNone())
    @Assert(expr_1.matchCases.size, 3)

    let case_1 = expr_1.matchCases[0]
    @Assert(case_1.toString(), "case true => ()")
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), "()")
    @Assert(case_1.caseCond.isSome())
    @Assert(case_1.caseCond.getOrThrow().toString(), "true")
    @Assert(case_1.patternGuardCond.isNone())
    @Assert(case_1.patterns.size, 0)

    let case_2 = expr_1.matchCases[1]
    @Assert(case_2.toString(), "case a >= b => a + b")
    @Assert(case_2.body.size, 1)
    @Assert(case_2.body[0].toString(), "a + b")
    @Assert(case_2.caseCond.isSome())
    @Assert(case_2.caseCond.getOrThrow().toString(), "a >= b")
    @Assert(case_2.patternGuardCond.isNone())
    @Assert(case_2.patterns.size, 0)

    let case_3 = expr_1.matchCases[2]
    @Assert(case_3.toString(), "case _ => ()")
    @Assert(case_3.body.size, 1)
    @Assert(case_3.body[0].toString(), "()")
    @Assert(case_3.caseCond.isNone())
    @Assert(case_3.patternGuardCond.isNone())
    @Assert(case_3.patterns.size, 1)
    @Assert(case_3.patterns[0] is WildcardPattern)

    var pos = expr_1.getMatchCasesLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 11i32, 10i32, 12i32])
    pos = expr_1.getMatchCasesRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 5i32, 14i32, 6i32])
    pos = expr_1.getMatchKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 10i32])
    @Assert(expr_1.getSelectorLParenPos().isNone())
    @Assert(expr_1.getSelectorRParenPos().isNone())
}
}