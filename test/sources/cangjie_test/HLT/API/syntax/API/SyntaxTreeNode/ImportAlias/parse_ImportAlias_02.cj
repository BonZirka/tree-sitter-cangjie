/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportAlias_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportAlias_02() {
    let res = parseFile("./ImportAlias_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("import a.b.c.d.e.f.g as x1"))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportAlias =>
            @Assert(x.prefixes, ["a", "b", "c", "d", "e", "f"])
            @Assert(x.identifier, "g")
            @Assert(x.aliasName, "x1")
        case _ => throw Exception("parse Type wrong!")
    }
}
}