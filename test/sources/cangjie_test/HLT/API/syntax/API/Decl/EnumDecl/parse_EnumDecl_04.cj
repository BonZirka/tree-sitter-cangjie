/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: EnumDecl_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_EnumDecl_04() {
    let res = parseFile("./EnumDecl_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"internal enum E1<A, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z> {
    | A1 | B1(Int64)
    | C1(T) | D1(U, T)
}"##))

    var enumDecl: EnumDecl = (sourcefile.topLevelDecls[0] as EnumDecl).getOrThrow()
    @Expect(enumDecl.toString().replace("\r",""), ##"internal enum E1<A, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z> {
    | A1 | B1(Int64)
    | C1(T) | D1(U, T)
}"##)
    @Assert(enumDecl.body.memberDecls.size, 4)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1(Int64)"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(T)"##)
    @Assert(enumDecl.body.memberDecls[3] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[3].toString(), ##"D1(U, T)"##)

    @Assert(enumDecl.name, "E1")
    @Assert(enumDecl.isNonExhaustive, false)
    @Assert(enumDecl.modifiers.size, 1)
    @Assert(enumDecl.modifiers[0].toString(), "internal")
    @Assert(enumDecl.genericConstraints.isNone())
    @Assert(enumDecl.genericParams.size, 26)
    @Assert(enumDecl.genericParams[0].toString(), ##"A"##)
    @Assert(enumDecl.genericParams[25].toString(), ##"Z"##)
    @Assert(enumDecl.superTyAnnotations.size, 0)
    @Assert(enumDecl.annotations.size, 0)
}
}