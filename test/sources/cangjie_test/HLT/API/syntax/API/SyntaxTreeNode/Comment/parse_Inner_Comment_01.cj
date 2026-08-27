/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Inner_Comment_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_01() {
    let res = parseFile("./Inner_Comment_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// line comment1
class A {
    // line comment2
} // line comment3"##)

    var _decl: ClassDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var comment_1: Comment = _decl.comments[0]
    @Assert(comment_1.toString(), ##"// line comment1"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"// line comment1"##)

    var comment_2: Comment = _decl.comments[1]
    @Assert(comment_2.toString(), ##"// line comment3"##)
    match (comment_2.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"// line comment3"##)

    var comment_3: Comment = _decl.body.comments[0]
    @Assert(comment_3.toString(), ##"// line comment2"##)
    match (comment_3.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content, ##"// line comment2"##)
}
}