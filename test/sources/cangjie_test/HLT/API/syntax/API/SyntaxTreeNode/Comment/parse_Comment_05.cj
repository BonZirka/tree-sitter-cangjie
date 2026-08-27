/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Comment_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Comment_05() {
    let res = parseFile("./Comment_05.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"//////line comment

/* /* block comment */ */

/**
/**
document comment
*/
*/

/* // comment_4 */

/*
/*
/*
comment_5
*/
*/
*/"##))

    @Assert(sourcefile.comments.size, 6)

    var comment_1: Comment = sourcefile.comments[1]
    @Assert(comment_1.toString(), ##"//////line comment"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"//////line comment"##)

    var comment_2: Comment = sourcefile.comments[2]
    @Assert(comment_2.toString(), ##"/* /* block comment */ */"##)
    match (comment_2.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"/* /* block comment */ */"##)

    var comment_3: Comment = sourcefile.comments[3]
    @Assert(comment_3.toString().replace("\r",""), ##"/**
/**
document comment
*/
*/"##)
    match (comment_3.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content.replace("\r",""), ##"/**
/**
document comment
*/
*/"##)

    var comment_4: Comment = sourcefile.comments[4]
    @Assert(comment_4.toString(), ##"/* // comment_4 */"##)
    match (comment_4.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_4.content, ##"/* // comment_4 */"##)

    var comment_5: Comment = sourcefile.comments[5]
    @Assert(comment_5.toString().replace("\r",""), ##"/*
/*
/*
comment_5
*/
*/
*/"##)
    match (comment_5.kind) {
        case CommentKind.Block => ()
        case _ => @Expect(false)
    }
    @Assert(comment_5.content.replace("\r",""), ##"/*
/*
/*
comment_5
*/
*/
*/"##)

}
}