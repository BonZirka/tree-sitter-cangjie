/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: VarDecl_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VarDecl_02() {
    let res = parseFile("./VarDecl_02.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"class C1<T> {
    static let v1: Int64
    public var v2: T
    internal static const v3: Int64 = if (true) {1} else {0}

    static init() {
        v1 = 1
    }
    public init(a: T) {
        v2 = a
    }
}"##))

    var classDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var vardecl_1 = (classDecl.body.memberDecls[0] as VarDecl).getOrThrow()
    @Assert(vardecl_1.toString(), "static let v1: Int64")
    @Assert(vardecl_1.initializer.isNone())
    match (vardecl_1.kind) {
        case VarKind.Let => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_1.tyAnnotation.isSome())
    @Assert(vardecl_1.tyAnnotation.getOrThrow() is AtomicType)
    @Assert(vardecl_1.pattern is VarPattern)
    @Assert(vardecl_1.modifiers.toString(), "[static]")

    var vardecl_2 = (classDecl.body.memberDecls[1] as VarDecl).getOrThrow()
    @Assert(vardecl_2.toString(), "public var v2: T")
    @Assert(vardecl_2.initializer.isNone())
    match (vardecl_2.kind) {
        case VarKind.Var => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_2.tyAnnotation.isSome())
    @Assert(vardecl_2.tyAnnotation.getOrThrow() is CompositeType)
    @Assert(vardecl_2.pattern is VarPattern)
    @Assert(vardecl_2.modifiers.toString(), "[public]")

    var vardecl_3 = (classDecl.body.memberDecls[2] as VarDecl).getOrThrow()
    @Assert(vardecl_3.toString(), "internal static const v3: Int64 = if (true) {1} else {0}")
    @Assert(vardecl_3.initializer.isSome())
    @Assert(vardecl_3.initializer.getOrThrow().toString(), "if (true) {1} else {0}")
    match (vardecl_3.kind) {
        case VarKind.Const => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_3.tyAnnotation.isSome())
    @Assert(vardecl_3.tyAnnotation.getOrThrow() is AtomicType)
    @Assert(vardecl_3.pattern is VarPattern)
}
}