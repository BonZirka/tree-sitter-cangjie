/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase[
    labels in [
        [],
        ["a"],
        ["_a", "_b"]
    ],
    elements in [
        [AtomicType(AtomicTypeKind.Int64Type)],
        [AtomicType(AtomicTypeKind.Int64Type), AtomicType(AtomicTypeKind.BoolType)]
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_TupleType_Init_01(labels: Array<String>, elements: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    if (labels.size != elements.size) {
        return
    }
    let TupleType = TupleType(labels, elements, comments: comments)
    println(TupleType.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    labels in [
        []
    ],
    elements in [
        [AtomicType(AtomicTypeKind.Int64Type)],
        [AtomicType(AtomicTypeKind.Int64Type), AtomicType(AtomicTypeKind.BoolType)]
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_TupleType_Init_02(labels: Array<String>, elements: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    let TupleType = TupleType(labels, elements, comments: comments)
    println(TupleType.toString())
    println()
}
}