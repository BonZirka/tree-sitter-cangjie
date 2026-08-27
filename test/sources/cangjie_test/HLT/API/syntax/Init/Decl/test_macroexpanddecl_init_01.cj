/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: macroexpanddecl_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let decls = parseFile("macroexpanddecl_01.cj").node.getOrThrow().topLevelDecls.map{ _decl => (_decl as MacroExpandDecl).getOrThrow()}

@Test
class test_01{
    @TestCase[
    calleeMacro in [
        decls[0].calleeMacro,
        decls[1].calleeMacro,
        decls[2].calleeMacro,
        decls[3].calleeMacro
    ],
    macroAttrs in [
        decls[0].macroAttrs,
        decls[1].macroAttrs,
        decls[2].macroAttrs,
        decls[3].macroAttrs
    ],
    macroInputs in [
        decls[0].macroInputs,
        decls[1].macroInputs,
        decls[2].macroInputs,
        decls[3].macroInputs
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.AtExcl)]
    ],
    // modifiers in [
    //     [],
    //     // [Modifier(ModifierKind.Public)]
    // ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
     ]
]
func test_MacroExpandDecl_Init_01(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, annotations: Array<Annotation>,
     comments: Array<Comment>): Unit {
    let MacroExpandDecl = MacroExpandDecl(calleeMacro, macroAttrs, macroInputs, annotations: annotations, comments: comments)
    println(MacroExpandDecl.toString())
    println()
}
}