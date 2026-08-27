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

@Test
class test_01{
    @TestCase
func test_StructDecl_06() {
    let str = ##"internal struct s1<T> <: I1 & I2<T> & I3 {
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Expect(structDecl.toString().replace("\r",""), ##"internal struct s1<T> <: I1 & I2<T> & I3 {
}"##)
    @Assert(structDecl.body.memberDecls.size, 0)

    @Assert(structDecl.name, "s1")
    @Assert(structDecl.modifiers.size, 1)
    @Assert(structDecl.modifiers[0].toString(), "internal")
    @Assert(structDecl.genericConstraints.isNone())
    @Assert(structDecl.genericParams.size, 1)
    @Assert(structDecl.genericParams[0].toString(), "T")
    @Assert(structDecl.superTyAnnotations.size, 3)
    @Assert(structDecl.superTyAnnotations[0].toString(), "I1")
    @Assert(structDecl.superTyAnnotations[1].toString(), "I2<T>")
    @Assert(structDecl.superTyAnnotations[2].toString(), "I3")
    @Assert(structDecl.annotations.size, 0)
}
}