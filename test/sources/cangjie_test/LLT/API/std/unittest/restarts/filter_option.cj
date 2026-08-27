/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --filter=*.test2 --death-aware --no-color | compare %f
// ASSERT: scan-1 PASSED: 0, SKIPPED: 1, ERROR: 1
// ASSERT: scan-1 [ ERROR  ] CASE: test2

internal import std.process.*

@Test
class Test {
    @TestCase
    func test2() {
        Process.current.exit(42)
    }

    @TestCase
    func test1() {}
}
