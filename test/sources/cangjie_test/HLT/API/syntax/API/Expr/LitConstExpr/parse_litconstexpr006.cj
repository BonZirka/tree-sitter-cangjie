/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: litconstexpr006.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconstexpr_006() {
    let res = parseFile("./litconstexpr006.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("2e4f16"))

    @Assert(sourcefile.name, "litconstexpr006.cj")
    @Assert(sourcefile.path.contains("litconstexpr006.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconstexpr = (maindecl.body.nodes[0] as LitConstExpr).getOrThrow()
    //toString()
    @Assert(litconstexpr.toString(), "2e4f16")
    //rawValue
    @Assert(litconstexpr.rawValue, "2e4f16")
    //kind
    match (litconstexpr.kind) {
        case LitConstKind.FloatLiteral => ()
        case _ => @Assert(false)
    }
}
}