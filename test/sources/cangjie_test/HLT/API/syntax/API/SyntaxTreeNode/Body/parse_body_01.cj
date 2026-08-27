/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: body_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Body_01() {
    let res = parseFile("./body_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"class C1 {
    let a: Int64 = 1
}"##))

    var classdecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()
    @Assert(classdecl.body.memberDecls.size, 1)
    @Assert(classdecl.body.toString().replace("\r",""), ##"{
    let a: Int64 = 1
}"##)

    var pos = classdecl.body.getLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 10i32, 9i32, 11i32])
    pos = classdecl.body.getRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 1i32, 11i32, 2i32])
}
}