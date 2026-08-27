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
    initializer in [
        None,
        parseText("a + 1").node.getOrThrow() as Expr
    ],
    kind in [
        VarKind.Const,
        VarKind.Let,
        VarKind.Var
    ],
    name in [
        "foo"
    ],
    pattern in [
        VarPattern("x1")
    ],
    tyAnnotation in [
        None,
        CompositeType("I1", [], [])
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
func test_VarDecl_Init_01(initializer: Option<Expr>, kind: VarKind, name: String, pattern: Pattern,
    tyAnnotation: Option<TypeAnnotation>, annotations: Array<Annotation>,
    modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let VarDecl = VarDecl(initializer, kind, name, pattern, tyAnnotation, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(VarDecl.toString())
    println()
}
}