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
func test_SymbolRef_02() {
    let str = ##"B1"##
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var _expr: SymbolRef = (sourceNode as SymbolRef).getOrThrow()
    @Expect(_expr.toString(), ##"B1"##)
    @Assert(_expr.name, "B1")
    @Assert(_expr.typeArguments.size, 0)
    @Assert(_expr.getCommasPos().size == 0, true)
}
}