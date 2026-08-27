/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MatchCase_19.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchCase_19() {
    let res = parseFile("./MatchCase_19.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(xxx) {
        case Date.Year(y) => ()
        case Date.Hour(y, m, d, h) => ()
        case Date.Month(x, _) => ()
        case pkgA.Date.Year(y) | Month(y, m) => ()
        case _ => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr.matchCases.size, 5)

    let case_1 = expr.matchCases[0]
    let case_2 = expr.matchCases[1]
    let case_3 = expr.matchCases[2]
    let case_4 = expr.matchCases[3]

    @Assert(case_1.toString(), ##"case Date.Year(y) => ()"##)
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), ##"()"##)
    @Assert(case_1.caseCond.isNone())
    @Assert(case_1.patternGuardCond.isNone())
    @Assert(case_1.patterns.size, 1)
    @Assert(case_1.patterns[0] is EnumPattern)
    @Assert(case_1.patterns[0].toString(), "Date.Year(y)")

    @Assert(case_2.toString(), ##"case Date.Hour(y, m, d, h) => ()"##)
    @Assert(case_2.body.size, 1)
    @Assert(case_2.body[0].toString(), ##"()"##)
    @Assert(case_2.caseCond.isNone())
    @Assert(case_2.patternGuardCond.isNone())
    @Assert(case_2.patterns.size, 1)
    @Assert(case_2.patterns[0] is EnumPattern)
    @Assert(case_2.patterns[0].toString(), "Date.Hour(y, m, d, h)")

    @Assert(case_3.toString(), ##"case Date.Month(x, _) => ()"##)
    @Assert(case_3.body.size, 1)
    @Assert(case_3.body[0].toString(), ##"()"##)
    @Assert(case_3.caseCond.isNone())
    @Assert(case_3.patternGuardCond.isNone())
    @Assert(case_3.patterns.size, 1)
    @Assert(case_3.patterns[0] is EnumPattern)
    @Assert(case_3.patterns[0].toString(), "Date.Month(x, _)")

    @Assert(case_4.toString(), ##"case pkgA.Date.Year(y) | Month(y, m) => ()"##)
    @Assert(case_4.body.size, 1)
    @Assert(case_4.body[0].toString(), ##"()"##)
    @Assert(case_4.caseCond.isNone())
    @Assert(case_4.patternGuardCond.isNone())
    @Assert(case_4.patterns.size, 2)
    @Assert(case_4.patterns[0] is EnumPattern)
    @Assert(case_4.patterns[0].toString(), "pkgA.Date.Year(y)")
    @Assert(case_4.patterns[1] is EnumPattern)
    @Assert(case_4.patterns[1].toString(), "Month(y, m)")
}
}