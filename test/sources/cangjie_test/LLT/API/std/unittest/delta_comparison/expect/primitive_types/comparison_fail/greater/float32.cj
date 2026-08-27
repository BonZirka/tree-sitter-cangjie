/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC: %compiler %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC-1: %run %run_opt %n.%suffix %run_utest_opt %run_args
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args --no-color 2>&1 | compare %f
// ASSERT: scan Expect Failed: `(1.11f32 > 1.1f32, delta: 0.1f32)`
// ASSERT: scan Expect Failed: `(1.3f32 *(a + a + b - c * a) > 4.1f32 + b *(c - a) - 2.0f32, delta: 0.1f32 + c * a)`
// ASSERT: scan Expect Failed: `(1.11f32 > 1.1f32, delta: RelativeDelta(absolute: 0.1f32, relative: 0.0001f32))`
// ASSERT: scan Expect Failed: `(1.3f32 *(a + a + b - c * a) > 4.1f32 + b *(c - a) - 2.0f32,
// ASSERT: scan delta: RelativeDelta(absolute: 0.1f32 + c * a, relative: 0.0001f32))`
// ASSERT: scan PASSED: 0, SKIPPED: 0, ERROR: 0
// ASSERT: scan FAILED: 4

import std.unittest.RelativeDelta

@Test
class Test_Float32 {

    @TestCase
    func simple(): Unit {
        @Expect(1.11f32 > 1.1f32, delta: 0.1f32)
    }

    @TestCase
    func complex(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @Expect(1.3f32 * (a + a + b - c * a) > 4.1f32 + b * (c - a) - 2.0f32, delta: 0.1f32 + c * a)
    }

    @TestCase
    func simpleRelativeDelta(): Unit {
        @Expect(1.11f32 > 1.1f32, delta: RelativeDelta(absolute: 0.1f32, relative: 0.0001f32))
    }

    @TestCase
    func complexRelativeDelta(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @Expect(1.3f32 * (a + a + b - c * a) > 4.1f32 + b * (c - a) - 2.0f32,
            delta: RelativeDelta(absolute: 0.1f32 + c * a, relative: 0.0001f32))
    }
}
