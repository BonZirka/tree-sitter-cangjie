/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ImportList_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportList_03() {
    let res = parseFile("./ImportList_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"protected import a.b.c.d.e.f.g as a_b_c_d_e_f_g
protected import {
    std.time000.*,
}
protected import std.a.b.c.d.{
    time,
    fs as fileSystem,
    io.*,
    collection.HashMap.HashMap
}
protected import a.a.a._a.a.a.a.a.a._a.a.a.a"##))
    @Assert(sourcefile.importLists.size, 4)
    var import_1: ImportList = sourcefile.importLists[0]
    var import_2: ImportList = sourcefile.importLists[1]
    var import_3: ImportList = sourcefile.importLists[2]
    var import_4: ImportList = sourcefile.importLists[3]
    @Assert(import_1.contents is ImportAlias)
    match (import_1.kind) {
        case ImportKind.Alias => ()
        case _ => @Assert(false)
    }
    match (import_1.modifier.getOrThrow().kind) {
        case ModifierKind.Protected => ()
        case _ => @Assert(false)
    }
    @Assert(import_1.toString(), ##"protected import a.b.c.d.e.f.g as a_b_c_d_e_f_g"##)

    @Assert(import_2.contents is ImportMulti)
    match (import_2.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    match (import_2.modifier.getOrThrow().kind) {
        case ModifierKind.Protected => ()
        case _ => @Assert(false)
    }
    @Expect(import_2.toString().replace("\r",""), ##"protected import {
    std.time000.*,
}"##)

    @Assert(import_3.contents is ImportMulti)
    match (import_3.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    match (import_3.modifier.getOrThrow().kind) {
        case ModifierKind.Protected => ()
        case _ => @Assert(false)
    }
    @Expect(import_3.toString().replace("\r",""), ##"protected import std.a.b.c.d.{
    time,
    fs as fileSystem,
    io.*,
    collection.HashMap.HashMap
}"##)

    @Assert(import_4.contents is ImportSingle)
    match (import_4.kind) {
        case ImportKind.Single => ()
        case _ => @Assert(false)
    }
    match (import_4.modifier.getOrThrow().kind) {
        case ModifierKind.Protected => ()
        case _ => @Assert(false)
    }
    @Expect(import_4.toString(), ##"protected import a.a.a._a.a.a.a.a.a._a.a.a.a"##)
}
}