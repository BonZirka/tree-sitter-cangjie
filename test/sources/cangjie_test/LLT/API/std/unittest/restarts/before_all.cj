/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --death-aware --no-color | compare %f
// ASSERT: scan-1 [ ERROR  ] Before all step failed. Tests not run.
// ASSERT: scan-1 REASON: Crashed with exit code 42.
// ASSERT: scan-1 PASSED: 1, SKIPPED: 0, ERROR: 1
// ASSERT: scan-1 FAILED: 1

import std.process.*
import std.unittest.testmacro.*
import std.unittest.*

@Test
func passingBefore() {
    @Assert(0, 0)
}

@Test
class Tests {
    @BeforeAll
    func beforeAll() {
        Process.current.exit(42)
    }

    @TestCase
    func passing1() {
        @Assert(1, 1)
    }

    @TestCase
    func failing2() {
        @Assert(1, 2)
    }
}

@Test
func failingAfter() {
    @Assert(0, 1)
}
