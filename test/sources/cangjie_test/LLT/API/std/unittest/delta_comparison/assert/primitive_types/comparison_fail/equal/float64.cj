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
// ASSERT: scan Assert Failed: `(1.1f64 == 1.2f64, delta: 0.01f64)`
// ASSERT: scan Assert Failed: `(1.1f64, 1.2f64, delta: 0.01f64)`
// ASSERT: scan Assert Failed: `(1.1f64 + b *(c - a) - 2.0f64 == 1.3f64 *(a + a + b - c * a), delta: 0.33f64 + c * a)`
// ASSERT: scan Assert Failed: `(1.1f64 + b *(c - a) - 2.0f64, 1.3f64 *(a + a + b - c * a), delta: 0.33f64 + c * a)`
// ASSERT: scan Assert Failed: `(1.1f64 == 1.2f64, delta: RelativeDelta(absolute: 0.01f64, relative: 0.0001f64))`
// ASSERT: scan Assert Failed: `(1.1f64, 1.2f64, delta: RelativeDelta(absolute: 0.01f64, relative: 0.0001f64))`
// ASSERT: scan Assert Failed: `(1.1f64 + b *(c - a) - 2.0f64 == 1.3f64 *(a + a + b - c * a),
// ASSERT: scan delta: RelativeDelta(absolute: 0.33f64 + c * a, relative: 0.0001f64))`
// ASSERT: scan Assert Failed: `(1.1f64 + b *(c - a) - 2.0f64, 1.3f64 *(a + a + b - c * a),
// ASSERT: scan Assert Failed: `(60503.0004f64 == 65503.003f64, delta: RelativeDelta(absolute: 0.00001f64, relative: 0.000001f64))`
// ASSERT: scan PASSED: 0, SKIPPED: 0, ERROR: 0
// ASSERT: scan FAILED: 9

import std.unittest.RelativeDelta

@Test
class Test_Float64 {

    @TestCase
    func simple(): Unit {
        @Assert(1.1f64 == 1.2f64, delta: 0.01f64)
    }
    
    @TestCase
    func simpleThreeArgs(): Unit {
        @Assert(1.1f64, 1.2f64, delta: 0.01f64)
    }

    @TestCase
    func complex(): Unit {
        let a = 0.002f64
        let b = 0.3f64
        let c = 3.11f64
        @Assert(1.1f64 + b * (c - a) - 2.0f64 == 1.3f64 * (a + a + b - c * a), delta: 0.33f64 + c * a)
    }
    
    @TestCase
    func complexThreeArgs(): Unit {
        let a = 0.002f64
        let b = 0.3f64
        let c = 3.11f64
        @Assert(1.1f64 + b * (c - a) - 2.0f64, 1.3f64 * (a + a + b - c * a), delta: 0.33f64 + c * a)
    }

    @TestCase
    func simpleRelativeDelta(): Unit {
        @Assert(1.1f64 == 1.2f64, delta: RelativeDelta(absolute: 0.01f64, relative: 0.0001f64))
    }
    
    @TestCase
    func simpleRelativeDeltaThreeArgs(): Unit {
        @Assert(1.1f64, 1.2f64, delta: RelativeDelta(absolute: 0.01f64, relative: 0.0001f64))
    }

    @TestCase
    func complexRelativeDelta(): Unit {
        let a = 0.002f64
        let b = 0.3f64
        let c = 3.11f64
        @Assert(1.1f64 + b * (c - a) - 2.0f64 == 1.3f64 * (a + a + b - c * a),
            delta: RelativeDelta(absolute: 0.33f64 + c * a, relative: 0.0001f64))
    }
    
    @TestCase
    func complexRelativeDeltaThreeArgs(): Unit {
        let a = 0.002f64
        let b = 0.3f64
        let c = 3.11f64
        @Assert(1.1f64 + b * (c - a) - 2.0f64, 1.3f64 * (a + a + b - c * a),
            delta: RelativeDelta(absolute: 0.33f64 + c * a, relative: 0.0001f64))
    }

    @TestCase
    func simpleRelativeDeltaMatters(): Unit {
        @Assert(60503.0004f64 == 65503.003f64, delta: RelativeDelta(absolute: 0.00001f64, relative: 0.000001f64))
    }
}
