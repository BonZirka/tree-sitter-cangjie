/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Comment_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Comment_03() {
    let res = parseFile("./Comment_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"//

// 

/* 
*/

/**
*/

/**/

/** */"##))

    @Assert(sourcefile.comments.size, 7)

    var comment_1: Comment = sourcefile.comments[1]
    @Assert(comment_1.toString(), ##"//"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"//"##)

    var comment_2: Comment = sourcefile.comments[2]
    @Assert(comment_2.toString(), ##"// "##)
    match (comment_2.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"// "##)
    @Assert(comment_2.nodePos.beginLine, 11)
    @Assert(comment_2.nodePos.beginColumn, 1)
    @Assert(comment_2.nodePos.endLine, 11)
    @Assert(comment_2.nodePos.endColumn, 4)

    var comment_3: Comment = sourcefile.comments[3]
    @Assert(comment_3.toString().replace("\r",""), ##"/* 
*/"##)
    match (comment_3.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content.replace("\r",""), ##"/* 
*/"##)

    var comment_4: Comment = sourcefile.comments[4]
    @Assert(comment_4.toString().replace("\r",""), ##"/**
*/"##)
    match (comment_4.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_4.content.replace("\r",""), ##"/**
*/"##)

    var comment_5: Comment = sourcefile.comments[5]
    @Assert(comment_5.toString(), ##"/**/"##)
    match (comment_5.kind) {
        case CommentKind.Block => ()
        case _ => @Expect(false)
    }
    @Assert(comment_5.content, ##"/**/"##)
    @Assert(comment_5.nodePos.beginLine, 19)
    @Assert(comment_5.nodePos.beginColumn, 1)
    @Assert(comment_5.nodePos.endLine, 19)
    @Assert(comment_5.nodePos.endColumn, 5)

    var comment_6: Comment = sourcefile.comments[6]
    @Assert(comment_6.toString(), ##"/** */"##)
    match (comment_6.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_6.content, ##"/** */"##)
}
}