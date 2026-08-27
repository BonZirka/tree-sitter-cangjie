/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportMulti_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportMulti_01() {
    let res = parseFile("./ImportMulti_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"import {
    std.time,
}"##))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportMulti =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.contents.size, 1)
            @Assert(x.contents[0] is ImportSingle)
            let _import_1: ImportSingle = (x.contents[0] as ImportSingle).getOrThrow()
            @Assert(_import_1.prefixes, ["std"])
            @Assert(_import_1.identifier, "time")
        case _ => throw Exception("parse Type wrong!")
    }

    var importMulti = (sourcefile.importLists[0].contents as ImportMulti).getOrThrow()
    var posList = importMulti.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [10i32, 13i32, 10i32, 14i32])
    var pos = importMulti.getLCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 8i32, 9i32, 9i32])
    pos = importMulti.getRCurlPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 1i32, 11i32, 2i32])
}
}