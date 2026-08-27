/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Comment_06.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Comment_06() {
    let res = parseFile("./Comment_06.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"// aaa //bbb
// c 

/* ddd */
/*eee*/

/**
fffffff
*/ // ff
// gggg"##))

    @Assert(sourcefile.comments.size, 8)

    var comment_1: Comment = sourcefile.comments[1]
    @Assert(comment_1.toString(), ##"// aaa //bbb"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"// aaa //bbb"##)

    var comment_2: Comment = sourcefile.comments[2]
    @Assert(comment_2.toString(), ##"// c "##)
    match (comment_2.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"// c "##)

    var comment_3: Comment = sourcefile.comments[3]
    @Assert(comment_3.toString(), ##"/* ddd */"##)
    match (comment_3.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content, ##"/* ddd */"##)

    var comment_4: Comment = sourcefile.comments[4]
    @Assert(comment_4.toString(), ##"/*eee*/"##)
    match (comment_4.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_4.content, ##"/*eee*/"##)

    var comment_5: Comment = sourcefile.comments[5]
    @Assert(comment_5.toString().replace("\r",""), ##"/**
fffffff
*/"##)
    match (comment_5.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_5.content.replace("\r",""), ##"/**
fffffff
*/"##)

    var comment_6: Comment = sourcefile.comments[6]
    @Assert(comment_6.toString(), ##"// ff"##)
    match (comment_6.kind) {
        case CommentKind.Line => ()
        case _ => @Expect(false)
    }
    @Assert(comment_6.content, ##"// ff"##)

    var comment_7: Comment = sourcefile.comments[7]
    @Assert(comment_7.toString(), ##"// gggg"##)
    match (comment_7.kind) {
        case CommentKind.Line => ()
        case _ => @Expect(false)
    }
    @Assert(comment_7.content, ##"// gggg"##)
}
}