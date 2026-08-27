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
    typeArgument in [
        CompositeType("I1", [], []),
    
    ],
    upperBounds in [
       // [],
        [AtomicType(AtomicTypeKind.Float16Type), CompositeType("I2", [], [])]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_GenericConstraint_Init_01(typeArgument: TypeAnnotation, upperBounds: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    let GenericConstraint = GenericConstraint(typeArgument, upperBounds, comments: comments)
    println(GenericConstraint.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    typeArgument in [
        CompositeType("I1", [], []),
    
    ],
    upperBounds in [
        [],
        //[AtomicType(AtomicTypeKind.Float16Type), CompositeType("I2", [], [])]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_GenericConstraint_Init_02(typeArgument: TypeAnnotation, upperBounds: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](GenericConstraint(typeArgument, upperBounds, comments: comments))
    
}
}