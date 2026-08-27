/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ImportMulti_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportMulti_03() {
    let res = parseFile("./ImportMulti_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"import {
    std.time as atime,
}"##))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportMulti =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.contents.size, 1)
            @Assert(x.contents[0] is ImportAlias)
            let _import_1: ImportAlias = (x.contents[0] as ImportAlias).getOrThrow()
            @Assert(_import_1.prefixes, ["std"])
            @Assert(_import_1.identifier, "time")
            @Assert(_import_1.aliasName, "atime")
        case _ => throw Exception("parse Type wrong!")
    }
}
}