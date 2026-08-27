/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: incordecexpr003.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_incordecexpr_003() {
    let res = parseFile("./incordecexpr003.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("a.b--"))
    @Assert(sourcefile.name, "incordecexpr003.cj")
    @Assert(sourcefile.path.contains("incordecexpr003.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var incordecexpr = (maindecl.body.nodes[0] as IncOrDecExpr).getOrThrow()
    //toString()
    @Assert(incordecexpr.toString(), "a.b--")

    //operand
    @Assert(incordecexpr.operand.toString(),"a.b")

    //kind
    match (incordecexpr.kind) {
        case IncOrDecOpKind.Decr => ()
        case _ => @Assert(false)
    }
}
}