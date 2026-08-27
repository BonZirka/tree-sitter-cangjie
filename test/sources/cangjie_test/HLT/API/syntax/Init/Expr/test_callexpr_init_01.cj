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
    callee in [
        (parseText("A.foo").node.getOrThrow() as MemberAccess).getOrThrow(),
        (parseText("A1<T>").node.getOrThrow() as SymbolRef).getOrThrow()
    ],
    arguments in [
       // [],
      //  [Argument(None, false, false, LitConstExpr(LitConstKind.IntergerLiteral, "123"))],
        (parseText("foo(a1)").node.getOrThrow() as CallExpr).getOrThrow().arguments,
        (parseText("foo(inout aaaa, b: 1234)").node.getOrThrow() as CallExpr).getOrThrow().arguments,
        (parseText("foo(\"1234\", strict: false)").node.getOrThrow() as CallExpr).getOrThrow().arguments
    ],
    comments in [
        [], 
        [Comment(##"/* 
a 
*/"##)],
        [Comment("//1"), Comment("// 2")]
    ]
]
func test_CallExpr_Init_01(callee: Expr, arguments: Array<Argument>, comments: Array<Comment>): Unit {
    let CallExpr = CallExpr(callee, arguments, comments: comments)
    println(CallExpr.toString())
    println()
}
func test_CallExpr_Init_02(): Unit {
    @AssertThrows[Exception](CallExpr((parseText("A()").node.getOrThrow() as CallExpr).getOrThrow(), []))
}
}