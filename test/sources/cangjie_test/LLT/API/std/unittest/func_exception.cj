/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %n.%suffix %run_utest_opt %run_args --no-color | compare %f
// ASSERT: scan-1 [ ERROR  ] CASE: x
// ASSERT: scan-1 REASON: An exception has occurred:AssertException: I want this test to fail
// ASSERT: scan-1 ERROR: 1
// ASSERT: scan-1 FAILED: 0

@Test
func x(): Unit {
    throw AssertException("I want this test to fail")
}
