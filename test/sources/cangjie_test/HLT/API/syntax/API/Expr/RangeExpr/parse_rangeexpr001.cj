/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: rangeexpr001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_rangeexpr_001() {
    let res = parseFile("./rangeexpr001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("0..10"))
    @Assert(sourcefile.name, "rangeexpr001.cj")
    @Assert(sourcefile.path.contains("rangeexpr001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var rangeexpr = (maindecl.body.nodes[0] as RangeExpr).getOrThrow()
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
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 6i32, 10i32, 8i32])
    @Assert(rangeexpr.getColonPos().isNone())
}
}