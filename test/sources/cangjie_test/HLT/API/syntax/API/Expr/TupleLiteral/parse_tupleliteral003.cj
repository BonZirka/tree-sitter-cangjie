/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: tupleliteral003.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_tupleliteral_003() {
    let res = parseFile("./tupleliteral003.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("(3, 3.141592, \"PI\")"))
    @Assert(sourcefile.name, "tupleliteral003.cj")
    @Assert(sourcefile.path.contains("tupleliteral003.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var tupleliteral = (maindecl.body.nodes[0] as TupleLiteral).getOrThrow()
    //toString()
    @Assert(tupleliteral.toString(), "(3, 3.141592, \"PI\")")

    //elements
    var tuple = tupleliteral.elements
    @Assert(tuple.size,3)
    var x = tuple.get(0).getOrThrow().toString()
    @Assert(x,"3")
}
}