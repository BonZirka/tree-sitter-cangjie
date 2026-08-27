/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args --include-tags=TagA+TagB --exclude-tags=TagC --no-color 2>&1 | compare %f
// ASSERT: scan-1 [ PASSED ] CASE: caseAA
// ASSERT: scan-1 [ PASSED ] CASE: topfuncA
// ASSERT: scan-1 [ PASSED ] CASE: topfuncC
// ASSERT: scan-not [ FAILED ]
// ASSERT: scan-1 PASSED: 3
// ASSERT: scan-1 SKIPPED: 2

import std.unittest.*
import std.unittest.testmacro.*

@Test
@Tag[TagA]
class SomeTestClassA {
    @TestCase
    @Tag[TagB]
    func caseAA() {
        @Assert(1, 1)
    }

    @TestCase
    @Tag[TagC]
    @Tag[TagB]
    func caseAC() {
        @Fail("Should not run")
    }
}

@Test
@Tag[TagA]
@Tag[TagB]
func topfuncA() {
    @Assert(1, 1)
}

@Test
@Tag[TagB, TagC]
func topfuncB() {
    @Fail("Should not run")
}

@Test
@Tag[TagB]
@Tag[TagA]
func topfuncC() {
    @Assert(1, 1)
}
