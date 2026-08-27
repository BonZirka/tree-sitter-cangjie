/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: varrayexpr001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_varrayliteral_001() {
    let res = parseFile("./varrayexpr001.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains("VArray<Int64, $5>(repeat: 0)"))
    @Assert(sourcefile.name, "varrayexpr001.cj")
    @Assert(sourcefile.path.contains("varrayexpr001.cj"))
    @Assert(sourcefile.pkgHeader.isNone())

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var varrayliteral = (maindecl.body.nodes[0] as VArrayExpr).getOrThrow()
    //toString()
    @Assert(varrayliteral.toString(), "VArray<Int64, $5>(repeat: 0)")

    //argument
    @Assert(varrayliteral.argument.toString(), "repeat: 0")
    @Assert(varrayliteral.argument.value.toString(), "0")
    @Assert(varrayliteral.argument.isInOut, false)
    @Assert(varrayliteral.argument.identifier.getOrThrow().toString(), "repeat")

    var pos = varrayliteral.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 22i32, 10i32, 23i32])
    pos = varrayliteral.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 32i32, 10i32, 33i32])
}
}