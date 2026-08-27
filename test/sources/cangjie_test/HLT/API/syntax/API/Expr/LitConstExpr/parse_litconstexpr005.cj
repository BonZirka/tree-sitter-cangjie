/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: litconstexpr005.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconstexpr_005() {
    let res = parseFile("./litconstexpr005.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("false"))
    @Assert(sourcefile.toString().contains("true"))

    @Assert(sourcefile.name, "litconstexpr005.cj")
    @Assert(sourcefile.path.contains("litconstexpr005.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconstexpr1 = (maindecl.body.nodes[0] as LitConstExpr).getOrThrow()
    var litconstexpr2 = (maindecl.body.nodes[1] as LitConstExpr).getOrThrow()

    //toString()
    @Assert(litconstexpr1.toString(), "false")
    @Assert(litconstexpr2.toString(), "true")
    //rawValue
    @Assert(litconstexpr1.rawValue, "false")
    @Assert(litconstexpr2.rawValue, "true")
    //kind
    match (litconstexpr1.kind) {
        case LitConstKind.BoolLiteral => ()
        case _ => @Assert(false)
    }
    match (litconstexpr2.kind) {
        case LitConstKind.BoolLiteral => ()
        case _ => @Assert(false)
    }
}
}