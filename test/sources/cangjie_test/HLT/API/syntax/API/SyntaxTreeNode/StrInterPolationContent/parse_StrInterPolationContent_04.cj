/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: StrInterPolationContent_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_StrInterpolationContent_04() {
    let res = parseFile("./StrInterPolationContent_04.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains(##"var a = "${if (a) {b} else {c}}""##))

    var varDecl: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    var expr: LitConstStrExpr = (varDecl.initializer.getOrThrow() as LitConstStrExpr).getOrThrow()
    match (expr.strPartExprs[0]) {
        case StrInterpolation(strIPC) =>
            @Assert(strIPC.toString(), ##"${if (a) {b} else {c}}"##)
            @Assert(strIPC.interpolationBlock.toString(), ##"{if (a) {b} else {c}}"##)
        case _ => @Assert(false)
    }
}
}