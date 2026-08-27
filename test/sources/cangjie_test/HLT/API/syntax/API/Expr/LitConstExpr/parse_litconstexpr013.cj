/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: litconstexpr013.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_litconstexpr_013() {
    let res = parseFile("./litconstexpr013.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("Hello"))

    @Assert(sourcefile.name, "litconstexpr013.cj")
    @Assert(sourcefile.path.contains("litconstexpr013.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var litconstexpr = (maindecl.body.nodes[0] as LitConstExpr).getOrThrow()
    //toString()
    @Assert(litconstexpr.toString().replace("\r",""), "'''\nHello,\nCangjie Lang'''" )
    //rawValue
    @Assert(litconstexpr.rawValue.replace("\r",""), "Hello,\nCangjie Lang" )
    //kind
    match (litconstexpr.kind) {
        case LitConstKind.StringLiteral => ()
        case _ => @Assert(false)
    }
}
}