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
func test_MemberAccess_01() {
    let str_1 = ##"a.b1"##
    let res_1 = parseText(str_1)

    let str_2 = ##"a().b1"##
    let res_2 = parseText(str_2)

    let str_3 = ##"a(a).b1"##
    let res_3 = parseText(str_3)

    let str_4 = ##"a(a:a).b1"##
    let res_4 = parseText(str_4)

    let str_5 = ##"a<T>().b1"##
    let res_5 = parseText(str_5)

    let str_6 = ##"a.b.b1"##
    let res_6 = parseText(str_6)

    var expr_1 = (res_1.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_1.base.toString(), "a")
    @Assert(expr_1.field.toString(), "b1")

    var expr_2 = (res_2.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_2.base.toString(), "a()")
    @Assert(expr_2.field.toString(), "b1")

    var expr_3 = (res_3.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_3.base.toString(), "a(a)")
    @Assert(expr_3.field.toString(), "b1")

    var expr_4 = (res_4.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_4.base.toString(), "a(a:a)")
    @Assert(expr_4.field.toString(), "b1")

    var expr_5 = (res_5.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_5.base.toString(), "a<T>()")
    @Assert(expr_5.field.toString(), "b1")

    var expr_6 = (res_6.node.getOrThrow() as MemberAccess).getOrThrow()
    @Assert(expr_6.base.toString(), "a.b")
    @Assert(expr_6.field.toString(), "b1")

    var pos = expr_1.getDotPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 2i32, 1i32, 3i32])
}
}