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
import stdx.unittest.*

@Test
class test_01{
    @TestCase[
    // identifier in [
    //    "foo",
    //    "_a_"
    // ],
    isMut in [
        true, 
        false
    ],
    getter in [
        //None,
        PropGetterOrSetter(Block([]), None, true)
    ],
    name in [
        "_prop"
    ],
    setter in [
        None,
        PropGetterOrSetter(Block([]), "v", false)
    ],
    tyAnnotation in [
        AtomicType(UnitType)
    ],
    annotations in [
        [],
        [Annotation([Argument(None, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))], "MyAnno", AtOpKind.At)]
    ],
    modifiers in [
        [],
        [Modifier(ModifierKind.Mut)]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_PropDecl_Init_01(getter: Option<PropGetterOrSetter>, name: String, setter: Option<PropGetterOrSetter>,
    tyAnnotation: TypeAnnotation, annotations: Array<Annotation>, modifiers: Array<Modifier>, comments: Array<Comment>): Unit {
    let PropDecl = PropDecl(getter, name, setter, tyAnnotation, annotations: annotations,
        modifiers: modifiers, comments: comments)
    println(PropDecl.toString())
    println()
}
}