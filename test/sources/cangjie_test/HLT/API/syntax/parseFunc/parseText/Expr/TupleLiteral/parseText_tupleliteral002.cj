/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_tupleliteral_002() {
    let str = ##"(true, false)"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var tupleliteral = (sourceNode as TupleLiteral).getOrThrow()
    //toString()
    @Assert(tupleliteral.toString(), "(true, false)")

    //elements
    var tuple = tupleliteral.elements
    @Assert(tuple.size,2)
    var x = tuple.get(0).getOrThrow().toString()
    @Assert(x,"true")
}
}