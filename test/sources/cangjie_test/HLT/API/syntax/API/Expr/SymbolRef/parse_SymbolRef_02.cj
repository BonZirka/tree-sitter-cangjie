/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: SymbolRef_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SymbolRef_02() {
    let res = parseFile("./SymbolRef_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    a = b
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: AssignExpr = (mainDecl.body.nodes[0] as AssignExpr).getOrThrow()
    var expr_2: SymbolRef = (expr_1.lhs as SymbolRef).getOrThrow()
    @Expect(expr_2.toString(), ##"a"##)
    @Assert(expr_2.name, "a")
    @Assert(expr_2.typeArguments.size, 0)

    var expr_3: SymbolRef = (expr_1.rhs as SymbolRef).getOrThrow()
    @Expect(expr_3.toString(), ##"b"##)
    @Assert(expr_3.name, "b")
    @Assert(expr_3.typeArguments.size, 0)
}
}