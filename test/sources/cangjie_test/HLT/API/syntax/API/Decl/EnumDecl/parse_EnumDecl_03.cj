/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: EnumDecl_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_EnumDecl_03() {
    let res = parseFile("./EnumDecl_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"protected enum E1<T, U> <: S1<T, U> {
    A1 | B1(Int64) | C1(T) | D1(U, T)
    mut prop p1: ?T {
        get() { none }
        set(v) {}
    }
    static func foo<S>() {}
}"##))

    var enumDecl: EnumDecl = (sourcefile.topLevelDecls[0] as EnumDecl).getOrThrow()
    @Expect(enumDecl.toString().replace("\r",""), ##"protected enum E1<T, U> <: S1<T, U> {
    A1 | B1(Int64) | C1(T) | D1(U, T)
    mut prop p1: ?T {
        get() { none }
        set(v) {}
    }
    static func foo<S>() {}
}"##)
    @Assert(enumDecl.body.memberDecls.size, 6)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1(Int64)"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(T)"##)
    @Assert(enumDecl.body.memberDecls[3] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[3].toString(), ##"D1(U, T)"##)

    @Assert(enumDecl.body.memberDecls[4] is PropDecl)
    @Assert(enumDecl.body.memberDecls[4].toString().replace("\r",""), ##"mut prop p1: ?T {
        get() { none }
        set(v) {}
    }"##)
    @Assert(enumDecl.body.memberDecls[5] is FuncDecl)
    @Assert(enumDecl.body.memberDecls[5].toString(), ##"static func foo<S>() {}"##)

    @Assert(enumDecl.name, "E1")
    @Assert(enumDecl.isNonExhaustive, false)
    @Assert(enumDecl.modifiers.size, 1)
    @Assert(enumDecl.modifiers[0].toString(), "protected")
    @Assert(enumDecl.genericConstraints.isNone())
    @Assert(enumDecl.genericParams.size, 2)
    @Assert(enumDecl.genericParams[0].toString(), ##"T"##)
    @Assert(enumDecl.genericParams[1].toString(), ##"U"##)
    @Assert(enumDecl.superTyAnnotations.size, 1)
    @Assert(enumDecl.superTyAnnotations[0].toString(), ##"S1<T, U>"##)
    @Assert(enumDecl.annotations.size, 0)
}
}