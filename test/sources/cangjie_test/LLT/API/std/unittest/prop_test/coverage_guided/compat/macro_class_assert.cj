/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt --sanitizer-coverage-trace-pc-guard --sanitizer-coverage-trace-compares 
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt --no-color --coverage-guided | compare %f
// ASSERT: scan with randomSeed = 42
// ASSERT: scan Assert Failed
// ASSERT: scan data =

import std.unittest.*
import std.unittest.testmacro.*

@Test
@Configure[randomSeed: 42]
class FooTest {
    @TestCase[data in random()]
    func fooTest(data: Array<?Int64>): Unit {
        if (data.size < 2) {
            return
        }
        @Assert(data[0] != data[1])
    }
}
