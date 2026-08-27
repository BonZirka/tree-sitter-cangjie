/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: TryCatch_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TryCatch_01() {
    let res = parseFile("./TryCatch_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    try {
        a
    } catch (e: Exception) {
        b
    } finally {
        c
    }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: TryCatch = (mainDecl.body.nodes[0] as TryCatch).getOrThrow()
    @Assert(expr.tryBlock.toString().replace("\r",""), ##"{
        a
    }"##)
    @Assert(expr.catchBlocks.size, 1)
    @Assert(expr.catchBlocks[0].toString().replace("\r",""), ##"{
        b
    }"##)
    @Assert(expr.catchPatterns.size, 1)
    @Assert(expr.catchPatterns[0].toString(), "e: Exception")
    @Assert(expr.finallyBlock.isSome())
    @Assert(expr.finallyBlock.getOrThrow().toString().replace("\r",""), ##"{
        c
    }"##)
    @Assert(expr.resourceSpec.size, 0)

    var posList = expr.getCatchKeyWordsPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [12i32, 7i32, 12i32, 12i32])
    posList = expr.getCatchLParensPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [12i32, 13i32, 12i32, 14i32])
    posList = expr.getCatchRParensPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [12i32, 26i32, 12i32, 27i32])
    var pos = expr.getFinallyKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 7i32, 14i32, 14i32])
    @Assert(expr.getResourceSpecCommasPos().size == 0, true)
    @Assert(expr.getResourceSpecLParenPos().isNone())
    @Assert(expr.getResourceSpecRParenPos().isNone())
    pos = expr.getTryKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 8i32])
}
}