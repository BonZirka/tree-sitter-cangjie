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
func test_AssignExpr_01() {
    let str_1 = ##"e1 = e2"##
    let res_1 = parseText(str_1)

    let str_2 = ##"e1 &&= e2"##
    let res_2 = parseText(str_2)

    let str_3 = ##"a -= 2"##
    let res_3 = parseText(str_3)

    let str_4 = ##"a **= 2"##
    let res_4 = parseText(str_4)

    let str_5 = ##"a *= 2"##
    let res_5 = parseText(str_5)

    let str_6 = ##"a /= 10"##
    let res_6 = parseText(str_6)

    let str_7 = ##"a %= 6"##
    let res_7 = parseText(str_7)

    let str_8 = ##"a <<= 2"##
    let res_8 = parseText(str_8)

    let str_9 = ##"a **= 2.0 ** 3 ** 2"##
    let res_9 = parseText(str_9)

    var expr_1: AssignExpr = (res_1.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_1.assignOpKind) {
        case Assign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_1.lhs.toString(), "e1")
    @Expect(expr_1.rhs.toString(), "e2")

    var expr_2: AssignExpr = (res_2.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_2.assignOpKind) {
        case AndAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_2.lhs.toString(), "e1")
    @Expect(expr_2.rhs.toString(), "e2")

    var expr_3: AssignExpr = (res_3.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_3.assignOpKind) {
        case SubAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_3.lhs.toString(), "a")
    @Expect(expr_3.rhs.toString(), "2")

    var expr_4: AssignExpr = (res_4.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_4.assignOpKind) {
        case ExpAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_4.lhs.toString(), "a")
    @Expect(expr_4.rhs.toString(), "2")

    var expr_5: AssignExpr = (res_5.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_5.assignOpKind) {
        case MulAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_5.lhs.toString(), "a")
    @Expect(expr_5.rhs.toString(), "2")

    var expr_6: AssignExpr = (res_6.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_6.assignOpKind) {
        case DivAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_6.lhs.toString(), "a")
    @Expect(expr_6.rhs.toString(), "10")

    var expr_7: AssignExpr = (res_7.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_7.assignOpKind) {
        case ModAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_7.lhs.toString(), "a")
    @Expect(expr_7.rhs.toString(), "6")

    var expr_8: AssignExpr = (res_8.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_8.assignOpKind) {
        case LShiftAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_8.lhs.toString(), "a")
    @Expect(expr_8.rhs.toString(), "2")

    var expr_9: AssignExpr = (res_9.node.getOrThrow() as AssignExpr).getOrThrow()
    match (expr_9.assignOpKind) {
        case ExpAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_9.lhs.toString(), "a")
    @Expect(expr_9.rhs.toString(), "2.0 ** 3 ** 2")

    var pos = expr_1.getAssignOpPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 4i32, 1i32, 5i32])
}
}