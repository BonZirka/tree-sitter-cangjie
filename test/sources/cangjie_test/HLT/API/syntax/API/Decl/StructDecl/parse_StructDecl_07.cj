/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: StructDecl_07.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_StructDecl_07() {
    let res = parseFile("./StructDecl_07.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"@!Anno1
@!Anno1
struct s1<T> <: I1<T> & I2<T> & I3<T> {
}"##))

    var structDecl: StructDecl = (sourcefile.topLevelDecls[0] as StructDecl).getOrThrow()
    @Expect(structDecl.toString().replace("\r",""), ##"@!Anno1
@!Anno1
struct s1<T> <: I1<T> & I2<T> & I3<T> {
}"##)
    @Assert(structDecl.body.memberDecls.size, 0)

    @Assert(structDecl.name, "s1")
    @Assert(structDecl.modifiers.size, 0)
    @Assert(structDecl.genericConstraints.isNone())
    @Assert(structDecl.genericParams.size, 1)
    @Assert(structDecl.genericParams[0].toString(), "T")
    @Assert(structDecl.superTyAnnotations.size, 3)
    @Assert(structDecl.superTyAnnotations[0].toString(), "I1<T>")
    @Assert(structDecl.superTyAnnotations[1].toString(), "I2<T>")
    @Assert(structDecl.superTyAnnotations[2].toString(), "I3<T>")
    @Assert(structDecl.annotations.size, 2)
}
}