/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_CallExpr_01() {
    let str_1 = ##"foo<Int64>()"##
    let res_1 = parseText(str_1)

    let str_2 = ##"foo<Int64>((a, b))"##
    let res_2 = parseText(str_2)

    let str_3 = ##"foo<Int64>(x, b: y)"##
    let res_3 = parseText(str_3)

    let str_4 = ##"println(length(a.b))"##
    let res_4 = parseText(str_4)

    var expr_1: CallExpr = (res_1.node.getOrThrow() as CallExpr).getOrThrow()
    @Expect(expr_1.toString(), ##"foo<Int64>()"##)
    @Expect(expr_1.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_1.arguments.toString(), "[]")

    var expr_2: CallExpr = (res_2.node.getOrThrow() as CallExpr).getOrThrow()
    @Expect(expr_2.toString(), ##"foo<Int64>((a, b))"##)
    @Expect(expr_2.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_2.arguments.toString(), "[(a, b)]")

    var expr_3: CallExpr = (res_3.node.getOrThrow() as CallExpr).getOrThrow()
    @Expect(expr_3.toString(), ##"foo<Int64>(x, b: y)"##)
    @Expect(expr_3.callee.toString(), ##"foo<Int64>"##)
    @Expect(expr_3.arguments.toString(), "[x, b: y]")

    var expr_4: CallExpr = (res_4.node.getOrThrow() as CallExpr).getOrThrow()
    @Expect(expr_4.toString(), ##"println(length(a.b))"##)
    @Expect(expr_4.callee.toString(), ##"println"##)
    @Expect(expr_4.arguments.toString(), "[length(a.b)]")

    var pos = expr_1.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 11i32, 1i32, 12i32])
    pos = expr_1.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 12i32, 1i32, 13i32])
}
}