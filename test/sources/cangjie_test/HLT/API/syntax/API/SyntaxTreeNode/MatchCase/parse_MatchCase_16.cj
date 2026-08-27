/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: MatchCase_16.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchCase_16() {
    let res = parseFile("./MatchCase_16.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(xxx) {
        case opt: Point where (opt.x < 0 && opt.y > 2.0) || opt.x < -10 => println("case opt: Point => ()")
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr.matchCases.size, 1)

    let case_1 = expr.matchCases[0]

    @Assert(case_1.toString(), ##"case opt: Point where (opt.x < 0 && opt.y > 2.0) || opt.x < -10 => println("case opt: Point => ()")"##)
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), ##"println("case opt: Point => ()")"##)
    @Assert(case_1.caseCond.isNone())
    @Assert(case_1.patternGuardCond.isSome())
    @Assert(case_1.patternGuardCond.getOrThrow().toString(), "(opt.x < 0 && opt.y > 2.0) || opt.x < -10")
    @Assert(case_1.patterns.size, 1)
    @Assert(case_1.patterns[0] is TypePattern)
    @Assert(case_1.patterns[0].toString(), "opt: Point")
}
}