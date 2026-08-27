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
func test_litconstexpr_005() {
    var litconstexpr1 = (parseTokens(quote(false)).node.getOrThrow() as LitConstExpr).getOrThrow()
    var litconstexpr2 = (parseTokens(quote(true)).node.getOrThrow() as LitConstExpr).getOrThrow()

    //toString()
    @Assert(litconstexpr1.toString(), "false")
    @Assert(litconstexpr2.toString(), "true")
    //rawValue
    @Assert(litconstexpr1.rawValue, "false")
    @Assert(litconstexpr2.rawValue, "true")
    //kind
    match (litconstexpr1.kind) {
        case LitConstKind.BoolLiteral => ()
        case _ => @Assert(false)
    }
    match (litconstexpr2.kind) {
        case LitConstKind.BoolLiteral => ()
        case _ => @Assert(false)
    }
}
}