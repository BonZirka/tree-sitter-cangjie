/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

@Test
class Test_great {
    @TestCase
    func Test_great_01(): Unit {
        let time1 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 1)
        let time2 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let res = time1.compare(time2)
        @Assert(res, Ordering.GT)
    }

    @TestCase
    func Test_great_02(): Unit {
        let time1 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let time2 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let res = time1.compare(time2)
        @Assert(res, Ordering.EQ)
    }

    @TestCase
    func Test_great_03(): Unit {
        let time1 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let time2 = DateTime.of(year: 999999999, month: 12, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 1)
        let res = time1.compare(time2)
        @Assert(res, Ordering.LT)
    }
}
