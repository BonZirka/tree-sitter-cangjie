/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SpawnExpr_01() {
    let str_1 = ##"spawn { add(1, 2) }"##
    let res_1 = parseText(str_1)

    let str_2 = ##"spawn(tc) { => }"##
    let res_2 = parseText(str_2)
    
    var expr_1: SpawnExpr = (res_1.node.getOrThrow() as SpawnExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"spawn { add(1, 2) }"##)
    @Assert(expr_1.threadContext.isNone())
    @Assert(expr_1.trailingLambdaExpr.toString(), "{ add(1, 2) }")
    @Assert(expr_1.trailingLambdaExpr.params.params.size, 0)
    @Assert(expr_1.trailingLambdaExpr.body.size, 1)

    var expr_2: SpawnExpr = (res_2.node.getOrThrow() as SpawnExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"spawn(tc) { => }"##)
    @Assert(expr_2.threadContext.getOrThrow().toString(), "tc")
    @Assert(expr_2.trailingLambdaExpr.toString(), "{ => }")

    var pos = expr_2.getSpawnKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 6i32])
    pos = expr_2.getThreadContextLParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 6i32, 1i32, 7i32])
    pos = expr_2.getThreadContextRParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 9i32, 1i32, 10i32])
}
}