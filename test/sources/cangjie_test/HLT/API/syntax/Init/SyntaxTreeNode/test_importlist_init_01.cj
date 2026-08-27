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
    contents in [
        ImportAlias(["p1"], "foo", "a1" ),
        ImportAll(["p1", "p2"]),
        ImportSingle(["p1", "p3"], "bbb"),
        ImportMulti(["a1"], [ImportAlias(["pp1"], "ffoo", "a1" )])
    ],
    // kind in [
    //     ImportKind.Alias,
    //     ImportKind.All,
    //     ImportKind.Multi,
    //     ImportKind.Single 
    // ],
    modifier in [
        None,
        Modifier(ModifierKind.Public),
        // Modifier(ModifierKind.Open)
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_ImportList_Init_01(contents: ImportContent, modifier: Option<Modifier>, comments: Array<Comment>): Unit {
    // match (kind) {
    //     xxx
    // }
    let ImportList = ImportList(contents, modifier, comments: comments)
    println(ImportList.toString())
    println()
}
}

@Test
class test_02{
    @TestCase[
    contents in [
        ImportAlias(["p1"], "foo", "a1" ),
        ImportAll(["p1", "p2"]),
        ImportSingle(["p1", "p3"], "bbb"),
        ImportMulti(["a1"], [ImportAlias(["pp1"], "ffoo", "a1" )])
    ],
    // kind in [
    //     ImportKind.Alias,
    //     ImportKind.All,
    //     ImportKind.Multi,
    //     ImportKind.Single 
    // ],
    modifier in [
        // None,
        // Modifier(ModifierKind.Public),
        Modifier(ModifierKind.Open)
    ],
    comments in [
        [], 
//         [Comment(CommentKind.Block, ##"/* 
//     ccc
// */"##)]
    ]
]
func test_ImportList_Init_02(contents: ImportContent, modifier: Option<Modifier>, comments: Array<Comment>): Unit {
    // match (kind) {
    //     xxx
    // }
    @AssertThrows[Exception](ImportList(contents, modifier, comments: comments))
    
}
}