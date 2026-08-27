/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MacroExpandParam_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MacroExpandParam_01() {
    let res = parseFile("./MacroExpandParam_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class C1 {
    private init(@M1 a: Int64, @M1[x: Int64] b!: Int64, @M1[aaa]c!: Int64 = 1) {
    }
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"private init(@M1 a: Int64, @M1[x: Int64] b!: Int64, @M1[aaa]c!: Int64 = 1) {
    }"##)
    @Assert(funcdecl_1.params.params.size, 3)
    let param_1: MacroExpandParam = (funcdecl_1.params.params[0] as MacroExpandParam).getOrThrow()
    @Assert(param_1.toString(), "@M1 a: Int64")
    @Assert(param_1.toTokens().toString(), "@M1 a: Int64")
    @Assert(param_1.calleeMacro.toString(), "M1")
    @Assert(param_1.macroAttrs.toString(), "")
    match (param_1.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"a: Int64"##)
            let param_1_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_1_inner.defaultValue.isNone())
            @Assert(param_1_inner.name, "a")
            @Assert(param_1_inner.typeAnnotation is AtomicType)
            @Assert(param_1_inner.typeAnnotation.toString(), "Int64")
        case _ => @Assert(false)
    }

    let param_2: MacroExpandParam = (funcdecl_1.params.params[1] as MacroExpandParam).getOrThrow()
    @Assert(param_2.toString(), "@M1[x: Int64] b!: Int64")
    @Assert(param_2.calleeMacro.toString(), "M1")
    @Assert(param_2.macroAttrs.toString(), "x: Int64")
    match (param_2.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"b!: Int64"##)
            let param_2_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_2_inner.defaultValue.isNone())
            @Assert(param_2_inner.name, "b")
            @Assert(param_2_inner.typeAnnotation is AtomicType)
            @Assert(param_2_inner.typeAnnotation.toString(), "Int64")
        case _ => @Assert(false)
    }

    let param_3: MacroExpandParam = (funcdecl_1.params.params[2] as MacroExpandParam).getOrThrow()
    @Assert(param_3.toString(), "@M1[aaa]c!: Int64 = 1")
    @Assert(param_3.calleeMacro.toString(), "M1")
    @Assert(param_3.macroAttrs.toString(), "aaa")
    match (param_3.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"c!: Int64 = 1"##)
            let param_3_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_3_inner.defaultValue.getOrThrow().toString(), "1")
            @Assert(param_3_inner.name, "c")
            @Assert(param_3_inner.typeAnnotation is AtomicType)
            @Assert(param_3_inner.typeAnnotation.toString(), "Int64")
        case _ => @Assert(false)
    }

    var pos = param_2.getAtPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 32i32, 10i32, 33i32])
    @Assert(param_2.getLParenPos().isNone(), true)
    pos = param_2.getLSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 35i32, 10i32, 36i32])
    @Assert(param_2.getRParenPos().isNone(), true)
    pos = param_2.getRSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 44i32, 10i32, 45i32])
}
}