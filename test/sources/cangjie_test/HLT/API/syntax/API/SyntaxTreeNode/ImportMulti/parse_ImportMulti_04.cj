/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ImportMulti_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportMulti_04() {
    let res = parseFile("./ImportMulti_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"import {
    std.time,
    std.fs as fileSystem,
    std.io.*,
}"##))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportMulti =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.contents.size, 3)
            @Assert(x.contents[0] is ImportSingle)
            let _import_1: ImportSingle = (x.contents[0] as ImportSingle).getOrThrow()
            @Assert(_import_1.prefixes, ["std"])
            @Assert(_import_1.identifier, "time")

            @Assert(x.contents[1] is ImportAlias)
            let _import_2: ImportAlias = (x.contents[1] as ImportAlias).getOrThrow()
            @Assert(_import_2.prefixes, ["std"])
            @Assert(_import_2.identifier, "fs")
            @Assert(_import_2.aliasName, "fileSystem")

            @Assert(x.contents[2] is ImportAll)
            let _import_3: ImportAll = (x.contents[2] as ImportAll).getOrThrow()
            @Assert(_import_3.prefixes, ["std", "io"])
        case _ => throw Exception("parse Type wrong!")
    }
}
}