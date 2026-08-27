/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Inner_Comment_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_02() {
    let res = parseFile("./Inner_Comment_02.cj")
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

/*
    class A
*/
class A  {
    /* block comment */

    /*
        foo
    */
    public func foo(/* param a */ a: Int64): Unit {}
} /** 
    class A!
*/"##)

    var _decl: ClassDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var comment_1: Comment = _decl.comments[0]
    @Assert(comment_1.toString().replace("\r",""), ##"/*
    class A
*/"##)
    match (comment_1.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content.replace("\r",""), ##"/*
    class A
*/"##)

    var comment_2: Comment = _decl.comments[1]
    @Assert(comment_2.toString().replace("\r",""), ##"/** 
    class A!
*/"##)
    match (comment_2.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content.replace("\r",""), ##"/** 
    class A!
*/"##)

    var comment_3: Comment = _decl.body.memberDecls[0].comments[0]
    @Assert(comment_3.toString().replace("\r",""), ##"/* block comment */"##)
    match (comment_3.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content.replace("\r",""), ##"/* block comment */"##)

    var comment_4: Comment = _decl.body.memberDecls[0].comments[1]
    @Assert(comment_4.toString().replace("\r",""), ##"/*
        foo
    */"##)
    match (comment_4.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_4.content.replace("\r",""), ##"/*
        foo
    */"##)

    var comment_5: Comment = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow().params.params[0].comments[0]
    @Assert(comment_5.toString().replace("\r",""), ##"/* param a */"##)
    match (comment_5.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_5.content.replace("\r",""), ##"/* param a */"##)
}
}