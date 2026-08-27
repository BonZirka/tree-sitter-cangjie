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
    subPatterns in [
       // [],
        [ConstPattern(LitConstExpr(LitConstKind.BoolLiteral, "true")), ConstPattern(LitConstExpr(LitConstKind.FloatLiteral, "0.1f32"))],
        [ConstPattern(LitConstExpr(LitConstKind.BoolLiteral, "false")), ConstPattern(LitConstExpr(LitConstKind.FloatLiteral, "0.1f32"))]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
// a 
// */"##)],
//         [Comment(CommentKind.Line, "//1"), Comment(CommentKind.Line, "// 2")]
    ]
]
func test_TuplePattern_Init_01(subPatterns: Array<Pattern>, comments: Array<Comment>): Unit {
    let TuplePattern = TuplePattern(subPatterns, comments: comments)
    println(TuplePattern.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    subPatterns in [
       [],
        // [ConstPattern(LitConstExpr(LitConstKind.BoolLiteral, "true"))],
        // [ConstPattern(LitConstExpr(LitConstKind.BoolLiteral, "false")), ConstPattern(LitConstExpr(LitConstKind.FloatLiteral, "0.1f32"))]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
// a 
// */"##)],
//         [Comment(CommentKind.Line, "//1"), Comment(CommentKind.Line, "// 2")]
    ]
]
func test_TuplePattern_Init_02(subPatterns: Array<Pattern>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](TuplePattern(subPatterns, comments: comments))
    
}


}