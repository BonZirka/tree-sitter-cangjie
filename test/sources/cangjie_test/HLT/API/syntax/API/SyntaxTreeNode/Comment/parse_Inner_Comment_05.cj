/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Inner_Comment_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_05() {
    let res = parseFile("./Inner_Comment_05.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Assert(sourcefile.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@!Anno1["aaaaaa"]
// line comment1
enum E1<T, R> where T <: ToString // line comment2
{
    | A1 // line comment3
    | B1(T, R) /*
    block comment
    */
    | C1(R) /** document comment */
    | ... // line comment4
    func foo() {}
} // line comment5"##)

    var _decl: EnumDecl = (sourcefile.topLevelDecls[0] as EnumDecl).getOrThrow()

    var comment_1: Comment = _decl.comments[0]
    @Assert(comment_1.toString(), ##"// line comment1"##)
    match (comment_1.kind) {
        case CommentKind.Line => ()
        case _ => @Assert(false)
    }
    @Assert(comment_1.content, ##"// line comment1"##)

}
}