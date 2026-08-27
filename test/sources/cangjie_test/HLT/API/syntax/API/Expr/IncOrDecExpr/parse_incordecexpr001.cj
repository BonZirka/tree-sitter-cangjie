/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: incordecexpr001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_incordecexpr_001() {
    let res = parseFile("./incordecexpr001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("arr++"))
    @Assert(sourcefile.name, "incordecexpr001.cj")
    @Assert(sourcefile.path.contains("incordecexpr001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var incordecexpr = (maindecl.body.nodes[0] as IncOrDecExpr).getOrThrow()
    //toString()
    @Assert(incordecexpr.toString(), "arr++")

    //operand
    @Assert(incordecexpr.operand.toString(),"arr")

    //kind
    match (incordecexpr.kind) {
        case IncOrDecOpKind.Incr => ()
        case _ => @Assert(false)
    }

    var pos = incordecexpr.getOperatorPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 8i32, 10i32, 10i32])
}
}