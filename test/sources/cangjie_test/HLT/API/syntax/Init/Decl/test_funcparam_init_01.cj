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
    defaultValue in [
        None,
        (parseText("a + 1").node.getOrThrow() as Expr).getOrThrow()
    ],
    kind in [
        VarKind.Let,
        VarKind.Var
    ],
    name in [
        "a1",
        "aaaa"
    ],
    typeAnnotation in [
        AtomicType(AtomicTypeKind.Float16Type),
    
    ],
    isNamed in [
        true,
        false
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
func test_FuncParam_Init_01(defaultValue: Option<Expr>, kind: Option<VarKind>, name: String, typeAnnotation: TypeAnnotation,
    isNamed: Bool, annotations: Array<Annotation>, modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    if ((isNamed == true && defaultValue.isNone()) || (isNamed == false && defaultValue.isSome())) {
        return
    }
    let FuncParam = FuncParam(defaultValue, kind, name, typeAnnotation, isNamed: isNamed, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(FuncParam.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    defaultValue in [
        None,
        (parseText("a + 1").node.getOrThrow() as Expr).getOrThrow()
    ],
    kind in [
       None,
    ],
    name in [
        "a1",
        "aaaa"
    ],
    typeAnnotation in [
        AtomicType(AtomicTypeKind.Float16Type),
    
    ],
    isNamed in [
        true,
        false
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        //[],
        [Modifier(ModifierKind.Public)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_FuncParam_Init_02(defaultValue: Option<Expr>, kind: Option<VarKind>, name: String, typeAnnotation: TypeAnnotation,
    isNamed: Bool, annotations: Array<Annotation>, modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    if ((isNamed == true && defaultValue.isNone()) || (isNamed == false && defaultValue.isSome())) {
        return
    }
    @AssertThrows[Exception](FuncParam(defaultValue, kind, name, typeAnnotation, isNamed: isNamed, annotations: annotations,
        modifiers: modifiers, comments: comments))
}
}