/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: MatchExpr_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MatchExpr_02() {
    let res = parseFile("./MatchExpr_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    match(a()) {
        case true => ()
        case _ => ()
    }
}"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1 = (maindecl.body.nodes[0] as MatchExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"match(a()) {
        case true => ()
        case _ => ()
    }"##)
    @Assert(expr_1.selector.isSome())
    @Assert(expr_1.selector.getOrThrow().toString(), "a()")
    @Assert(expr_1.matchCases.size, 2)
    @Assert(expr_1.matchCases[0].toString(), "case true => ()")
}
}