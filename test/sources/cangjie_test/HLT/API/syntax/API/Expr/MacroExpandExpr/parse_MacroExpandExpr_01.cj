/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: MacroExpandExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.ast.Tokens
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_MacroExpandExpr_01() {
    let res = parseFile("./MacroExpandExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    @M1 @M2(foo())
    @M1[a: T, b: U](a = b)
    @M1(if (a) {b} else {c})
    @pkg1.pkg2.M1[aaaaaa](
        a ** b
    )
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: MacroExpandExpr = (mainDecl.body.nodes[0] as MacroExpandExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"@M1 @M2(foo())"##)
    @Expect(expr_1.toTokens().toString(), ##"@M1 @M2(foo())"##)
    @Assert(expr_1.calleeMacro.toString(), "M1")
    @Assert(expr_1.macroAttrs.toString(), "")
    match (expr_1.macroInputs) {
        case WithoutParens(Decl) =>
            @Expect(Decl is MacroExpandDecl)
            @Expect(Decl.toString(), ##"@M2(foo())"##)
        case _ => @Assert(false)
    }

    var expr_2: MacroExpandExpr = (mainDecl.body.nodes[1] as MacroExpandExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"@M1[a: T, b: U](a = b)"##)
    @Assert(expr_2.calleeMacro.toString(), "M1")
    @Assert(expr_2.macroAttrs.toString(), "a: T, b: U")
    match (expr_2.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"a = b"##)
        case _ => @Assert(false)
    }

    var expr_3: MacroExpandExpr = (mainDecl.body.nodes[2] as MacroExpandExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"@M1(if (a) {b} else {c})"##)
    @Assert(expr_3.calleeMacro.toString(), "M1")
    @Assert(expr_3.macroAttrs.toString(), "")
    match (expr_3.macroInputs) {
        case WithParens(Tokens) => @Expect(Tokens.toString(), ##"if(a) { b } else { c }"##)
        case _ => @Assert(false)
    }

    var expr_4: MacroExpandExpr = (mainDecl.body.nodes[3] as MacroExpandExpr).getOrThrow()
    @Expect(expr_4.toString().replace("\r",""), ##"@pkg1.pkg2.M1[aaaaaa](
        a ** b
    )"##)
    @Assert(expr_4.calleeMacro.toString(), "pkg1.pkg2.M1")
    @Assert(expr_4.macroAttrs.toString(), "aaaaaa")
    match (expr_4.macroInputs) {
        case WithParens(Tokens) => ()
        case _ => @Assert(false)
    }

    var pos = expr_4.getAtPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 5i32, 13i32, 6i32])
    pos = expr_4.getLParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 26i32, 13i32, 27i32])
    pos = expr_4.getLSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 18i32, 13i32, 19i32])
    pos = expr_4.getRParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [15i32, 5i32, 15i32, 6i32])
    pos = expr_4.getRSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 25i32, 13i32, 26i32])
}
}