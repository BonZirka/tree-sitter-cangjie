/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MatchCase_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchCase_01() {
    let res = parseFile("./MatchCase_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    match(10) {
        case 0 => ()
        case 70 | 80 => ()
        case 100 where false => println("a")
        case _ => throw Exception()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr.matchCases.size, 4)

    let case_1 = expr.matchCases[0]
    let case_2 = expr.matchCases[1]
    let case_3 = expr.matchCases[2]
    let case_4 = expr.matchCases[3]

    @Assert(case_1.toString(), "case 0 => ()")
    @Assert(case_1.body.size, 1)
    @Assert(case_1.body[0].toString(), "()")
    @Assert(case_1.caseCond.isNone())
    @Assert(case_1.patternGuardCond.isNone())
    @Assert(case_1.patterns.size, 1)
    @Assert(case_1.patterns[0] is ConstPattern)
    @Assert(case_1.patterns[0].toString(), "0")

    @Assert(case_2.toString(), "case 70 | 80 => ()")
    @Assert(case_2.body.size, 1)
    @Assert(case_2.body[0].toString(), "()")
    @Assert(case_2.caseCond.isNone())
    @Assert(case_2.patternGuardCond.isNone())
    @Assert(case_2.patterns.size, 2)
    @Assert(case_2.patterns[0] is ConstPattern)
    @Assert(case_2.patterns[0].toString(), "70")
    @Assert(case_2.patterns[1] is ConstPattern)
    @Assert(case_2.patterns[1].toString(), "80")

    @Assert(case_3.toString(), ##"case 100 where false => println("a")"##)
    @Assert(case_3.body.size, 1)
    @Assert(case_3.body[0].toString(), ##"println("a")"##)
    @Assert(case_3.caseCond.isNone())
    @Assert(case_3.patternGuardCond.isSome())
    @Assert(case_3.patternGuardCond.toString(), "Some(false)")
    @Assert(case_3.patterns.size, 1)
    @Assert(case_3.patterns[0] is ConstPattern)
    @Assert(case_3.patterns[0].toString(), "100")

    @Assert(case_4.toString(), "case _ => throw Exception()")
    @Assert(case_4.body.size, 1)
    @Assert(case_4.body[0].toString(), "throw Exception()")
    @Assert(case_4.caseCond.isNone())
    @Assert(case_4.patternGuardCond.isNone())
    @Assert(case_4.patterns.size, 1)
    @Assert(case_4.patterns[0] is WildcardPattern)
    @Assert(case_4.patterns[0].toString(), "_")

    var pos = case_2.getDoubleArrowPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 22i32, 12i32, 24i32])
    var posList = case_2.getBitOrsPos()
    @Expect(posList.size, 1)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [12i32, 17i32, 12i32, 18i32])
    pos = case_2.getCasePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [12i32, 9i32, 12i32, 13i32])
    pos = case_3.getWherePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 18i32, 13i32, 23i32])
}
}