/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: MainDecl_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MainDecl_03() {
    let res = parseFile("./MainDecl_03.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().contains(##"main() {}"##))

    var mainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    @Expect(mainDecl.toString(), ##"main() {}"##)
    @Assert(mainDecl.body.nodes.size, 0)
    @Assert(mainDecl.params.params.size, 0)
    @Assert(mainDecl.retTyAnnotation.isNone())
    @Assert(mainDecl.modifiers.toString(), "[]")
}
}