/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ImportList_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportList_05() {
    let res = parseFile("./ImportList_05.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"private import a as pkgA
private import std.{
    time,
    fs as fileSystem,
    io.*,
    collection.HashMap
}
private import a"##))
    @Assert(sourcefile.importLists.size, 3)
    var import_1: ImportList = sourcefile.importLists[0]
    var import_2: ImportList = sourcefile.importLists[1]
    var import_3: ImportList = sourcefile.importLists[2]
    @Assert(import_1.contents is ImportAlias)
    match (import_1.kind) {
        case ImportKind.Alias => ()
        case _ => @Assert(false)
    }
    match (import_1.modifier.getOrThrow().kind) {
        case ModifierKind.Private => ()
        case _ => @Assert(false)
    }
    @Assert(import_1.toString(), ##"private import a as pkgA"##)

    @Assert(import_2.contents is ImportMulti)
    match (import_2.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    match (import_2.modifier.getOrThrow().kind) {
        case ModifierKind.Private => ()
        case _ => @Assert(false)
    }
    @Expect(import_2.toString().replace("\r",""), ##"private import std.{
    time,
    fs as fileSystem,
    io.*,
    collection.HashMap
}"##)

    @Assert(import_3.contents is ImportSingle)
    match (import_3.kind) {
        case ImportKind.Single => ()
        case _ => @Assert(false)
    }
    match (import_3.modifier.getOrThrow().kind) {
        case ModifierKind.Private => ()
        case _ => @Assert(false)
    }
    @Expect(import_3.toString(), ##"private import a"##)
}
}