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
        "a1",
        "aaaa"
    ],
    typeAnnotation in [
        None,
        AtomicType(AtomicTypeKind.Float16Type),
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_LambdaParam_Init_01(name: String, typeAnnotation: Option<TypeAnnotation>, 
    comments: Array<Comment>): Unit {
    let LambdaParam = LambdaParam(name, typeAnnotation, comments: comments)
    println(LambdaParam.toString())
    println()
}
}