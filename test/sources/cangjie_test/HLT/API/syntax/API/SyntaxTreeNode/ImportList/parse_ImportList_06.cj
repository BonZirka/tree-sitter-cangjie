/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ImportList_06.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportList_06() {
    let res = parseFile("./ImportList_06.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"import A.B.C.D.E.F.G.H.*
import {
    std.time,
}
import {a, b.a, c.b.a, d.c.b.a as _d_c_b_a}"##))
    @Assert(sourcefile.importLists.size, 3)
    var import_1: ImportList = sourcefile.importLists[0]
    var import_2: ImportList = sourcefile.importLists[1]
    var import_3: ImportList = sourcefile.importLists[2]
    @Assert(import_1.contents is ImportAll)
    match (import_1.kind) {
        case ImportKind.All => ()
        case _ => @Assert(false)
    }
    @Assert(import_1.modifier.isNone())
    @Assert(import_1.toString(), ##"import A.B.C.D.E.F.G.H.*"##)

    @Assert(import_2.contents is ImportMulti)
    match (import_2.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    @Assert(import_2.modifier.isNone())
    @Expect(import_2.toString().replace("\r",""), ##"import {
    std.time,
}"##)

    @Assert(import_3.contents is ImportMulti)
    match (import_3.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    @Assert(import_3.modifier.isNone())
    @Expect(import_3.toString(), ##"import {a, b.a, c.b.a, d.c.b.a as _d_c_b_a}"##)
}
}