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
        Body([(parseText("mut func foo(): ?(Int64, Int64) { None }").node.getOrThrow() as FuncDecl).getOrThrow()])
    ],  
    constructor in [  
        [((parseText("enum A { Enum(B) }").node.getOrThrow() as EnumDecl).getOrThrow().body.memberDecls[0] as EnumConstructor).getOrThrow()]
    ],
    genericConstraints in [
        None,
        GenericConstraints([GenericConstraint(CompositeType("T", [], []), [CompositeType("I1", [], [])])]),
    ],
    genericParams in [
      //  [],
        (parseText("class A1<T> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        (parseText("class A1<T, U> {}").node.getOrThrow() as ClassDecl).getOrThrow().genericParams,
        [GenericParam("T")]
    ],
    isNonExhaustive in [
        true, 
        false
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
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        [Modifier(ModifierKind.Public), Modifier(ModifierKind.Open)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_EnumDecl_Init_01(body: Body, constructor: Array<EnumConstructor>, genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>,
        isNonExhaustive: Bool, name: String, superTyAnnotations: Array<TypeAnnotation>, annotations: Array<Annotation>,
        modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let EnumDecl = EnumDecl(body, constructor, genericConstraints, genericParams, isNonExhaustive, name, superTyAnnotations, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(EnumDecl.toString())
    println()
}
}