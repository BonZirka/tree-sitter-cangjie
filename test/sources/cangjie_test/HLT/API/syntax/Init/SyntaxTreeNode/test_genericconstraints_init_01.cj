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
    constraints in [
        // [],
        [GenericConstraint(CompositeType("I1", [], []), [CompositeType("T", [], [])])],
        [
            GenericConstraint(CompositeType("I1", [], []), [CompositeType("T", [], [])]), 
            GenericConstraint(CompositeType("I2", [], []), [CompositeType("T", [], []), CompositeType("U", [], [])])
        ]
    ],
    comments in [
        [], 
        [Comment(##"/* 
    ccc
*/"##)]
    ]
]
func test_GenericConstraints_Init_01(constraints: Array<GenericConstraint>, comments: Array<Comment>): Unit {
    let GenericConstraints = GenericConstraints(constraints, comments: comments)
    println(GenericConstraints.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    constraints in [
        [],
       
    ],
    comments in [
        [], 
        [Comment(##"/* 
    ccc
*/"##)]
    ]
]
func test_GenericConstraints_Init_02(constraints: Array<GenericConstraint>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](GenericConstraints(constraints, comments: comments))
}
}