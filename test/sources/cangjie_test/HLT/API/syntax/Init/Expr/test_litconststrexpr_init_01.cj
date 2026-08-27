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
    kind in [ LitConstKind.StringLiteral ],
    rawValue in [
        "a",
        "_a"
    ],
    delimiterNum in [
        // 0, 
        1, 10
    ],
    isSingleQuote in [
        true,
        false
    ],
    strKind in [
        LitConstStrKind.MultiLineString,
        LitConstStrKind.MultiLineRawString,
        LitConstStrKind.StringLiteral
    ],
    strPartExprs in [
        [],
        (parseText(##""abcd${a}${b}ccc${c}d""##).node.getOrThrow() as LitConstStrExpr).getOrThrow().strPartExprs
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
// a 
// */"##)],
//         [Comment(CommentKind.Line, "//1"), Comment(CommentKind.Line, "// 2")]
    ]
]
func test_LitConstStrExpr_Init_01(kind: LitConstKind, rawValue: String, delimiterNum: Int64, isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>, comments: Array<Comment>): Unit {
    let LitConstStrExpr = LitConstStrExpr(kind, rawValue, delimiterNum, isSingleQuote, strKind, strPartExprs, comments: comments)
    println(LitConstStrExpr.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    kind in [ LitConstKind.StringLiteral ],
    rawValue in [
        "a",
        "_a"
    ],
    delimiterNum in [
         0, 
        //1, 10
    ],
    isSingleQuote in [
        true,
        false
    ],
    strKind in [
        LitConstStrKind.MultiLineRawString,
    ],
    strPartExprs in [
        [],
        (parseText(##""abcd${a}${b}ccc${c}d""##).node.getOrThrow() as LitConstStrExpr).getOrThrow().strPartExprs
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
// a 
// */"##)],
//         [Comment(CommentKind.Line, "//1"), Comment(CommentKind.Line, "// 2")]
    ]
]
func test_LitConstStrExpr_Init_02(kind: LitConstKind, rawValue: String, delimiterNum: Int64, isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](LitConstStrExpr(kind, rawValue, delimiterNum, isSingleQuote, strKind, strPartExprs, comments: comments))
    
}
}