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

// 根据spec不应当支持unsafe maindecl，当前支�
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MainDecl_02() {
    let str = ##"main(args: Array<String>) { 
    return
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var mainDecl = (sourceNode as MainDecl).getOrThrow()
    @Assert(mainDecl.body.nodes.size, 1)
    @Assert(mainDecl.params.params.size, 1)
    @Assert(mainDecl.params.params[0].toString(), "args: Array<String>")
    @Assert(mainDecl.retTyAnnotation.isNone())
    @Assert(mainDecl.modifiers.toString(), "[]")
}
}