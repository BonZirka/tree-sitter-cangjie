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
    pairs in [
        (CommentKind.Line, "// a"),
        (CommentKind.Block, "/* a */"),
        (CommentKind.Document, "/** a */"),
        (CommentKind.Block, ##"/*
    a
*/"##),
    ]
]
func test_Comment_Init_01(pairs: (CommentKind, String)): Unit {
    let (kind, content) = pairs
    let Comment = Comment(content)
    println(Comment.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    pairs in [
        (CommentKind.Block,##"// a
"##),
        (CommentKind.Line, "/*/"),
    ]
]
func test_Comment_Init_02(pairs: (CommentKind, String)): Unit {
    let (kind, content) = pairs
    @AssertThrows[Exception](Comment(content))
}
}