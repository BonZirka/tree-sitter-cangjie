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
func test_DoWhileExpr_01() {
    let str = ##"do {
    print(a)
    break
} while (b == cc && a > 0)"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: DoWhileExpr = (sourceNode as DoWhileExpr).getOrThrow()
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
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [4i32, 9i32, 4i32, 10i32])
    pos = expr_1.getCondRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [4i32, 26i32, 4i32, 27i32])
    pos = expr_1.getDoKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 3i32])
    pos = expr_1.getWhileKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [4i32, 3i32, 4i32, 8i32])
}
}