/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportSingle_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportSingle_01() {
    let res = parseFile("./ImportSingle_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("import a"))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportSingle =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.identifier, "a")
        case _ => throw Exception("parse Type wrong!")
    }

    var importSingle = (sourcefile.importLists[0].contents as ImportSingle).getOrThrow()
    var pos = importSingle.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 8i32, 9i32, 9i32])
}
}