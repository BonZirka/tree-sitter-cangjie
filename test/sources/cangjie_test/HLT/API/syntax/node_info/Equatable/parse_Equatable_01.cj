/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Equatable_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import stdx.syntax.*

// 节点的内�&源文�&解析方式完全相同
@Test
class test_01{
    @TestCase
func test_equatable_001() {
    let res_1 = parseFile("./Equatable_01.cj")
    let sourcefile_1: SourceFile = res_1.node.getOrThrow()
    let sourcefile_2: SourceFile = sourcefile_1
    @Assert(sourcefile_1 == sourcefile_2)
    sourcefile_1.toString()
    sourcefile_1.hashCode()
    @Assert(sourcefile_1 == sourcefile_2)
}
}