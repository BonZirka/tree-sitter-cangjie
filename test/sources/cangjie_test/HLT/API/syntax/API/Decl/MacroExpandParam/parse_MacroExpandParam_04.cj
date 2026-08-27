/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: MacroExpandParam_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MacroExpandParam_04() {
    let res = parseFile("./MacroExpandParam_04.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class C1 {
    private C1(@M1 (var c: Int64), @M1 [x: Int64](public var d!: ?Int64), @M1[abcd](private let e!: R = R())) {
    }
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"private C1(@M1 (var c: Int64), @M1 [x: Int64](public var d!: ?Int64), @M1[abcd](private let e!: R = R())) {
    }"##)
    @Assert(funcdecl_1.params.params.size, 3)
    let param_1: MacroExpandParam = (funcdecl_1.params.params[0] as MacroExpandParam).getOrThrow()
    @Assert(param_1.toString(), "@M1 (var c: Int64)")
    @Assert(param_1.calleeMacro.toString(), "M1")
    @Assert(param_1.macroAttrs.toString(), "")
    match (param_1.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"var c: Int64"##)
        case _ => @Assert(false)
    }

    let param_2: MacroExpandParam = (funcdecl_1.params.params[1] as MacroExpandParam).getOrThrow()
    @Assert(param_2.toString(), "@M1 [x: Int64](public var d!: ?Int64)")
    @Assert(param_2.calleeMacro.toString(), "M1")
    @Assert(param_2.macroAttrs.toString(), "x: Int64")
    match (param_2.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"public var d!:?Int64"##)
        case _ => @Assert(false)
    }

    let param_3: MacroExpandParam = (funcdecl_1.params.params[2] as MacroExpandParam).getOrThrow()
    @Assert(param_3.toString(), "@M1[abcd](private let e!: R = R())")
    @Assert(param_3.calleeMacro.toString(), "M1")
    @Assert(param_3.macroAttrs.toString(), "abcd")
    match (param_3.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"private let e!: R = R()"##)
        case _ => @Assert(false)
    }
}
}