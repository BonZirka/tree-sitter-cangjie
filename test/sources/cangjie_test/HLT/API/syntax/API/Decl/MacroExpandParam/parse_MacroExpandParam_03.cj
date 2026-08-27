/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MacroExpandParam_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MacroExpandParam_03() {
    let res = parseFile("./MacroExpandParam_03.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class C1 {
    private C1(@M1 var c: Int64, @M1 [x: Int64]public var d!: ?Int64, @M1[abcd]private let e!: R = R()) {
    }
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"private C1(@M1 var c: Int64, @M1 [x: Int64]public var d!: ?Int64, @M1[abcd]private let e!: R = R()) {
    }"##)
    @Assert(funcdecl_1.params.params.size, 3)
    let param_1: MacroExpandParam = (funcdecl_1.params.params[0] as MacroExpandParam).getOrThrow()
    @Assert(param_1.toString(), "@M1 var c: Int64")
    @Assert(param_1.calleeMacro.toString(), "M1")
    @Assert(param_1.macroAttrs.toString(), "")
    match (param_1.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"var c: Int64"##)
            let param_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_inner.defaultValue.isNone())
            @Assert(param_inner.name, "c")
            @Assert(param_inner.typeAnnotation is AtomicType)
            @Assert(param_inner.typeAnnotation.toString(), "Int64")
        case _ => @Assert(false)
    }

    let param_2: MacroExpandParam = (funcdecl_1.params.params[1] as MacroExpandParam).getOrThrow()
    @Assert(param_2.toString(), "@M1 [x: Int64]public var d!: ?Int64")
    @Assert(param_2.calleeMacro.toString(), "M1")
    @Assert(param_2.macroAttrs.toString(), "x: Int64")
    match (param_2.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"public var d!: ?Int64"##)
            let param_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_inner.defaultValue.isNone())
            @Assert(param_inner.name, "d")
            @Assert(param_inner.typeAnnotation is PrefixType)
            @Assert(param_inner.typeAnnotation.toString(), "?Int64")
        case _ => @Assert(false)
    }

    let param_3: MacroExpandParam = (funcdecl_1.params.params[2] as MacroExpandParam).getOrThrow()
    @Assert(param_3.toString(), "@M1[abcd]private let e!: R = R()")
    @Assert(param_3.calleeMacro.toString(), "M1")
    @Assert(param_3.macroAttrs.toString(), "abcd")
    match (param_3.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncParam)
            @Expect(Decl.toString(), ##"private let e!: R = R()"##)
            let param_inner = (Decl as FuncParam).getOrThrow()
            @Assert(param_inner.defaultValue.getOrThrow().toString(), "R()")
            @Assert(param_inner.name, "e")
            @Assert(param_inner.typeAnnotation is CompositeType)
            @Assert(param_inner.typeAnnotation.toString(), "R")
        case _ => @Assert(false)
    }
}
}