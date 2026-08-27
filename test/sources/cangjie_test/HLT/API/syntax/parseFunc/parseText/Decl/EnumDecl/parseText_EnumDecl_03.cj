/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let str = ##"protected enum E1<T, U> <: S1<T, U> {
    A1 | B1(Int64) | C1(T) | D1(U, T)
    mut prop p1: ?T {
        get() { none }
        set(v) {}
    }
    static func foo<S>() {}
}"##

@Test
class test_01{
    @TestCase
func test_EnumDecl_03() {
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var enumDecl: EnumDecl = (sourceNode as EnumDecl).getOrThrow()

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