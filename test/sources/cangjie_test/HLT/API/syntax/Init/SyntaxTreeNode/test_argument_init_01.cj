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
    identifier_pair in [
        ("a1", true),
        (None, false)
    ],
    isInOut in [
        true,
        false
    ],
    value in [
        parseText("foo(a1)").node.getOrThrow() as Expr,
        parseText("\"LitConstExpr\"").node.getOrThrow() as Expr,
        parseText("if (true) {a} else {b}").node.getOrThrow() as Expr
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("/** a */")],
        [Comment("// a")],
        [Comment("//1"), Comment(##"/* 
a 
*/"##)]
    ]
]
func test_Argument_Init_01(identifier_pair: (Option<String>, Bool), isInOut: Bool, value: ?Expr, comments: Array<Comment>): Unit {
    let (identifier, isNamed) = identifier_pair
    let Argument = Argument(identifier, isInOut, value.getOrThrow(), comments: comments)
    println(Argument.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    identifier_pair in [
        ("a1", false),
        (None, true)
    ],
    isInOut in [
        true,
        false
    ],
    value in [
        parseText("foo(a1)").node.getOrThrow() as Expr,
        parseText("\"LitConstExpr\"").node.getOrThrow() as Expr,
        parseText("if (true) {a} else {b}").node.getOrThrow() as Expr
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment( "/** a */")],
        [Comment("// a")],
        [Comment("//1"), Comment(##"/* 
a 
*/"##)]
    ]
]
func test_Argument_Init_02(identifier_pair: (Option<String>, Bool), isInOut: Bool, value: ?Expr, comments: Array<Comment>): Unit {
    let (identifier, isNamed) = identifier_pair
    let Argument = Argument(identifier, isInOut, value.getOrThrow(), comments: comments)
    println(Argument.toString())
    println()

}
}