/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: tupleliteral001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_tupleliteral_001() {
    let res = parseFile("./tupleliteral001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("(1,2)"))
    @Assert(sourcefile.name, "tupleliteral001.cj")
    @Assert(sourcefile.path.contains("tupleliteral001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var tupleliteral = (maindecl.body.nodes[0] as TupleLiteral).getOrThrow()
    //toString()
    @Assert(tupleliteral.toString(), "(1,2)")

    //elements
    var tuple = tupleliteral.elements
    @Assert(tuple.size,2)
    var x = tuple.get(0).getOrThrow().toString()
    @Assert(x,"1")

    var posList = tupleliteral.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [10i32, 7i32, 10i32, 8i32])
    var pos = tupleliteral.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 5i32, 10i32, 6i32])
    pos = tupleliteral.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 9i32, 10i32, 10i32])
}
}