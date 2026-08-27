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
    name in [
        "a",
        "_a"
    ],
    prefixes in [
        [],
        ["p1", "p2"]
    ],
    typeArguments in [
        [],
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
func test_CompositeType_Init_01(name: String, prefixes: Array<String>, typeArguments: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    let CompositeType = CompositeType(name, prefixes, typeArguments, comments: comments)
    println(CompositeType.toString())
    println()
}
}