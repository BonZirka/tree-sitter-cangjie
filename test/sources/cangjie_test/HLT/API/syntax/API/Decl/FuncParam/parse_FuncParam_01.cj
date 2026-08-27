/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: FuncParam_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncParam_01() {
    let res = parseFile("./FuncParam_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class C1 {
    private C1(a: Int64, b!: Int64, c!: Int64 = 1, public var d!: ?Int64, private let e!: R = R()) {
    }
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"private C1(a: Int64, b!: Int64, c!: Int64 = 1, public var d!: ?Int64, private let e!: R = R()) {
    }"##)
    @Assert(funcdecl_1.params.params.size, 5)
    let param_1 = (funcdecl_1.params.params[0] as FuncParam).getOrThrow()
    @Assert(param_1.toString(), "a: Int64")
    @Assert(param_1.defaultValue.isNone())
    @Assert(param_1.name, "a")
    @Assert(param_1.typeAnnotation is AtomicType)

    let param_2 = (funcdecl_1.params.params[1] as FuncParam).getOrThrow()
    @Assert(param_2.toString(), "b!: Int64")
    @Assert(param_2.defaultValue.isNone())
    @Assert(param_2.name, "b")
    @Assert(param_2.typeAnnotation is AtomicType)

    let param_3 = (funcdecl_1.params.params[2] as FuncParam).getOrThrow()
    @Assert(param_3.toString(), "c!: Int64 = 1")
    @Assert(param_3.toTokens().toString(), "c!: Int64 = 1")
    @Assert(param_3.defaultValue.isSome())
    @Assert(param_3.defaultValue.getOrThrow().toString(), "1")
    @Assert(param_3.name, "c")
    @Assert(param_3.typeAnnotation is AtomicType)

    let param_4 = (funcdecl_1.params.params[3] as FuncParam).getOrThrow()
    @Expect(param_4.toString(), "public var d!: ?Int64")
    @Assert(param_4.defaultValue.isNone())
    @Assert(param_4.name, "d")
    @Assert(param_4.typeAnnotation is PrefixType)
    @Expect(param_4.modifiers.toString(), "[public]")

    let param_5 = (funcdecl_1.params.params[4] as FuncParam).getOrThrow()
    @Expect(param_5.toString(), "private let e!: R = R()")
    @Assert(param_5.defaultValue.isSome())
    @Assert(param_5.defaultValue.getOrThrow().toString(), "R()")
    @Assert(param_5.name, "e")
    @Assert(param_5.typeAnnotation is CompositeType)
    @Expect(param_5.modifiers.toString(), "[private]")

    var pos = param_3.getAssignPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 47i32, 10i32, 48i32])
    pos = param_3.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 37i32, 10i32, 38i32])
    pos = param_3.getNotPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 38i32, 10i32, 39i32])
    pos = param_3.getTypeAnnotationColonPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 39i32, 10i32, 40i32])
    @Assert(param_3.getVarKindKeyWordPos().isNone(), true)
}
}