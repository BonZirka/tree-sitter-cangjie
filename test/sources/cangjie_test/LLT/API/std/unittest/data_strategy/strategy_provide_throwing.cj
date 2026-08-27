/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %n.%suffix %run_utest_opt %run_args --no-color | compare %f
// ASSERT: scan [ PASSED ] CASE: testOkay1
// ASSERT: scan [ PASSED ] CASE: testOkay2
// ASSERT: scan [ ERROR  ] CASE: testFailing
// ASSERT: scan provide fail
// ASSERT: scan PASSED: 2, SKIPPED: 0, ERROR: 1
// ASSERT: scan FAILED: 0

import std.unittest.*
import std.unittest.testmacro.*

class StrategyFailingProvide<T> <: DataStrategy<T> & DataProvider<T> {
    StrategyFailingProvide() {}

    public func provider(configuration: Configuration): DataProvider<T> {
        return this
    }

    public func provide(): Iterable<T> {
        throw Exception("provide fail")
    }

    public prop isInfinite: Bool {
        get() {
            false
        }
    }
}

@Test
class Test_DataStrategy_Provide_Catching {
    @TestCase
    public func testOkay1() {}

    @TestCase[x in StrategyFailingProvide<Int64>()]
    public func testFailing(x: Int64) {
    }

    @TestCase
    public func testOkay2() {}
}
