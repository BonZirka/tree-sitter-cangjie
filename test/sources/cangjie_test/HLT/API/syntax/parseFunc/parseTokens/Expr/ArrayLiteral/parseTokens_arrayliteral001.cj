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
func test_arrayliteral_001() {
    let _quote = quote([10, 0, 0, 0])
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var arrayliteral = (sourceNode as ArrayLiteral).getOrThrow()
    //toString()
    @Assert(arrayliteral.toString(), "[10, 0, 0, 0]")

    //elements
    var array = arrayliteral.elements
    @Assert(array.size,4)
    var x = array.get(0).getOrThrow().toString()
    @Assert(x,"10")

    var posList = arrayliteral.getCommasPos()
    @Assert(posList.size == 3, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [1i32, 4i32, 1i32, 5i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [1i32, 7i32, 1i32, 8i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [1i32, 10i32, 1i32, 11i32])
    var pos = arrayliteral.getLSquarePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 2i32])
    pos = arrayliteral.getRSquarePos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 13i32, 1i32, 14i32])
}
}