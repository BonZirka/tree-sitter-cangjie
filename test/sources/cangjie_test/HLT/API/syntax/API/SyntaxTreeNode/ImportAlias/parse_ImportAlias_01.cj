/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportAlias_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportAlias_01() {
    let res = parseFile("./ImportAlias_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("import a as pkgA"))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportAlias =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.identifier, "a")
            @Assert(x.aliasName, "pkgA")
        case _ => throw Exception("parse Type wrong!")
    }

    var import1 = (sourcefile.importLists[0].contents as ImportAlias).getOrThrow()
    var pos = import1.getAliasNamePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 13i32, 9i32, 17i32])
    pos = import1.getAsPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 10i32, 9i32, 12i32])
    pos = import1.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 8i32, 9i32, 9i32])
}
}