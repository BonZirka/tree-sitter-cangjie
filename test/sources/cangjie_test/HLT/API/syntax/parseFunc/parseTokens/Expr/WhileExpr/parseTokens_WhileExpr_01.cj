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
func test_WhileExpr_01() {
    let _quote = quote(while(a >= 0u32) {
    b
})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var expr_1: WhileExpr = (sourceNode as WhileExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"while(a >= 0u32) {
    b
}"##)
    @Assert(expr_1.body.toString().replace("\r",""), ##"{
    b
}"##)
    @Assert(expr_1.condition.toString(), ##"a >= 0u32"##)

    var pos = expr_1.getCondLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 6i32, 1i32, 7i32])
    pos = expr_1.getCondRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 16i32, 1i32, 17i32])
    pos = expr_1.getWhileKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 6i32])
}
}