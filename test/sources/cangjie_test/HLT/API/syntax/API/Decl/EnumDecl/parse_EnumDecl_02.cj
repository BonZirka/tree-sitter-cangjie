/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: EnumDecl_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_EnumDecl_02() {
    let res = parseFile("./EnumDecl_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"@Deprecated["aaa", strict: true]
public enum E1<T> <: I1<T> & I2 where T <: ToString{
    A1 | B1 | C1(T) | D1(Int64, T) | ...
    static prop p1: ?T {
        get() { none }
    }
    static func foo() {}
}"##))

    var enumDecl: EnumDecl = (sourcefile.topLevelDecls[0] as EnumDecl).getOrThrow()
    @Expect(enumDecl.toString().replace("\r",""), ##"@Deprecated["aaa", strict: true]
public enum E1<T> <: I1<T> & I2 where T <: ToString{
    A1 | B1 | C1(T) | D1(Int64, T) | ...
    static prop p1: ?T {
        get() { none }
    }
    static func foo() {}
}"##)
    @Assert(enumDecl.body.memberDecls.size, 6)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(T)"##)
    @Assert(enumDecl.body.memberDecls[3] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[3].toString(), ##"D1(Int64, T)"##)

    @Assert(enumDecl.body.memberDecls[4] is PropDecl)
    @Assert(enumDecl.body.memberDecls[4].toString().replace("\r",""), ##"static prop p1: ?T {
        get() { none }
    }"##)
    @Assert(enumDecl.body.memberDecls[5] is FuncDecl)
    @Assert(enumDecl.body.memberDecls[5].toString(), ##"static func foo() {}"##)

    @Assert(enumDecl.name, "E1")
    @Assert(enumDecl.isNonExhaustive, true)
    @Assert(enumDecl.modifiers.size, 1)
    @Assert(enumDecl.modifiers[0].toString(), "public")
    @Assert(enumDecl.genericConstraints.isSome())
    @Assert(enumDecl.genericConstraints.getOrThrow().toString(), ##"where T <: ToString"##)
    @Assert(enumDecl.genericParams.size, 1)
    @Assert(enumDecl.genericParams[0].toString(), ##"T"##)
    @Assert(enumDecl.superTyAnnotations.size, 2)
    @Assert(enumDecl.superTyAnnotations[0].toString(), ##"I1<T>"##)
    @Assert(enumDecl.superTyAnnotations[1].toString(), ##"I2"##)
    @Assert(enumDecl.annotations.size, 1)
    @Assert(enumDecl.annotations[0].toString(), ##"@Deprecated["aaa", strict: true]"##)
}
}