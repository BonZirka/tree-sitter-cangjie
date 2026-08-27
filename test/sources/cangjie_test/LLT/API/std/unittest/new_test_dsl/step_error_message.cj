/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f --test -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_args --no-color --capture-output | compare %f
// ASSERT: scan CASE: case1 (failed 2/6 steps)
// ASSERT: scan CASE: case2 (failed 1/6 steps)
// ASSERT: scan CASE: case3 (failed after 6 steps)
// ASSERT: scan CASE: case4 (failed after 4 steps)

@Test
class Tests {
    @TestCase[x in [ 1, 2, 3, 4, 5, 6 ]]
    func case1(x: Int64) {
        @Assert(x != 1 && x != 4)
    }

    @TestCase[x in [ 1, 2, 3, 4, 5, 6 ]]
    func case2(x: Int64) {
        @Assert(x != 4)
    }

    @TestCase[x in [ 1, 2, 3, 4, 5, 6 ]]
    func case3(x: Int64) {
        @Assert(x != 6)
    }

    @TestCase[x in random()]
    @Configure[randomSeed: 3]
    func case4(x: Int64) {
        @Assert( x%5 != 0 )
    }
}
