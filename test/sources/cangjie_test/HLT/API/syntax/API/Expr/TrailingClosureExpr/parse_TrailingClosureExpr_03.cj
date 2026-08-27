/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: TrailingClosureExpr_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TrailingClosureExpr_03() {
    let res = parseFile("./TrailingClosureExpr_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    g(a: 1) {a: Int64, b: Int64 => a+ b}
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: TrailingClosureExpr = (mainDecl.body.nodes[0] as TrailingClosureExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"g(a: 1) {a: Int64, b: Int64 => a+ b}"##)
    @Assert(expr_1.arguments.toString(), "[a: 1]")
    @Expect(expr_1.callee.toString(), ##"g"##)
    @Assert(expr_1.trailingLambdaExpr.toString(), ##"{a: Int64, b: Int64 => a+ b}"##)
}
}