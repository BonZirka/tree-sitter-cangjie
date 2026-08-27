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
func test_StructDecl_08() {
    let _quote = quote(@Deprecated["aaa", strict: false]
struct S1 <: I1 & I2 {
    public static const s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo(a: T): T {
        return a
    }
})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Assert(structDecl.toString().replace("\r",""), ##"@Deprecated["aaa", strict: false]
struct S1 <: I1 & I2 {
    public static const s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() { }
    func foo(a: T): T {
        return a
    }
}"##)
    @Assert(structDecl.body.memberDecls.size, 4)
    @Assert(structDecl.body.memberDecls[0] is VarDecl)
    @Assert(structDecl.body.memberDecls[0].toString(), ##"public static const s1: Int64 = 0"##)
    @Assert(structDecl.body.memberDecls[1] is PropDecl)
    @Assert(structDecl.body.memberDecls[1].toString().replace("\r",""), ##"prop p1: Int64 {
        get() { 0 }
    }"##)
    @Assert(structDecl.body.memberDecls[2] is FuncDecl)
    @Assert(structDecl.body.memberDecls[2].toString(), ##"public init() { }"##)
    @Assert(structDecl.body.memberDecls[3] is FuncDecl)
    @Assert(structDecl.body.memberDecls[3].toString().replace("\r",""), ##"func foo(a: T): T {
        return a
    }"##)

    @Assert(structDecl.name, "S1")
    @Assert(structDecl.genericConstraints.isNone())
    @Assert(structDecl.genericParams.size, 0)
    @Assert(structDecl.superTyAnnotations.size, 2)
    @Assert(structDecl.superTyAnnotations[0].toString(), "I1")
    @Assert(structDecl.superTyAnnotations[1].toString(), "I2")
    @Assert(structDecl.annotations.size, 1)
    @Assert(structDecl.annotations[0].toString(), ##"@Deprecated["aaa", strict: false]"##)
}
}