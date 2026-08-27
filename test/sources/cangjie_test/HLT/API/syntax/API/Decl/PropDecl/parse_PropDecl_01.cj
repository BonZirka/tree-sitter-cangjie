/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: PropDecl_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PropDecl_01() {
    let res = parseFile("./PropDecl_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"public interface I1 <: S1 {
    public static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }
    public static prop p2: R {
        get() { R() }
    }
}"##))

    var interfaceDecl: InterfaceDecl = (sourcefile.topLevelDecls[0] as InterfaceDecl).getOrThrow()

    @Assert(interfaceDecl.body.memberDecls.size, 2)
    let prop_1 = (interfaceDecl.body.memberDecls[0] as PropDecl).getOrThrow()
    let prop_2 = (interfaceDecl.body.memberDecls[1] as PropDecl).getOrThrow()
    @Assert(prop_1.toString().replace("\r",""), ##"public static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }"##)
    @Assert(prop_1.toTokens().toString().replace("\r",""), ##"public static mut prop p1: Int64 {
    get() { 0 }
    set(v) { }
}"##)
    @Assert(prop_1.name, "p1")
    @Assert(prop_1.getter.getOrThrow().toString(), "get() {0}")
    @Assert(prop_1.setter.isSome())
    @Assert(prop_1.setter.getOrThrow().toString(), "set(v) {}")
    @Assert(prop_1.tyAnnotation.toString(), "Int64")
    @Assert(prop_1.tyAnnotation is AtomicType)
    @Assert(prop_1.isMut)

    @Assert(prop_2.toString().replace("\r",""), ##"public static prop p2: R {
        get() { R() }
    }"##)
    @Assert(prop_2.name, "p2")
    @Assert(prop_2.getter.getOrThrow().toString(), "get() { R() }")
    @Assert(prop_2.setter.isNone())
    @Assert(prop_2.tyAnnotation.toString(), "R")
    @Assert(prop_2.tyAnnotation is CompositeType)
    @Assert(prop_2.isMut, false)

    var pos = prop_1.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 28i32, 10i32, 30i32])
    pos = prop_1.getLCurlPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 38i32, 10i32, 39i32])
    pos = prop_1.getPropKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 23i32, 10i32, 27i32])
    pos = prop_1.getRCurlPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 5i32, 13i32, 6i32])
    pos = prop_1.getTyAnnotationColonPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 30i32, 10i32, 31i32])
}
}