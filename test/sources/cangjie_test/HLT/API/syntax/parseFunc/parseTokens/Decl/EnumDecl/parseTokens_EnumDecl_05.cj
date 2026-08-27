/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let _quote = quote(private enum My_Enum<T, U> <: I1<T> & I2<T> & I3<T> where T <: I1<T>, U<: I2<T> & I1<U> {
    A1(T, T) 
    | B1 (T, U) |
    C1(U, U) | ...
})

@Test
class test_01{
    @TestCase
func test_EnumDecl_05() {
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var enumDecl: EnumDecl = (sourceNode as EnumDecl).getOrThrow()

    @Expect(enumDecl.toString().replace("\r",""), ##"private enum My_Enum < T, U > <: I1 < T > & I2 < T > & I3 < T > where T <: I1 < T >, U <: I2 < T > & I1 < U > {
    A1(T, T)
    | B1(T, U) |
    C1(U, U) | ...
}"##)
    @Assert(enumDecl.body.memberDecls.size, 3)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1(T, T)"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1(T, U)"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(U, U)"##)

    @Assert(enumDecl.name, "My_Enum")
    @Assert(enumDecl.isNonExhaustive, true)
    @Assert(enumDecl.modifiers.size, 1)
    @Assert(enumDecl.modifiers[0].toString(), "private")
    @Assert(enumDecl.genericConstraints.isSome())
    @Assert(enumDecl.genericConstraints.getOrThrow().toString(), ##"where T <: I1 < T >, U <: I2 < T > & I1 < U >"##)
    @Assert(enumDecl.genericParams.size, 2)
    @Assert(enumDecl.genericParams[0].toString(), ##"T"##)
    @Assert(enumDecl.genericParams[1].toString(), ##"U"##)
    @Assert(enumDecl.superTyAnnotations.size, 3)
    @Assert(enumDecl.superTyAnnotations[0].toString(), ##"I1 < T >"##)
    @Assert(enumDecl.superTyAnnotations[1].toString(), ##"I2 < T >"##)
    @Assert(enumDecl.superTyAnnotations[2].toString(), ##"I3 < T >"##)
    @Assert(enumDecl.annotations.size, 0)
}
}