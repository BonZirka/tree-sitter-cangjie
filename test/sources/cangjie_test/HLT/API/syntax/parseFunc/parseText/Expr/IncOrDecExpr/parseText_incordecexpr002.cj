/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_incordecexpr_002() {
    let str = ##"arr[0] ++"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var incordecexpr = (sourceNode as IncOrDecExpr).getOrThrow()
    //toString()
    @Assert(incordecexpr.toString(), "arr[0] ++")

    //operand
    @Assert(incordecexpr.operand.toString(),"arr[0]")

    //kind
    match (incordecexpr.kind) {
        case IncOrDecOpKind.Incr => ()
        case _ => @Assert(false)
    }
}
}