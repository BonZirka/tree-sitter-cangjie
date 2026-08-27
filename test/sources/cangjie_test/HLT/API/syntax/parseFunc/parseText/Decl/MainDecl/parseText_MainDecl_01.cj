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
func test_MainDecl_01() {
    let str = ##"main(): Int64 {
    let a: Int64 = 0
    return a
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var mainDecl = (sourceNode as MainDecl).getOrThrow()
    @Assert(mainDecl.toString().replace("\r", ""), ##"main(): Int64 {
    let a: Int64 = 0
    return a
}"##)
    @Assert(mainDecl.body.nodes.size, 2)
    @Assert(mainDecl.params.params.size, 0)
    @Assert(mainDecl.retTyAnnotation.isSome())
    @Assert(mainDecl.retTyAnnotation.getOrThrow() is AtomicType)

    var pos = mainDecl.getMainKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 5i32])
    pos = mainDecl.getRetTyAnnotationColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 7i32, 1i32, 8i32])
}
}