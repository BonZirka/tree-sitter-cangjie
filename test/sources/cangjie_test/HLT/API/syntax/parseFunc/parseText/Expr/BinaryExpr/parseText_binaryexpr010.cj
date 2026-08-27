/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_binaryexpr_010() {
    let str = ##"(1^(8&15))|24"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var binaryexpr = (sourceNode as BinaryExpr).getOrThrow()
    //toString()
    @Assert(binaryexpr.toString(), "(1^(8&15))|24")

    //lhs
    @Assert(binaryexpr.lhs.toString(),"(1^(8&15))")

    //rhs
    @Assert(binaryexpr.rhs.toString(),"24")

    //opKind
    match (binaryexpr.opKind) {
        case BinaryOpKind.BitOr => ()
        case _ => @Assert(false)
    }
}
}