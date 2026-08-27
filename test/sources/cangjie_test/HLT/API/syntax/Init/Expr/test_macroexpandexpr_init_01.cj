/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: macroexpandexpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let decls = (parseFile("macroexpandexpr_01.cj").node.getOrThrow().topLevelDecls[0] as MainDecl).getOrThrow().body.nodes.map{ _decl => (_decl as MacroExpandExpr).getOrThrow()}

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
    comments in [
        [], 
        [Comment(##"/* 
    ccc
*/"##)]
    ]
]
func test_MacroExpandExpr_Init_01(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, comments: Array<Comment>): Unit {
    let MacroExpandExpr = MacroExpandExpr(calleeMacro, macroAttrs, macroInputs, comments: comments)
    println(MacroExpandExpr.toString())
    println()
}
}