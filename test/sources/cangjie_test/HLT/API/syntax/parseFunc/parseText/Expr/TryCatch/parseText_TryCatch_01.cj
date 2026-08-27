/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TryCatch_01() {
    let str = ##"try {
    a
} catch (e: Exception) {
    b
} finally {
    c
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr: TryCatch = (sourceNode as TryCatch).getOrThrow()
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
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [3i32, 3i32, 3i32, 8i32])
    posList = expr.getCatchLParensPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [3i32, 9i32, 3i32, 10i32])
    posList = expr.getCatchRParensPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [3i32, 22i32, 3i32, 23i32])
    var pos = expr.getFinallyKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [5i32, 3i32, 5i32, 10i32])
    @Assert(expr.getResourceSpecCommasPos().size == 0, true)
    @Assert(expr.getResourceSpecLParenPos().isNone())
    @Assert(expr.getResourceSpecRParenPos().isNone())
    pos = expr.getTryKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 4i32])
}
}