/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: WhileExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_WhileExpr_01() {
    let res = parseFile("./WhileExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    while(a >= 0u32) {
        b
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: WhileExpr = (mainDecl.body.nodes[0] as WhileExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"while(a >= 0u32) {
        b
    }"##)
    @Assert(expr_1.body.toString().replace("\r",""), ##"{
        b
    }"##)
    @Assert(expr_1.condition.toString(), ##"a >= 0u32"##)

    var pos = expr_1.getCondLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 10i32, 10i32, 11i32])
    pos = expr_1.getCondRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 20i32, 10i32, 21i32])
    pos = expr_1.getWhileKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 10i32])
}
}