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
    pattern in [
        VarPattern("e1"),
        WildcardPattern()
    ],
    exceptionType in [
        // [],
        [CompositeType("AException", [], [])],
        [CompositeType("AException", [], []), CompositeType("BException", [], [])]
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_CatchPattern_Init_01(pattern: Pattern, exceptionType: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    let CatchPattern = CatchPattern(pattern, exceptionType, comments: comments)
    println(CatchPattern.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    pattern in [
        VarPattern("e1"),
    ],
    exceptionType in [
        [],
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_CatchPattern_Init_02(pattern: Pattern, exceptionType: Array<TypeAnnotation>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](CatchPattern(pattern, exceptionType, comments: comments))
}

}