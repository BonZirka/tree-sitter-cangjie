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
        Body([]),
        Body([(parseText("static var a = 1").node.getOrThrow() as VarDecl).getOrThrow(),
        (parseText("mut func foo(): ?(Int64, Int64) { None }").node.getOrThrow() as FuncDecl).getOrThrow()])
    ],
    genericConstraints in [
        None
       // GenericConstraints([GenericConstraint(CompositeType("T", [], []), [CompositeType("I1", [], [])])]),
    ],
    genericParams in [
        [],
        (parseText("class A1<T> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        (parseText("class A1<T, U> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        [GenericParam("T")]
    ],
    name in [
        "C1",
        "CCCCCCC"
    ],
    superTyAnnotations in [
        [],
        [CompositeType("I1", [], [])],
        [CompositeType("I1", [], []), CompositeType("I2", [], [])]
    ],
    annotations in [
       // [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        [Modifier(ModifierKind.Public), Modifier(ModifierKind.Open)]
    ],
    comments in [
        [], 
        [Comment(##"/* 
    ccc
*/"##)]
    ]
]
func test_ClassDecl_Init_01(body: Body, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations: Array<Annotation>,
        modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let ClassDecl = ClassDecl(body, genericConstraints, genericParams, name, superTyAnnotations, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(ClassDecl.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    body in [
        Body([]),
        Body([(parseText("static var a = 1").node.getOrThrow() as VarDecl).getOrThrow(),
        (parseText("mut func foo(): ?(Int64, Int64) { None }").node.getOrThrow() as FuncDecl).getOrThrow()])
    ],
    genericConstraints in [
       // None,
        GenericConstraints([GenericConstraint(CompositeType("T", [], []), [CompositeType("I1", [], [])])])
    ],
    genericParams in [
        [],
        (parseText("class A1<U> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        // (parseText("class A1<T, U> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        // [GenericParam("T")]
    ],
    name in [
        "C1",
        "CCCCCCC"
    ],
    superTyAnnotations in [
        [],
        [CompositeType("I1", [], [])],
        [CompositeType("I1", [], []), CompositeType("I2", [], [])]
    ],
    annotations in [
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        [Modifier(ModifierKind.Public), Modifier(ModifierKind.Open)]
    ],
    comments in [
        [], 
        [Comment(##"/* 
    ccc
*/"##)]
    ]
]
func test_ClassDecl_Init_02(body: Body, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations: Array<Annotation>,
        modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](ClassDecl(body, genericConstraints, genericParams, name, superTyAnnotations, annotations: annotations,
        modifiers: modifiers, comments: comments))
}
}