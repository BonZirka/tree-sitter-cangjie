/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: EnumPattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_EnumPattern_01() {
    let res = parseFile("./EnumPattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match (a) {
        case E1.A0 | E1.B0 => ()
        case E1.A0(1) => ()
        case p1.p0.E<Int64>.A1(1) => ()
        case p1.p0.E<T, U>.B1(a0, b0) =>()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    var pattern_1: EnumPattern = (expr.matchCases[0].patterns[0] as EnumPattern).getOrThrow()
    @Assert(pattern_1.toString(), "E1.A0")
    @Assert(pattern_1.enumConstructor.toString(), "A0")
    @Assert(pattern_1.enumType.getOrThrow().toString(), "E1")
    @Assert(pattern_1.subPatterns.toString(), "[]")

    var pattern_2: EnumPattern = (expr.matchCases[0].patterns[1] as EnumPattern).getOrThrow()
    @Assert(pattern_2.toString(), "E1.B0")
    @Assert(pattern_2.enumConstructor.toString(), "B0")
    @Assert(pattern_2.enumType.getOrThrow().toString(), "E1")
    @Assert(pattern_2.subPatterns.toString(), "[]")

    var pattern_3: EnumPattern = (expr.matchCases[1].patterns[0] as EnumPattern).getOrThrow()
    @Assert(pattern_3.toString(), "E1.A0(1)")
    @Assert(pattern_3.enumConstructor.toString(), "A0")
    @Assert(pattern_3.enumType.getOrThrow().toString(), "E1")
    @Assert(pattern_3.subPatterns.toString(), "[1]")

    var pattern_4: EnumPattern = (expr.matchCases[2].patterns[0] as EnumPattern).getOrThrow()
    @Assert(pattern_4.toString(), "p1.p0.E<Int64>.A1(1)")
    @Assert(pattern_4.toTokens().toString(), "p1.p0.E < Int64 >.A1(1)")
    @Assert(pattern_4.enumConstructor.toString(), "A1")
    @Assert(pattern_4.enumType.getOrThrow().toString(), "p1.p0.E<Int64>")
    @Assert(pattern_4.subPatterns.toString(), "[1]")

    var pattern_5: EnumPattern = (expr.matchCases[3].patterns[0] as EnumPattern).getOrThrow()
    @Assert(pattern_5.toString(), "p1.p0.E<T, U>.B1(a0, b0)")
    @Assert(pattern_5.enumConstructor.toString(), "B1")
    @Assert(pattern_5.enumType.getOrThrow().toString(), "p1.p0.E<T, U>")
    @Assert(pattern_5.subPatterns.toString(), "[a0, b0]")

    var posList = pattern_5.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [14i32, 33i32, 14i32, 34i32])
    var pos = pattern_5.getDotPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 27i32, 14i32, 28i32])
    pos = pattern_5.getLParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 30i32, 14i32, 31i32])
    pos = pattern_5.getRParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 37i32, 14i32, 38i32])
}
}