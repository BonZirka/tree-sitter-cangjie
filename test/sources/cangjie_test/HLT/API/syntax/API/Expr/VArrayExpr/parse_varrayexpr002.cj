/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: varrayexpr002.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_varrayliteral_002() {
    let res = parseFile("./varrayexpr002.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("VArray<Int64, $5>({ i => i})"))
    @Assert(sourcefile.name, "varrayexpr002.cj")
    @Assert(sourcefile.path.contains("varrayexpr002.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var varrayliteral = (maindecl.body.nodes[0] as VArrayExpr).getOrThrow()
    //toString()
    @Assert(varrayliteral.toString(), "VArray<Int64, $5>({ i => i})")

    //argument
    @Assert(varrayliteral.argument.toString(), "{ i => i}")
    @Assert(varrayliteral.argument.value.toString(), "{ i => i}")
    @Assert(varrayliteral.argument.isInOut, false)
    @Assert(varrayliteral.argument.identifier.isNone())
}
}