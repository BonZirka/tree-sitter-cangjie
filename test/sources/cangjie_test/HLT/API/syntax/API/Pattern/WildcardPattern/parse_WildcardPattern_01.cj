/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: WildcardPattern_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_WildcardPattern_01() {
    let res = parseFile("./WildcardPattern_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().contains(##"var _ = a1"##))

    var _decl: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    var expr_1: WildcardPattern = (_decl.pattern as WildcardPattern).getOrThrow()
    @Assert(expr_1.toString(), "_")
}
}