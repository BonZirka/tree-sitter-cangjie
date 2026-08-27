/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Block_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Block_01() {
    let res = parseFile("./Block_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"func foo(){
    { => 100}()
}"##))

    var funcdecl_1 = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    let block = funcdecl_1.body.getOrThrow()
    @Assert(block.toString().replace("\r",""), ##"{
    { => 100}()
}"##)
    @Assert(block.nodes.size, 1)
    @Assert(block.nodes[0] is CallExpr)

    var pos = block.getLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 11i32, 9i32, 12i32])
    pos = block.getRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 1i32, 11i32, 2i32])
}
}