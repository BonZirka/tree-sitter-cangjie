/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_tupleliteral_001() {
    let str = ##"(1,2)"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var tupleliteral = (sourceNode as TupleLiteral).getOrThrow()
    //toString()
    @Assert(tupleliteral.toString(), "(1,2)")

    //elements
    var tuple = tupleliteral.elements
    @Assert(tuple.size,2)
    var x = tuple.get(0).getOrThrow().toString()
    @Assert(x,"1")

    var posList = tupleliteral.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [1i32, 3i32, 1i32, 4i32])
    var pos = tupleliteral.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 2i32])
    pos = tupleliteral.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 5i32, 1i32, 6i32])
}
}