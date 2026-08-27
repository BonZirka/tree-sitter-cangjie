/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: TypePattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TypePattern_01() {
    let res = parseFile("./TypePattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(a) {
        case x: Int64 => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    var pattern_1: TypePattern = (expr.matchCases[0].patterns[0] as TypePattern).getOrThrow()
    @Assert(pattern_1.toString(), "x: Int64")
    @Assert(pattern_1.patternType is AtomicType)
    @Assert(pattern_1.subPattern is VarPattern)
    @Assert(pattern_1.subPattern.toString(), "x")

    var pos = pattern_1.getColonPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 15i32, 11i32, 16i32])
}
}