/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color 2>&1 | compare %f
// ASSERT: scan PASSED: 0, SKIPPED: 0, ERROR: 0
// ASSERT: scan FAILED: 4

import std.unittest.RelativeDelta

@Test
class Test_Float16 {

    @TestCase
    func simple(): Unit {
        @PowerAssert(0.1f32 >= 1.1f32, delta: 0.1f32)
    }

/* SCAN-IN
Assert Failed: `((0.1f32) >= (1.1f32) with delta: 0.1f32 )`
*/

    @TestCase
    func complex(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @PowerAssert(0.3f32 * (a + a + b - c * a) >= 2.1f32 + b * (c - a) - 2.0f32, delta: 0.1f32 + c * a)
    }

/* SCAN-IN
Assert Failed: `((0.3f32 * (a + a + b - c * a)) >= (2.1f32 + b * (c - a) - 2.0f32) with delta: 0.1f32 + c * a )`
                     |         |_| | | | | |_| | ||    |        |_|  | | |_||        |            |        |_| | |
                     |       0.002000| | 3.110000||    |      0.300000 0.002000      |            |      3.110000|
                     |         |   |_| | | |   |_||    |        |    |_|   ||        |            |        |   |_|
                     |         | 0.002000| | 0.002000  |        |  3.110000||        |            |        | 0.002000
                     |         |_____| | | |_____||    |        |    |_____||        |            |        |_____|
                     |         0.004000| | 0.006220    |        |    3.108000        |            |        0.006220
                     |         |       |_|       ||    |        |___________|        |            |______________|
                     |         |     0.300000    ||    |           0.932400 |        |                0.106220
                     |         |_________|       ||    |____________________|        |
                     |         | 0.304000        ||    |      3.032400               |
                     |         |_________________||    |_____________________________|
                     |               0.297780     |                1.032400
                     |____________________________|
                                0.089334

*/


    @TestCase
    func simpleRelativeDelta(): Unit {
        @PowerAssert(0.11f32 >= 1.1f32, delta: RelativeDelta(absolute: 0.1f32, relative: 0.0001f32))
    }

/* SCAN-IN
Assert Failed: `((0.11f32) >= (1.1f32) with delta: RelativeDelta(absolute: 0.1f32, relative: 0.0001f32) )`
*/

    @TestCase
    func complexRelativeDelta(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @PowerAssert(0.3f32 * (a + a + b - c * a) >= 2.1f32 + b * (c - a) - 2.0f32,
            delta: RelativeDelta(absolute: 0.1f32 + c * a, relative: 0.0001f32))
    }

/* SCAN-IN
Assert Failed: `((0.3f32 * (a + a + b - c * a)) >= (2.1f32 + b * (c - a) - 2.0f32) with delta: RelativeDelta(absolute: 0.1f32 + c * a, relative: 0.0001f32) )`
                     |         |_| | | | | |_| | ||    |        |_|  | | |_||        |                                    |        |_| | |
                     |       0.002000| | 3.110000||    |      0.300000 0.002000      |                                    |      3.110000|
                     |         |   |_| | | |   |_||    |        |    |_|   ||        |                                    |        |   |_|
                     |         | 0.002000| | 0.002000  |        |  3.110000||        |                                    |        | 0.002000
                     |         |_____| | | |_____||    |        |    |_____||        |                                    |        |_____|
                     |         0.004000| | 0.006220    |        |    3.108000        |                                    |        0.006220
                     |         |       |_|       ||    |        |___________|        |                                    |______________|
                     |         |     0.300000    ||    |           0.932400 |        |                                        0.106220
                     |         |_________|       ||    |____________________|        |
                     |         | 0.304000        ||    |      3.032400               |
                     |         |_________________||    |_____________________________|
                     |               0.297780     |                1.032400
                     |____________________________|
                                0.089334
*/
}
