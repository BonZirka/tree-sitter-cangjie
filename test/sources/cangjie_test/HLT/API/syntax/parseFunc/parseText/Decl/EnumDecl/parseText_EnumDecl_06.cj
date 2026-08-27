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

let str = ##"enum a_b <: I1 & I2 {
    A1(T, T) 
    | B1 (T, U) |
    C1(U, U) | D1((Int64, Int64))
}
"##

@Test
class test_01{
    @TestCase
func test_EnumDecl_06() {
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var enumDecl: EnumDecl = (sourceNode as EnumDecl).getOrThrow()

    @Expect(enumDecl.toString().replace("\r",""), ##"enum a_b <: I1 & I2 {
    A1(T, T)
    | B1 (T, U) |
    C1(U, U) | D1((Int64, Int64))
}"##)
    @Assert(enumDecl.body.memberDecls.size, 4)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1(T, T)"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1 (T, U)"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(U, U)"##)
    @Assert(enumDecl.body.memberDecls[3] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[3].toString(), ##"D1((Int64, Int64))"##)

    @Assert(enumDecl.name, "a_b")
    @Assert(enumDecl.isNonExhaustive, false)
    @Assert(enumDecl.modifiers.size, 0)
    @Assert(enumDecl.genericConstraints.isNone())
    @Assert(enumDecl.genericParams.size, 0)
    @Assert(enumDecl.superTyAnnotations.size, 2)
    @Assert(enumDecl.superTyAnnotations[0].toString(), ##"I1"##)
    @Assert(enumDecl.superTyAnnotations[1].toString(), ##"I2"##)
    @Assert(enumDecl.annotations.size, 0)
}
}