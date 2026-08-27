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
func test_ThrowExpr_01() {
    let str_1 = ##"throw Exception()"##
    let res_1 = parseText(str_1)

    let str_2 = ##"throw IOException("")"##
    let res_2 = parseText(str_2)

    let str_3 = ##"throw IOException("hello, 仓�")"##
    let res_3 = parseText(str_3)

    var expr_1: ThrowExpr = (res_1.node.getOrThrow() as ThrowExpr).getOrThrow()
    @Assert(expr_1.toString(), ##"throw Exception()"##)
    @Assert(expr_1.throwVal.toString(), ##"Exception()"##)

    var expr_2: ThrowExpr = (res_2.node.getOrThrow() as ThrowExpr).getOrThrow()
    @Assert(expr_2.toString(), ##"throw IOException("")"##)
    @Assert(expr_2.throwVal.toString(), ##"IOException("")"##)

    var expr_3: ThrowExpr = (res_3.node.getOrThrow() as ThrowExpr).getOrThrow()
    @Assert(expr_3.toString(), ##"throw IOException("hello, 仓�")"##)
    @Assert(expr_3.throwVal.toString(), ##"IOException("hello, 仓�")"##)

    var pos = expr_1.getThrowKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 6i32])
}
}