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
    @TestCase[
    body in [
        Block([]),
        Block([parseText("a + 1").node.getOrThrow(), parseText("return").node.getOrThrow()])
    ],
    name in [
        "foo",
    ],
    params in [
        (parseText("func foo(a: Int64)").node.getOrThrow() as FuncDecl).getOrThrow().params
    ],
    retTyAnnotation in [
        None,
        // CompositeType("I1", [], [])
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        [Modifier(ModifierKind.Public)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_MacroDecl_Init_01(body: Block, name: String, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>, annotations: Array<Annotation>,
    modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let MacroDecl = MacroDecl(body, name, params, retTyAnnotation, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(MacroDecl.toString())
    println()
}
}