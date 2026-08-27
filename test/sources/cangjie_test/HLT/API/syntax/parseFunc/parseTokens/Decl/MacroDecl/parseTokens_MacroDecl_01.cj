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
func test_MacroDecl_01() {
    let _quote = quote(public macro M1(input: Tokens): Tokens {
    input
})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var _decl: MacroDecl = (sourceNode as MacroDecl).getOrThrow()
    @Assert(_decl.toString().replace("\r",""), ##"public macro M1(input: Tokens): Tokens {
    input
}"##)
    @Assert(_decl.body.toString().replace("\r",""), ##"{
    input
}"##)
    @Assert(_decl.name, "M1")
    @Assert(_decl.annotations.toString(), ##"[]"##)
    @Assert(_decl.modifiers.toString(), ##"[public]"##)
    @Assert(_decl.params.params.toString(), "[input: Tokens]")
    @Assert(_decl.retTyAnnotation.getOrThrow().toString(), "Tokens")

    var pos = _decl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 14i32, 1i32, 16i32])
    pos = _decl.getMacroKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 8i32, 1i32, 13i32])
    pos = _decl.getRetTyAnnotationColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 31i32, 1i32, 32i32])
}
}