/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_InterfaceDecl_01() {
    let _quote = quote(@Deprecated["aaa"]
public interface I1<T> <: S1<T> where T <: I2<T> {
    mut prop p1: Int64
    func foo(): Int64
})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var interfaceDecl: InterfaceDecl = (sourceNode as InterfaceDecl).getOrThrow()
    interfaceDecl.toString() |> println
    @Expect(interfaceDecl.toString().replace("\r",""), ##"@Deprecated["aaa"]
public interface I1 < T > <: S1 < T > where T <: I2 < T > {
    mut prop p1: Int64
    func foo(): Int64
}"##)
    @Assert(interfaceDecl.body.memberDecls.size, 2)
    @Assert(interfaceDecl.body.memberDecls[0] is PropDecl)
    @Assert(interfaceDecl.body.memberDecls[0].toString(), ##"mut prop p1: Int64"##)
    @Assert(interfaceDecl.body.memberDecls[1] is FuncDecl)
    @Assert(interfaceDecl.body.memberDecls[1].toString(), ##"func foo(): Int64"##)

    @Assert(interfaceDecl.name, "I1")
    @Assert(interfaceDecl.genericConstraints.isSome())
    @Assert(interfaceDecl.genericConstraints.getOrThrow().toString(), "where T <: I2 < T >")
    @Assert(interfaceDecl.genericParams.size, 1)
    @Assert(interfaceDecl.genericParams[0].toString(), "T")
    @Assert(interfaceDecl.superTyAnnotations.size, 1)
    @Assert(interfaceDecl.superTyAnnotations[0].toString(), "S1 < T >")
    @Assert(interfaceDecl.annotations.size, 1)
    @Assert(interfaceDecl.annotations[0].toString(), ##"@Deprecated["aaa"]"##)
}
}