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
func test_arrayliteral_003() {
    let _quote = quote(["a1", "a2", "a3"])
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var arrayliteral = (sourceNode as ArrayLiteral).getOrThrow()
    //toString()
    @Assert(arrayliteral.toString(), "[\"a1\", \"a2\", \"a3\"]")

    //elements
    var array = arrayliteral.elements
    @Assert(array.size,3)
    var x = array.get(0).getOrThrow().toString()
    @Assert(x,"\"a1\"")
}
}