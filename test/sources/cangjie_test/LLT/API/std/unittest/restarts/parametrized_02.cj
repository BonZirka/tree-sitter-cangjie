/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --death-aware --no-color | compare %f
// ASSERT: scan-4 [ FAILED ] CASE: case1
// ASSERT: scan-1 PASSED: 0, SKIPPED: 0, ERROR: 0
// ASSERT: scan-1 FAILED: 1

import std.unittest.*
import std.process.*

@Test
public class TestParametrizedTests {
    @TestCase[x in [ 1, 2, 0, 3, 4 ]]
    func case1(x: Int64): Unit {
        @Expect(0, x)
    }
}
