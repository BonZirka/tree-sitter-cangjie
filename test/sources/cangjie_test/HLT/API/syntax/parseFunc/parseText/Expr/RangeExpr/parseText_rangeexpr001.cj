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
func test_rangeexpr_001() {
    let str = ##"0..10"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var rangeexpr = (sourceNode as RangeExpr).getOrThrow()
    //toString()
    @Assert(rangeexpr.toString(), "0..10")

    //end
    @Assert(rangeexpr.end.getOrThrow().toString(), "10")

    //start
    @Assert(rangeexpr.start.getOrThrow().toString(), "0")

    //kind
    match (rangeexpr.kind) {
        case RangeKind.RangeOp => ()
        case _ => @Assert(false)
    }

    //step
    match (rangeexpr.step) {
        case None => ()
        case _ => @Assert(false)
    }
    var pos = rangeexpr.getRangeOpPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 2i32, 1i32, 4i32])
    @Assert(rangeexpr.getColonPos().isNone())
}
}