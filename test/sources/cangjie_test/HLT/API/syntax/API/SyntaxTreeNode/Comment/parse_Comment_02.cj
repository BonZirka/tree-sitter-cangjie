/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Comment_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Comment_02() {
    let res = parseFile("./Comment_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"/* multi line comment */

/** doc comment */

// attached comment before
main() {} /*
    attached comment after
*/"##))

    @Assert(sourcefile.comments.size, 3)

    var comment_1: Comment = sourcefile.comments[1]
    @Assert(comment_1.toString(), ##"/* multi line comment */"##)
    match (comment_1.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }

    @Assert(comment_1.content, ##"/* multi line comment */"##)

    var comment_2: Comment = sourcefile.comments[2]
    @Assert(comment_2.toString(), ##"/** doc comment */"##)
    match (comment_2.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"/** doc comment */"##)

}
}