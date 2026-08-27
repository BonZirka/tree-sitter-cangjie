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
func test_rangeexpr_002() {
    let _quote = quote(0..=10:-2)
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var rangeexpr = (sourceNode as RangeExpr).getOrThrow()
    //toString()
    @Assert(rangeexpr.toString(), "0 ..= 10: -2")

    //end
    @Assert(rangeexpr.end.getOrThrow().toString(), "10")

    //start
    @Assert(rangeexpr.start.getOrThrow().toString(), "0")

    //kind
    match (rangeexpr.kind) {
        case RangeKind.ClosedRangeOp => ()
        case _ => @Assert(false)
    }

    //step
    match (rangeexpr.step) {
        case Some(v) => @Assert(v.toString(),"-2")
        case _ => @Assert(false)
    }
}
}