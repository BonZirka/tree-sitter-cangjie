/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// DEPENDENCE: ImportMulti_08.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportMulti_08() {
    let res = parseFile("./ImportMulti_08.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("import {a, b.a, c.b.a, d.c.b.a as _d_c_b_a}"))
    @Assert(sourcefile.importLists.size, 1)
    match (sourcefile.importLists[0].contents) {
        case x: ImportMulti =>
            @Assert(x.prefixes.size, 0)
            @Assert(x.contents.size, 4)
            @Assert(x.contents[0] is ImportSingle)
            let _import_1: ImportSingle = (x.contents[0] as ImportSingle).getOrThrow()
            @Assert(_import_1.prefixes.size, 0)
            @Assert(_import_1.identifier, "a")

            @Assert(x.contents[1] is ImportSingle)
            let _import_2: ImportSingle = (x.contents[1] as ImportSingle).getOrThrow()
            @Assert(_import_2.prefixes, ["b"])
            @Assert(_import_2.identifier, "a")

            @Assert(x.contents[2] is ImportSingle)
            let _import_3: ImportSingle = (x.contents[2] as ImportSingle).getOrThrow()
            @Assert(_import_3.prefixes, ["c", "b"])
            @Assert(_import_3.identifier, "a")

            @Assert(x.contents[3] is ImportAlias)
            let _import_4: ImportAlias = (x.contents[3] as ImportAlias).getOrThrow()
            @Assert(_import_4.prefixes, ["d", "c", "b"])
            @Assert(_import_4.identifier, "a")
            @Assert(_import_4.aliasName, "_d_c_b_a")

        case _ => throw Exception("parse Type wrong!")
    }
}
}