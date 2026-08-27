/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: DoWhileExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_DoWhileExpr_01() {
    let res = parseFile("./DoWhileExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    do {
        print(a)
        break
    } while (b == cc && a > 0)
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: DoWhileExpr = (mainDecl.body.nodes[0] as DoWhileExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"do {
        print(a)
        break
    } while (b == cc && a > 0)"##)
    @Assert(expr_1.body.toString().replace("\r",""), ##"{
        print(a)
        break
    }"##)
    @Assert(expr_1.condition.toString(), ##"b == cc && a > 0"##)

    var pos = expr_1.getCondLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 13i32, 13i32, 14i32])
    pos = expr_1.getCondRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 30i32, 13i32, 31i32])
    pos = expr_1.getDoKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 7i32])
    pos = expr_1.getWhileKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 7i32, 13i32, 12i32])
}
}