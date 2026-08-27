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

@Test
class T {

    @TestCase
    func simple(): Unit {
        @PowerAssert(1.01f32 != 1.014f32, delta: 0.01f32)
    }

/* SCAN-IN
Assert Failed: `((1.01f32) != (1.014f32) with delta: 0.01f32 )`
*/

    @TestCase
    func complex(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @PowerAssert(1.1f32 + b * (c - a) - 2.0f32 != 1.3f32 * (a + a + b - c * a), delta: 0.35f32 + c * a)
    }

/* SCAN-IN
Assert Failed: `((1.1f32 + b * (c - a) - 2.0f32) != (1.3f32 * (a + a + b - c * a)) with delta: 0.35f32 + c * a )`
                     |        |_|  | | |_||        |    |         |_| | | | | |_| | ||            |         |_| | |
                     |      0.300000 0.002000      |    |       0.002000| | 3.110000||            |       3.110000|
                     |        |    |_|   ||        |    |         |   |_| | | |   |_||            |         |   |_|
                     |        |  3.110000||        |    |         | 0.002000| | 0.002000          |         | 0.002000
                     |        |    |_____||        |    |         |_____| | | |_____||            |         |_____|
                     |        |    3.108000        |    |         0.004000| | 0.006220            |         0.006220
                     |        |___________|        |    |         |       |_|       ||            |_______________|
                     |           0.932400 |        |    |         |     0.300000    ||                 0.356220
                     |____________________|        |    |         |_________|       ||
                     |      2.032400               |    |         | 0.304000        ||
                     |_____________________________|    |         |_________________||
                                 0.032400               |               0.297780     |
                                                        |____________________________|
                                                                   0.387114
*/

   @TestCase
    func simpleRelativeDelta(): Unit {
        @PowerAssert(1.01f32 != 1.015f32, delta: RelativeDelta(absolute: 0.01f32, relative: 0.0001f32))
    }

/* SCAN-IN
Assert Failed: `((1.01f32) != (1.015f32) with delta: RelativeDelta(absolute: 0.01f32, relative: 0.0001f32) )`
*/

    @TestCase
    func complexRelativeDelta(): Unit {
        let a = 0.002f32
        let b = 0.3f32
        let c = 3.11f32
        @PowerAssert(1.1f32 + b * (c - a) - 2.0f32 != 1.3f32 * (a + a + b - c * a),
            delta: RelativeDelta(absolute: 0.35f32 + c * a, relative: 0.0001f32))
    }

/* SCAN-IN
Assert Failed: `((1.1f32 + b * (c - a) - 2.0f32) != (1.3f32 * (a + a + b - c * a)) with delta: RelativeDelta(absolute: 0.35f32 + c * a, relative: 0.0001f32) )`
                     |        |_|  | | |_||        |    |         |_| | | | | |_| | ||                                    |         |_| | |
                     |      0.300000 0.002000      |    |       0.002000| | 3.110000||                                    |       3.110000|
                     |        |    |_|   ||        |    |         |   |_| | | |   |_||                                    |         |   |_|
                     |        |  3.110000||        |    |         | 0.002000| | 0.002000                                  |         | 0.002000
                     |        |    |_____||        |    |         |_____| | | |_____||                                    |         |_____|
                     |        |    3.108000        |    |         0.004000| | 0.006220                                    |         0.006220
                     |        |___________|        |    |         |       |_|       ||                                    |_______________|
                     |           0.932400 |        |    |         |     0.300000    ||                                         0.356220
                     |____________________|        |    |         |_________|       ||
                     |      2.032400               |    |         | 0.304000        ||
                     |_____________________________|    |         |_________________||
                                 0.032400               |               0.297780     |
                                                        |____________________________|
                                                                   0.387114
*/
}