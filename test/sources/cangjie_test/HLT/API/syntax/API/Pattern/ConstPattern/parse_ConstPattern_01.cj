/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ConstPattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ConstPattern_01() {
    let res = parseFile("./ConstPattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(1.0) {
        case 1.0e308 | .123e2f64 | 0x.2p4 => ()
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: MatchExpr = (mainDecl.body.nodes[0] as MatchExpr).getOrThrow()
    var pattern_1: ConstPattern = (expr.matchCases[0].patterns[0] as ConstPattern).getOrThrow()
    @Assert(pattern_1.toString(), "1.0e308")
    @Expect(pattern_1.litConstExpr.toString(), "1.0e308")

    var pattern_2: ConstPattern = (expr.matchCases[0].patterns[1] as ConstPattern).getOrThrow()
    @Assert(pattern_2.toString(), ".123e2f64")
    @Expect(pattern_2.litConstExpr.toString(), ".123e2f64")

    var pattern_3: ConstPattern = (expr.matchCases[0].patterns[2] as ConstPattern).getOrThrow()
    @Assert(pattern_3.toString(), "0x.2p4")
    @Expect(pattern_3.litConstExpr.toString(), "0x.2p4")
}
}