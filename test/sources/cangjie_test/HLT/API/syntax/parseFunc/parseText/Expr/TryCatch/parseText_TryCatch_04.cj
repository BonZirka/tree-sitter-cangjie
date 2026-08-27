/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TryCatch_04() {
    let str = ##"try (input = MyResource(),
    output = MyResource()) {
    while (input.hasNextLine()) {
        let lineString = input.readLine()
        output.writeLine(lineString)
    }
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr: TryCatch = (sourceNode as TryCatch).getOrThrow()
    @Assert(expr.toString().replace("\r",""), ##"try (input = MyResource(),
    output = MyResource()) {
    while (input.hasNextLine()) {
        let lineString = input.readLine()
        output.writeLine(lineString)
    }
}"##)
    @Assert(expr.tryBlock.toString().replace("\r",""), ##"{
    while (input.hasNextLine()) {
        let lineString = input.readLine()
        output.writeLine(lineString)
    }
}"##)
    @Assert(expr.catchBlocks.size, 0)
    @Expect(expr.catchPatterns.size, 0)
    @Assert(expr.finallyBlock.isNone())
    @Assert(expr.resourceSpec.size, 2)
    @Assert(expr.resourceSpec[0].toString(), "input = MyResource()")
    @Assert(expr.resourceSpec[1].toString(), "output = MyResource()")
}
}