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
func test_UnsafeExpr_01() {
    let _quote = quote(unsafe { a = 1 })
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: UnsafeExpr = (sourceNode as UnsafeExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"unsafe { a = 1 }"##)
    @Assert(expr_1.block.toString(), ##"{ a = 1 }"##)

    var pos = expr_1.getUnsafePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 7i32])
}
}