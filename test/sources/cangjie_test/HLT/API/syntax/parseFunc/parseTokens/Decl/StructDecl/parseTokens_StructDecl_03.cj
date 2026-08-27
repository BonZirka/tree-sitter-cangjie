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

@Test
class test_01{
    @TestCase
func test_StructDecl_03() {
    let _quote = quote(@When[ backend == "linux" ]
public struct a_b<T, U> <: S1<T, U> where T <: ToString, U <: ToString{
    public let s1: Int64
    mut prop p1: Int64 {
        get() { 0 }
        set(v) {}
    }
    public init() { s1 = 0 }
    func foo<S>(a: T): T {
        return a
    }
})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Assert(structDecl.toString().replace("\r",""), ##"@When[backend == "linux"]
public struct a_b < T, U > <: S1 < T, U > where T <: ToString, U <: ToString {
    public let s1: Int64
    mut prop p1: Int64 {
        get() { 0 }
        set(v) { }
    }
    public init() { s1 = 0 }
    func foo < S >(a: T): T {
        return a
    }
}"##)
    @Assert(structDecl.body.memberDecls.size, 4)
    @Assert(structDecl.body.memberDecls[0] is VarDecl)
    @Assert(structDecl.body.memberDecls[0].toString(), ##"public let s1: Int64"##)
    @Assert(structDecl.body.memberDecls[1] is PropDecl)
    @Assert(structDecl.body.memberDecls[1].toString().replace("\r",""), ##"mut prop p1: Int64 {
        get() { 0 }
        set(v) { }
    }"##)
    @Assert(structDecl.body.memberDecls[2] is FuncDecl)
    @Assert(structDecl.body.memberDecls[2].toString(), ##"public init() { s1 = 0 }"##)
    @Assert(structDecl.body.memberDecls[3] is FuncDecl)
    @Assert(structDecl.body.memberDecls[3].toString().replace("\r",""), ##"func foo < S >(a: T): T {
        return a
    }"##)

    @Assert(structDecl.name, "a_b")
    @Assert(structDecl.modifiers.size, 1)
    @Assert(structDecl.modifiers[0].toString(), "public")
    @Assert(structDecl.genericConstraints.isSome())
    @Assert(structDecl.genericConstraints.getOrThrow().toString(), "where T <: ToString, U <: ToString")
    @Assert(structDecl.genericParams.size, 2)
    @Assert(structDecl.genericParams[0].toString(), "T")
    @Assert(structDecl.genericParams[1].toString(), "U")
    @Assert(structDecl.superTyAnnotations.size, 1)
    @Assert(structDecl.superTyAnnotations[0].toString(), "S1 < T, U >")
    @Assert(structDecl.annotations.size, 1)
    @Assert(structDecl.annotations[0].toString(), ##"@When[backend == "linux"]"##)
}
}