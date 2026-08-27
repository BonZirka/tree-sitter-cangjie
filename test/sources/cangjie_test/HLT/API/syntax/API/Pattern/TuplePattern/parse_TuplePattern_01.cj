/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: TuplePattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TuplePattern_01() {
    let res = parseFile("./TuplePattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(a) {
        case ("Bob", age) => ()
        case ("Bob", _) => ()
        case ("Bob", (a, b)) => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    var pattern_1: TuplePattern = (expr.matchCases[0].patterns[0] as TuplePattern).getOrThrow()
    @Assert(pattern_1.toString(), ##"("Bob", age)"##)
    @Assert(pattern_1.subPatterns[0] is ConstPattern)
    @Assert(pattern_1.subPatterns[0].toString(), ##""Bob""##)
    @Assert(pattern_1.subPatterns[1] is VarOrEnumPattern)
    @Assert(pattern_1.subPatterns[1].toString(), ##"age"##)

    var pattern_2: TuplePattern = (expr.matchCases[1].patterns[0] as TuplePattern).getOrThrow()
    @Assert(pattern_2.toString(), ##"("Bob", _)"##)
    @Assert(pattern_2.subPatterns[0] is ConstPattern)
    @Assert(pattern_2.subPatterns[0].toString(), ##""Bob""##)
    @Assert(pattern_2.subPatterns[1] is WildcardPattern)
    @Assert(pattern_2.subPatterns[1].toString(), ##"_"##)

    var pattern_3: TuplePattern = (expr.matchCases[2].patterns[0] as TuplePattern).getOrThrow()
    @Assert(pattern_3.toString(), ##"("Bob", (a, b))"##)
    @Assert(pattern_3.subPatterns[0] is ConstPattern)
    @Assert(pattern_3.subPatterns[0].toString(), ##""Bob""##)
    @Assert(pattern_3.subPatterns[1] is TuplePattern)
    @Assert(pattern_3.subPatterns[1].toString(), ##"(a, b)"##)

    var posList = pattern_3.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [13i32, 20i32, 13i32, 21i32])
    var pos = pattern_3.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 14i32, 13i32, 15i32])
    pos = pattern_3.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 28i32, 13i32, 29i32])
}
}