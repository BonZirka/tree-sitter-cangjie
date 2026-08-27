/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: SpawnExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SpawnExpr_01() {
    let res = parseFile("./SpawnExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().replace("\r","").contains(##"main() {
    spawn { add(1, 2) }
    spawn(tc) { => }
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: SpawnExpr = (mainDecl.body.nodes[0] as SpawnExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"spawn { add(1, 2) }"##)
    @Assert(expr_1.threadContext.isNone())
    @Assert(expr_1.trailingLambdaExpr.toString(), "{ add(1, 2) }")
    @Assert(expr_1.trailingLambdaExpr.params.params.size, 0)
    @Assert(expr_1.trailingLambdaExpr.body.size, 1)

    var expr_2: SpawnExpr = (mainDecl.body.nodes[1] as SpawnExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"spawn(tc) { => }"##)
    @Assert(expr_2.threadContext.getOrThrow().toString(), "tc")
    @Assert(expr_2.trailingLambdaExpr.toString(), "{ => }")

    var pos = expr_2.getSpawnKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 5i32, 11i32, 10i32])
    pos = expr_2.getThreadContextLParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 10i32, 11i32, 11i32])
    pos = expr_2.getThreadContextRParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 13i32, 11i32, 14i32])
}
}