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
    block in [
        Block([]),
        Block([parseText("a + 1").node.getOrThrow(), parseText("a = b").node.getOrThrow()])
    ],
    identifier in [
        //None,
        "vvv"
    ],
    isGetter in [
        false,
        false
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        // [Modifier(ModifierKind.Unsafe)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_PropGetterOrSetter_Init_01(block: Block, identifier: Option<String>, isGetter: Bool, annotations: Array<Annotation>,
    modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let PropGetterOrSetter = PropGetterOrSetter(block, identifier, isGetter, annotations: annotations,
        comments: comments)
    println(PropGetterOrSetter.toString())
    println()
}
}