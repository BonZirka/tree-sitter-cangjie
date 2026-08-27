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
    let _quote = quote(try {
    a
} catch (e: Exception) {
    b
} finally {
    c
})
    let res = parseTokens(_quote)
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
}
}