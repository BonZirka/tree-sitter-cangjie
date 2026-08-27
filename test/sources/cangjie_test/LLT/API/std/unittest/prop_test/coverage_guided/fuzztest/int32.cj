/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL:0
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt --sanitizer-coverage-trace-pc-guard --sanitizer-coverage-trace-compares 
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt --no-color --coverage-guided | compare %f
// ASSERT: scan with randomSeed = 42
// ASSERT: scan Assert Failed
// ASSERT: scan lhv =
// ASSERT: scan rhv =

import std.unittest.*
import std.unittest.testmacro.*

@Strategy[lhv in random(), rhv in random()]
@OverflowWrapping
func strat(lhv: Int32, rhv: Int32): Int32 {
    lhv - rhv
}


@Test[val in strat]
@Configure[randomSeed: 42, generationSteps: 500]
func fooTest(val: Int32): Unit {
    @Assert(val != 0)
}