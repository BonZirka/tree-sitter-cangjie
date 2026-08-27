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
    memberDecls in [
        [],
        [(parseText("static var a = 1").node.getOrThrow() as VarDecl).getOrThrow()],
        [(parseText("mut func foo(): ?(Int64, Int64) { None }").node.getOrThrow() as FuncDecl).getOrThrow()]
    ],
    comments in [
        [], 
//         [Comment(##"/* 
// a 
// */"##)],
//         [Comment("//1"), Comment("// 2")]
    ]
]
func test_Body_Init_01(memberDecls: Array<Decl>, comments: Array<Comment>): Unit {
    let Body = Body(memberDecls, comments: comments)
    println(Body.toString())
    println()
}
}