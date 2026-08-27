/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ImportList_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ImportList_04() {
    let res = parseFile("./ImportList_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"internal import a.b.c.d.e.f.g as x1
internal import {
    std.time as atime
}
internal import {a, b.a, c.b.a, d.c.b.a as _d_c_b_a}
internal import a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.q.r.s.t.u.v.w.x.y.z"##))
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
        case ModifierKind.Internal => ()
        case _ => @Assert(false)
    }
    @Assert(import_1.toString(), ##"internal import a.b.c.d.e.f.g as x1"##)

    @Assert(import_2.contents is ImportMulti)
    match (import_2.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    match (import_2.modifier.getOrThrow().kind) {
        case ModifierKind.Internal => ()
        case _ => @Assert(false)
    }
    @Expect(import_2.toString().replace("\r",""), ##"internal import {
    std.time as atime
}"##)

    @Assert(import_3.contents is ImportMulti)
    match (import_3.kind) {
        case ImportKind.Multi => ()
        case _ => @Assert(false)
    }
    match (import_3.modifier.getOrThrow().kind) {
        case ModifierKind.Internal => ()
        case _ => @Assert(false)
    }
    @Expect(import_3.toString(), ##"internal import {a, b.a, c.b.a, d.c.b.a as _d_c_b_a}"##)

    @Assert(import_4.contents is ImportSingle)
    match (import_4.kind) {
        case ImportKind.Single => ()
        case _ => @Assert(false)
    }
    match (import_4.modifier.getOrThrow().kind) {
        case ModifierKind.Internal => ()
        case _ => @Assert(false)
    }
    @Expect(import_4.toString(), ##"internal import a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.q.r.s.t.u.v.w.x.y.z"##)
}
}