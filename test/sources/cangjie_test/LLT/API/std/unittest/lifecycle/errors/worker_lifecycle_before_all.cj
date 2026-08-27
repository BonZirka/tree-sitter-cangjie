/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color --timeout-each=1s | compare %f
// ASSERT: scan PASSED: 0, SKIPPED: 0, ERROR: 1
// ASSERT: scan Expect Failed: `(1 == 0 == true)`
// ASSERT: scan Before all step failed. Tests not run.

import std.unittest.*
import std.unittest.testmacro.*

@Test
class Tests2 {
    @BeforeAll
    func before(): Unit {
        @Expect(1 == 0)
    }

    @TestCase
    func f() {
    }
}
