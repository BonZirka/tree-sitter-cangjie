/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ContinueExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ContinueExpr_01() {
    let res = parseFile("./ContinueExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"for (i in arr) {
        continue
    }"##))

    var maindecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var _expr = (maindecl.body.nodes[0] as ForInExpr).getOrThrow()
    @Assert(_expr.body.nodes[0] is ContinueExpr)
    @Assert((_expr.body.nodes[0] as ContinueExpr).getOrThrow().toString(), "continue")
}
}