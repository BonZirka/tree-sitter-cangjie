/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Argument_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Argument_01() {
    let res = parseFile("./Argument_01.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    foo(0)
    foo(a: 1)
    foo(b:"1")
    foo(a: {a: Int64 => a + 1}())
    foo(inout a)
}"##))

    var decl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    let arg_1: Argument = (decl.body.nodes[0] as CallExpr).getOrThrow().arguments[0]
    @Assert(arg_1.toString(), ##"0"##)
    @Assert(arg_1.identifier.isNone())
    @Assert(arg_1.isInOut, false)
    @Assert(arg_1.isNamed, false)
    @Assert(arg_1.value.toString(), "0")

    let arg_2: Argument = (decl.body.nodes[1] as CallExpr).getOrThrow().arguments[0]
    @Assert(arg_2.toString(), ##"a: 1"##)
    @Assert(arg_2.identifier.getOrThrow().toString(), "a")
    @Assert(arg_2.isInOut, false)
    @Assert(arg_2.isNamed, true)
    @Assert(arg_2.value.toString(), "1")

    let arg_3: Argument = (decl.body.nodes[2] as CallExpr).getOrThrow().arguments[0]
    @Assert(arg_3.toString(), ##"b:"1""##)
    @Assert(arg_3.identifier.getOrThrow().toString(), "b")
    @Assert(arg_3.isInOut, false)
    @Assert(arg_3.isNamed, true)
    @Assert(arg_3.value.toString(), ##""1""##)

    let arg_4: Argument = (decl.body.nodes[3] as CallExpr).getOrThrow().arguments[0]
    @Assert(arg_4.toString(), ##"a: {a: Int64 => a + 1}()"##)
    @Assert(arg_4.identifier.getOrThrow().toString(), "a")
    @Assert(arg_4.isInOut, false)
    @Assert(arg_4.isNamed, true)
    @Assert(arg_4.value.toString(), "{a: Int64 => a + 1}()")

    let arg_5: Argument = (decl.body.nodes[4] as CallExpr).getOrThrow().arguments[0]
    @Assert(arg_5.toString(), ##"inout a"##)
    @Assert(arg_5.identifier.isNone())
    @Assert(arg_5.isInOut, true)
    @Assert(arg_5.isNamed, false)
    @Assert(arg_5.value.toString(), "a")

    var pos = arg_4.getColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 10i32, 13i32, 11i32])
    pos = arg_4.getIdentifierPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 9i32, 13i32, 10i32])
    pos = arg_5.getInoutKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [14i32, 9i32, 14i32, 14i32])
}
}