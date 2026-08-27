/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: FuncDecl_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_04() {
    let res = parseFile("./FuncDecl_04.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class C1 {
    private C1(a: Int64, b!: Int64, c!: Int64 = 1, public var d!: Int64, private let e!: Int64 = 3) {
    }
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"private C1(a: Int64, b!: Int64, c!: Int64 = 1, public var d!: Int64, private let e!: Int64 = 3) {
    }"##)
    @Assert(funcdecl_1.body.isSome())
    @Assert(funcdecl_1.body.getOrThrow().toString().replace("\r",""), ##"{
    }"##)
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case PrimaryConstructor => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "C1")
    @Assert(funcdecl_1.params.params.size, 5)
    @Assert(funcdecl_1.params.params[0] is FuncParam)
    @Assert(funcdecl_1.params.params[1] is FuncParam)
    @Assert(funcdecl_1.params.params[2] is FuncParam)
    @Assert(funcdecl_1.params.params[3] is FuncParam)
    @Assert(funcdecl_1.params.params[4] is FuncParam)
    @Assert(funcdecl_1.params.params[0].toString(), "a: Int64")
    @Assert(funcdecl_1.params.params[1].toString(), "b!: Int64")
    @Assert(funcdecl_1.params.params[2].toString(), "c!: Int64 = 1")
    @Expect(funcdecl_1.params.params[3].toString(), "public var d!: Int64")
    @Expect(funcdecl_1.params.params[4].toString(), "private let e!: Int64 = 3")
    @Assert(funcdecl_1.retTyAnnotation.isNone())
    @Assert(funcdecl_1.modifiers.toString(), "[private]")
    @Assert(funcdecl_1.annotations.toString(), "[]")
}
}