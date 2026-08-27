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
func test_StaticInit_01() {
    let str = ##"static init() {}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var staticInit: StaticInit = (sourceNode as StaticInit).getOrThrow()

    @Assert(staticInit.toString(), ##"static init() {}"##)
    @Assert(staticInit.body.nodes.size, 0)

    var pos = staticInit.getInitKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 8i32, 1i32, 12i32])
    pos = staticInit.getParamsLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 12i32, 1i32, 13i32])
    pos = staticInit.getParamsRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 13i32, 1i32, 14i32])
    pos = staticInit.getStaticKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 7i32])
}
}