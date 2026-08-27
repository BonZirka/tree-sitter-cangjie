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
    prefixes in [
        [],
        ["p1"],
        ["p1", "p2"]
    ],
    contents in [
        // [],
        [ImportAlias(["p1"], "foo", "a1" )],
        [ImportAlias([], "foo", "a1" ), ImportAll(["p1", "p2"]), ImportSingle(["p1", "p3"], "bbb")]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_ImportMulti_Init_01(prefixes: Array<String>, contents: Array<ImportContent>, comments: Array<Comment>): Unit {
    let ImportMulti = ImportMulti(prefixes, contents, comments: comments)
    println(ImportMulti.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    prefixes in [
        [],
        ["p1"],
        ["p1", "p2"]
    ],
    contents in [
        [],
        // [ImportAlias(["p1"], "foo", "a1" )],
        // [ImportAlias([], "foo", "a1" ), ImportAll(["p1", "p2"]), ImportSingle(["p1", "p3"], "bbb")]
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_ImportMulti_Init_02(prefixes: Array<String>, contents: Array<ImportContent>, comments: Array<Comment>): Unit {
    @AssertThrows[Exception](ImportMulti(prefixes, contents, comments: comments))
}
}