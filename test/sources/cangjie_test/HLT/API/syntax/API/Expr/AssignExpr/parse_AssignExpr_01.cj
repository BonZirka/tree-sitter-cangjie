/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: AssignExpr_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_AssignExpr_01() {
    let res = parseFile("./AssignExpr_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"main() {
    e1 = e2
    e1 &&= e2
    a -= 2
    a **= 2
    a *= 2
    a /= 10
    a %= 6
    a <<= 2
    a **= 2.0 ** 3 ** 2
}"##))

    var mainDecl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    var expr_1: AssignExpr = (mainDecl.body.nodes[0] as AssignExpr).getOrThrow()
    match (expr_1.assignOpKind) {
        case Assign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_1.lhs.toString(), "e1")
    @Expect(expr_1.rhs.toString(), "e2")

    var expr_2: AssignExpr = (mainDecl.body.nodes[1] as AssignExpr).getOrThrow()
    match (expr_2.assignOpKind) {
        case AndAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_2.lhs.toString(), "e1")
    @Expect(expr_2.rhs.toString(), "e2")

    var expr_3: AssignExpr = (mainDecl.body.nodes[2] as AssignExpr).getOrThrow()
    match (expr_3.assignOpKind) {
        case SubAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_3.lhs.toString(), "a")
    @Expect(expr_3.rhs.toString(), "2")

    var expr_4: AssignExpr = (mainDecl.body.nodes[3] as AssignExpr).getOrThrow()
    match (expr_4.assignOpKind) {
        case ExpAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_4.lhs.toString(), "a")
    @Expect(expr_4.rhs.toString(), "2")

    var expr_5: AssignExpr = (mainDecl.body.nodes[4] as AssignExpr).getOrThrow()
    match (expr_5.assignOpKind) {
        case MulAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_5.lhs.toString(), "a")
    @Expect(expr_5.rhs.toString(), "2")

    var expr_6: AssignExpr = (mainDecl.body.nodes[5] as AssignExpr).getOrThrow()
    match (expr_6.assignOpKind) {
        case DivAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_6.lhs.toString(), "a")
    @Expect(expr_6.rhs.toString(), "10")

    var expr_7: AssignExpr = (mainDecl.body.nodes[6] as AssignExpr).getOrThrow()
    match (expr_7.assignOpKind) {
        case ModAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_7.lhs.toString(), "a")
    @Expect(expr_7.rhs.toString(), "6")

    var expr_8: AssignExpr = (mainDecl.body.nodes[7] as AssignExpr).getOrThrow()
    match (expr_8.assignOpKind) {
        case LShiftAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_8.lhs.toString(), "a")
    @Expect(expr_8.rhs.toString(), "2")

    var expr_9: AssignExpr = (mainDecl.body.nodes[8] as AssignExpr).getOrThrow()
    match (expr_9.assignOpKind) {
        case ExpAssign => ()
        case _ => @Assert(false)
    }
    @Expect(expr_9.lhs.toString(), "a")
    @Expect(expr_9.rhs.toString(), "2.0 ** 3 ** 2")

    var pos = expr_1.getAssignOpPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 8i32, 10i32, 9i32])
}
}