/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportAll_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportAll_01() {
    let res = parseFile("./ImportAll_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("import a.*"))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportAll => @Assert(x.prefixes, ["a"])
        case _ => throw Exception("parse Type wrong!")
    }

    var import1 = sourcefile.importLists[0].contents as ImportAll
    var pos = import1.getOrThrow().getMulPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 10i32, 9i32, 11i32])
}
}