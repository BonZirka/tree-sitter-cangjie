/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_UnsafeExpr_02() {
    let _quote = quote(unsafe {
        let str = LibC.mallocString("abc")
        str.free()
    })
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: UnsafeExpr = (sourceNode as UnsafeExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"unsafe {
    let str = LibC.mallocString("abc")
    str.free()
}"##)
    @Assert(expr_1.block.toString().replace("\r",""), ##"{
    let str = LibC.mallocString("abc")
    str.free()
}"##)
}
}