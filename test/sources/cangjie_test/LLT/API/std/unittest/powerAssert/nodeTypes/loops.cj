/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color 2>&1 | compare %f

import std.unittest.*
import std.unittest.testmacro.*

@Test
class LoopsTest {
    @TestCase
    func case1() {
        var x = 5
        var y = 0
        @PowerAssert( 
            (while (x > 0) { x--; y++ }, y)[1],
            x
        )
    }

    /* SCAN-IN
    Assert Failed: `((while (x > 0) { x--; y++ }, y)[1] == x)`
                    ||__________________________||_|   |  |_|
                    |             ()              5    |   0
                    |__________________________________|
                                      5
     */
    @TestCase
    func case2() {
        var x = 5
        var y = 0
        @PowerAssert( 
            (do { x--; y++ } while (x > 0), y)[1],
            x
        )
    }

    /* SCAN-IN
    Assert Failed: `((do { x--; y++ } while(x > 0), y)[1] == x)`
                    ||____________________________||_|   |  |_|
                    |              ()               5    |   0
                    |____________________________________|
                                       5
     */
    @TestCase
    func case3() {
        var x = 5
        var y = 0
        @PowerAssert( 
            (for (i in 5..-5:-1 where i > 0){ x--; y++ }, y)[1],
            x
        )
    }

    /* SCAN-IN
    Assert Failed: `((for (i in 5..- 5:- 1 where i > 0) { x--; y++ }, y)[1] == x)`
                    ||______________________________________________||_|   |  |_|
                    |                       ()                        5    |   0
                    |______________________________________________________|
                                                5
     */
}
