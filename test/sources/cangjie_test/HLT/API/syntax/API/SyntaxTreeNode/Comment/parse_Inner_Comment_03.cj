/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Inner_Comment_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_03() {
    let res = parseFile("./Inner_Comment_03.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

main() {

    // line comment1

    var a = 1 /* block comment1 */
    +
    // line comment2
    2 /** document comment1 */

    return 0 /* block comment2 */
}"##)

    var _decl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()

    var vardecl = (_decl.body.nodes[0] as VarDecl).getOrThrow()
    @Assert(vardecl.comments.size, 2)
    var comment_1: Comment = vardecl.comments[0]
    @Assert(comment_1.toString(), ##"// line comment1"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"// line comment1"##)

    var comment_1_0: Comment = vardecl.comments[1]
    @Assert(comment_1_0.toString(), ##"/** document comment1 */"##)
    match (comment_1_0.kind) {
        case CommentKind.Document => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1_0.content, ##"/** document comment1 */"##)

    var _expr = (vardecl.initializer.getOrThrow() as BinaryExpr).getOrThrow()
    var comment_2: Comment = _expr.lhs.comments[0]
    @Assert(comment_2.toString(), ##"/* block comment1 */"##)
    match (comment_2.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_2.content, ##"/* block comment1 */"##)

    var comment_3: Comment = _expr.rhs.comments[0]
    @Assert(comment_3.toString(), ##"// line comment2"##)
    match (comment_3.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_3.content, ##"// line comment2"##)

    var comment_4: Comment = (_decl.body.nodes[1] as ReturnExpr).getOrThrow().comments[0]
    @Assert(comment_4.toString(), ##"/* block comment2 */"##)
    match (comment_4.kind) {
        case CommentKind.Block => ()
        case _ => @Assert(false)
    }
    @Assert(comment_4.content, ##"/* block comment2 */"##)
}
}