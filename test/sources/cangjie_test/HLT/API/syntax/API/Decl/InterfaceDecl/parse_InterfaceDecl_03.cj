/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: InterfaceDecl_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_InterfaceDecl_03() {
    let res = parseFile("./InterfaceDecl_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"protected interface I1<T, U> <: I2 & I3<T> where T <: C1<T, Int64>, U <: C2 & C3<T> & ToString {
}"##))

    var interfaceDecl: InterfaceDecl = (sourcefile.topLevelDecls[0] as InterfaceDecl).getOrThrow()
    @Expect(interfaceDecl.toString().replace("\r",""), ##"protected interface I1<T, U> <: I2 & I3<T> where T <: C1<T, Int64>, U <: C2 & C3<T> & ToString {
}"##)
    @Assert(interfaceDecl.body.memberDecls.size, 0)

    @Assert(interfaceDecl.name, "I1")
    @Assert(interfaceDecl.genericConstraints.isSome())
    @Assert(interfaceDecl.genericConstraints.getOrThrow().toString(), "where T <: C1<T, Int64>, U <: C2 & C3<T> & ToString")
    @Assert(interfaceDecl.genericParams.size, 2)
    @Assert(interfaceDecl.genericParams[0].toString(), "T")
    @Assert(interfaceDecl.genericParams[1].toString(), "U")
    @Assert(interfaceDecl.superTyAnnotations.size, 2)
    @Assert(interfaceDecl.superTyAnnotations[0].toString(), "I2")
    @Assert(interfaceDecl.superTyAnnotations[1].toString(), "I3<T>")
    @Assert(interfaceDecl.annotations.size, 0)
    @Assert(interfaceDecl.modifiers.toString(), ##"[protected]"##)
}
}