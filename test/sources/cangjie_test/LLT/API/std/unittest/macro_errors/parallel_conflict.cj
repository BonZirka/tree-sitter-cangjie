/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// RUN-EXEC-PIPE-1: %compiler %cmp_opt %f -o %output %cmp_utest_opt 2>&1 | compare %f

@Test
class C {
    @Parallel
    @TestCase
    func x() {}
}

@Test
@Bench
@Parallel
func f() {
}

// ASSERT: scan-2 can't be used together
// ASSERT: scan-1 @Parallel macro can't be used together with @Bench.
// ASSERT: scan-1 @Parallel macro can't be used together with @TestCase.
