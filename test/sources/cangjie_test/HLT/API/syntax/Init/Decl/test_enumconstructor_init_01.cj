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
    name in [
        "A1",
        "_RRRR"
    ],
    paramTyAnnotations in [
        [],
        [AtomicType(Int64Type)],
        []
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        //[],
        [Modifier(ModifierKind.Public), Modifier(ModifierKind.Open)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_EnumConstructor_Init_01(name: String, paramTyAnnotations: Array<TypeAnnotation>, annotations: Array<Annotation>,
        modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let EnumConstructor = EnumConstructor(name, paramTyAnnotations, annotations: annotations,
        comments: comments)
    println(EnumConstructor.toString())
    println()
}
}