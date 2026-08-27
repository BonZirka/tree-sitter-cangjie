  /*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: macroexpandparam_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let decls = ((parseFile("macroexpandparam_01.cj").node.getOrThrow().topLevelDecls[0] as ClassDecl).getOrThrow().body.memberDecls[0] as FuncDecl)
            .getOrThrow().params.params.map{ _decl => (_decl as MacroExpandParam).getOrThrow()}

@Test
class test_01{
    @TestCase[
    calleeMacro in [
        decls[0].calleeMacro,
        decls[1].calleeMacro,
        decls[2].calleeMacro
    ],
    macroAttrs in [
        decls[0].macroAttrs,
        decls[1].macroAttrs,
        decls[2].macroAttrs
    ],
    macroInputs in [
        decls[0].macroInputs,
        decls[1].macroInputs,
        decls[2].macroInputs
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.AtExcl)]
    ],
    modifiers in [
        [],
        // [Modifier(ModifierKind.Public)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_MacroExpandParam_Init_01(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, annotations: Array<Annotation>,
    modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let MacroExpandParam = MacroExpandParam(calleeMacro, macroAttrs, macroInputs, annotations: annotations,
        comments: comments)
    println(MacroExpandParam.toString())
    println()
}
}