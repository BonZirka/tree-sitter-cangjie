/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: MatchCase_15.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchCase_15() {
    let res = parseFile("./MatchCase_15.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(("Allen", 90)) {
        case ("Allen", 100) | ("Bob", y) | x where !(y <= 100) => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr.matchCases.size, 1)

    let case_1 = expr.matchCases[0]

    @Assert(case_1.toString(), ##"case ("Allen", 100) | ("Bob", y) | x where !(y <= 100) => ()"##)
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), "()")
    @Assert(case_1.caseCond.isNone())
    @Assert(case_1.patternGuardCond.isSome())
    @Assert(case_1.patternGuardCond.getOrThrow().toString(), "!(y <= 100)")
    @Assert(case_1.patterns.size, 3)
    @Assert(case_1.patterns[0] is TuplePattern)
    @Assert(case_1.patterns[0].toString(), "(\"Allen\", 100)")
    @Assert(case_1.patterns[1] is TuplePattern)
    @Assert(case_1.patterns[1].toString(), "(\"Bob\", y)")
    @Assert(case_1.patterns[2] is VarOrEnumPattern)
    @Assert(case_1.patterns[2].toString(), "x")
}
}