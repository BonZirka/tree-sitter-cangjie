/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// (Windows) DEPENDENCE: ../zoneinfo.tar.gz
// (Windows) EXEC: tar -xf zoneinfo.tar.gz
// (Unix)EXEC-PIPE: export TZ=Europe/Moscow && %run %run_opt %output %run_args
// (Windows) EXEC: cmake -E env CJ_TZPATH=%pwd\zoneinfo\ TZ=Europe/Moscow %run %run_opt %output %run_utest_opt %run_args

import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

// 测试 TZ 和 CJ_TZPATH 环境变量设置正确的情形
// 类unix系统可以不设置CJ_TZPATH，仅设置TZ

@Test
class LocalTest {
    let timeZone = TimeZone.Local
    @TestCase
    func TimeZoneToString(): Unit {
        @Expect(timeZone.toString(), "Europe/Moscow")
        @Expect(timeZone.id, "Europe/Moscow")
    }

    let dateTime = DateTime.of(year: 2023, month: March, dayOfMonth: 30, hour: 0, minute: 0, second: 0, nanosecond: 0,
        timeZone: timeZone)
    @TestCase
    func BuildDateTime(): Unit {
        @Expect(dateTime.toString(), "2023-03-30T00:00:00+03:00")
        @Expect(dateTime.zone, timeZone)
        @Expect(dateTime.zoneId, "Europe/Moscow")
    }
}
