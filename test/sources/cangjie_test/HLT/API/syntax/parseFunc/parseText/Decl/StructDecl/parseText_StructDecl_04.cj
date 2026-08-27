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
func test_StructDecl_04() {
    let str = ##"@!Anno1
private struct MyStruct<A, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z> <: I1 & I2  where T <: I1<T> & I2<T> {
    public var s1: T
    mut prop p1: ?Int64 {
        get() { None }
        set(v) {}
    }
    public init(a: T) { s1 = a }
    func foo<S>(a!: T): T {
        return a
    }
}"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Expect(structDecl.toString().replace("\r",""), ##"@!Anno1
private struct MyStruct<A, B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z> <: I1 & I2  where T <: I1<T> & I2<T> {
    public var s1: T
    mut prop p1: ?Int64 {
        get() { None }
        set(v) {}
    }
    public init(a: T) { s1 = a }
    func foo<S>(a!: T): T {
        return a
    }
}"##)
    @Assert(structDecl.body.memberDecls.size, 4)
    @Assert(structDecl.body.memberDecls[0] is VarDecl)
    @Assert(structDecl.body.memberDecls[0].toString(), ##"public var s1: T"##)
    @Assert(structDecl.body.memberDecls[1] is PropDecl)
    @Assert(structDecl.body.memberDecls[1].toString().replace("\r",""), ##"mut prop p1: ?Int64 {
        get() { None }
        set(v) {}
    }"##)
    @Assert(structDecl.body.memberDecls[2] is FuncDecl)
    @Assert(structDecl.body.memberDecls[2].toString(), ##"public init(a: T) { s1 = a }"##)
    @Assert(structDecl.body.memberDecls[3] is FuncDecl)
    @Assert(structDecl.body.memberDecls[3].toString().replace("\r",""), ##"func foo<S>(a!: T): T {
        return a
    }"##)

    @Assert(structDecl.name, "MyStruct")
    @Assert(structDecl.modifiers.size, 1)
    @Assert(structDecl.modifiers[0].toString(), "private")
    @Assert(structDecl.genericConstraints.isSome())
    @Assert(structDecl.genericConstraints.getOrThrow().toString(), "where T <: I1<T> & I2<T>")
    @Assert(structDecl.genericParams.size, 26)
    @Assert(structDecl.genericParams[0].toString(), "A")
    @Assert(structDecl.genericParams[25].toString(), "Z")
    @Assert(structDecl.superTyAnnotations.size, 2)
    @Assert(structDecl.superTyAnnotations[0].toString(), "I1")
    @Assert(structDecl.superTyAnnotations[1].toString(), "I2")
    @Assert(structDecl.annotations.size, 1)
    @Expect(structDecl.annotations[0].toString(), ##"@!Anno1"##)
}
}