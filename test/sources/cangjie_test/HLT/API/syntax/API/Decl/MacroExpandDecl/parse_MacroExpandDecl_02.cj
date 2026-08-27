/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MacroExpandDecl_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MacroExpandDecl_02() {
    let res = parseFile("./MacroExpandDecl_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"@p1.M1[tok1]( func foo(): Int64 {
    return 1
})
@M1[a: tok1, b: tok2]
func foo<T>(a: T, b!: Int64 = 0) {
    return a
}
@M_A_B(func foo() {})
@M1
func foo(a: T) : (T, T) {
    (a, a)
}"##))

    var decl_1: MacroExpandDecl = (sourcefile.topLevelDecls[0] as MacroExpandDecl).getOrThrow()
    @Expect(decl_1.toString().replace("\r",""), ##"@p1.M1[tok1]( func foo(): Int64 {
    return 1
})"##)
    @Assert(decl_1.calleeMacro.toString(), "p1.M1")
    @Assert(decl_1.macroAttrs.toString(), "tok1")
    match (decl_1.macroInputs) {
        case WithParens(Tokens) => ()
        case _ => @Assert(false)
    }

    var decl_2: MacroExpandDecl = (sourcefile.topLevelDecls[1] as MacroExpandDecl).getOrThrow()
    @Assert(decl_2.toString().replace("\r",""), ##"@M1[a: tok1, b: tok2]
func foo<T>(a: T, b!: Int64 = 0) {
    return a
}"##)
    @Assert(decl_2.calleeMacro.toString(), "M1")
    @Assert(decl_2.macroAttrs.toString(), "a: tok1, b: tok2")
    match (decl_2.macroInputs) {
        case WithoutParens(Decl) => @Assert(Decl.toString().replace("\r",""), ##"func foo<T>(a: T, b!: Int64 = 0) {
    return a
}"##)
        case _ => @Assert(false)
    }

    var decl_3: MacroExpandDecl = (sourcefile.topLevelDecls[2] as MacroExpandDecl).getOrThrow()
    @Assert(decl_3.toString(), ##"@M_A_B(func foo() {})"##)
    @Assert(decl_3.calleeMacro.toString(), "M_A_B")
    @Assert(decl_3.macroAttrs.toString(), "")
    match (decl_3.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"func foo() { }"##)
        case _ => @Assert(false)
    }

    var decl_4: MacroExpandDecl = (sourcefile.topLevelDecls[3] as MacroExpandDecl).getOrThrow()
    @Assert(decl_4.toString().replace("\r",""), ##"@M1
func foo(a: T) : (T, T) {
    (a, a)
}"##)
    @Assert(decl_4.calleeMacro.toString(), "M1")
    @Assert(decl_4.macroAttrs.toString(), "")
    match (decl_4.macroInputs) {
        case WithoutParens(Decl) =>
            @Assert(Decl is FuncDecl)
            @Assert(Decl.toString().replace("\r",""), ##"func foo(a: T) : (T, T) {
    (a, a)
}"##)
        case _ => @Assert(false)
    }
}
}