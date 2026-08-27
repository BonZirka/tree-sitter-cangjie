/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: MatchCase_13.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchCase_13() {
    let res = parseFile("./MatchCase_13.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(("", 90)) {
        case (_, _) => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr.matchCases.size, 1)

    let case_1 = expr.matchCases[0]

    @Assert(case_1.toString(), ##"case (_, _) => ()"##)
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), "()")
    @Assert(case_1.caseCond.isNone())
    @Assert(case_1.patternGuardCond.isNone())
    @Assert(case_1.patterns.size, 1)
    @Assert(case_1.patterns[0] is TuplePattern)
    @Assert(case_1.patterns[0].toString(), "(_, _)")
}
}