/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: VarOrEnumPattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VarOrEnumPattern_01() {
    let res = parseFile("./VarOrEnumPattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match (a) {
        case A0 | B0(1) => ()
        case x => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    var pattern_1: VarOrEnumPattern = (expr.matchCases[0].patterns[0] as VarOrEnumPattern).getOrThrow()
    @Assert(pattern_1.toString(), "A0")
    @Assert(pattern_1.identifier.toString(), "A0")

    var pattern_2: EnumPattern = (expr.matchCases[0].patterns[1] as EnumPattern).getOrThrow()
    @Assert(pattern_2.toString(), "B0(1)")
    @Assert(pattern_2.subPatterns.toString(), "[1]")

    var pattern_3: VarOrEnumPattern = (expr.matchCases[1].patterns[0] as VarOrEnumPattern).getOrThrow()
    @Assert(pattern_3.toString(), "x")
    @Assert(pattern_3.identifier.toString(), "x")
}
}