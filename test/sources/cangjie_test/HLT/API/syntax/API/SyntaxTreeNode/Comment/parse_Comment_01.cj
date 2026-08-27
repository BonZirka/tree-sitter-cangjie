/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Comment_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Comment_01() {
    let res = parseFile("./Comment_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// single line comment

/* 
    multi line comment
*/

main() {}

/**
    doc comment
*/"##))
    @Assert(sourcefile.nodePos.beginLine, 1)
    @Assert(sourcefile.nodePos.beginColumn, 1)
    @Assert(sourcefile.nodePos.endLine, 19)
    @Assert(sourcefile.nodePos.endColumn, 3)

    var _comment: Comment = sourcefile.comments[0]
    @Assert(_comment.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */"##)
    match (_comment.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }

    @Assert(_comment.content.replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */"##)

    var comment_1: Comment = sourcefile.comments[1]
    @Assert(comment_1.toString().replace("\r",""), ##"// single line comment"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"// single line comment"##)

    var comment_2: Comment = sourcefile.comments[2]
    @Assert(comment_2.toString().replace("\r",""), ##"/* 
    multi line comment
*/"##)
    match (comment_2.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content.replace("\r",""), ##"/* 
    multi line comment
*/"##)

    var comment_3: Comment = sourcefile.comments[3]
    @Assert(comment_3.toString().replace("\r",""), ##"/**
    doc comment
*/"##)
    match (comment_3.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content.replace("\r",""), ##"/**
    doc comment
*/"##)
}
}