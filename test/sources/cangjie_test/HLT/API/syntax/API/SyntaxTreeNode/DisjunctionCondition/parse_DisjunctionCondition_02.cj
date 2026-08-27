/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: DisjunctionCondition_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_DisjunctionCondition_02() {
    let res = parseFile("./DisjunctionCondition_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    if (a < b && b <= c && c >= d && !aaa && c == e && c != x) {}
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr: IfExpr = (mainDecl.body.nodes[0] as IfExpr).getOrThrow()

    let condition = expr.condition

    @Assert(condition.toString(), ##"a < b && b <= c && c >= d && !aaa && c == e && c != x"##)
    @Expect(condition.cond.size, 1)
    @Assert(condition.cond[0].toString(), ##"a < b && b <= c && c >= d && !aaa && c == e && c != x"##)
}
}