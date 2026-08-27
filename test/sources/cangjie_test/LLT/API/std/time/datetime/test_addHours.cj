/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./test_datetime_pub.cj
// (Windows) DEPENDENCE: ../zoneinfo.tar.gz
// (Windows) EXEC: tar -xf zoneinfo.tar.gz
// EXEC: %compiler %cmp_opt %f test_datetime_pub.cj %cmp_utest_opt -o %output
// (Unix)EXEC-PIPE: %run %run_opt %output %run_args
// (Windows) RUN-EXEC-PIPE-0: cmake -E env CJ_TZPATH=%pwd\zoneinfo\ %run %run_opt %output %run_utest_opt %run_args

import std.time.*
import std.math.*

@Test
public class AddHoursTest {
    @TestCase
    func add1DayHours(): Unit {
        var dateTime = DateTime.ofUTC(year: 2023, month: 2, dayOfMonth: 28)
        var after = dateTime.addHours(HOURS_PER_DAY)
        var expect = DateTime.ofUTC(year: 2023, month: 3, dayOfMonth: 1)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 28)
        after = dateTime.addHours(HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 29)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 29)
        after = dateTime.addHours(HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2024, month: 3, dayOfMonth: 1)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2023, month: 12, dayOfMonth: 31)
        after = dateTime.addHours(HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2024, month: 1, dayOfMonth: 1)
        @Expect(after, expect)
    }

    @TestCase
    func sub1DayHours(): Unit {
        var dateTime = DateTime.ofUTC(year: 2023, month: 3, dayOfMonth: 1)
        var after = dateTime.addHours(-HOURS_PER_DAY)
        var expect = DateTime.ofUTC(year: 2023, month: 2, dayOfMonth: 28)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 29)
        after = dateTime.addHours(-HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 28)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2024, month: 3, dayOfMonth: 1)
        after = dateTime.addHours(-HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2024, month: 2, dayOfMonth: 29)
        @Expect(after, expect)

        dateTime = DateTime.ofUTC(year: 2024, month: 1, dayOfMonth: 1)
        after = dateTime.addHours(-HOURS_PER_DAY)
        expect = DateTime.ofUTC(year: 2023, month: 12, dayOfMonth: 31)
        @Expect(after, expect)
    }

    @TestCase
    func addHoursOutOfRange_1(): Unit {
        var datetime = DateTime.ofUTC(year: MAX_YEAR, month: 12, dayOfMonth: 31)
        try {
            datetime.addHours(HOURS_PER_DAY)
            @Expect(false)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "The result of year is outside the range [-999,999,999, 999,999,999].")
        }

        datetime = DateTime.ofUTC(year: 2023, month: 3, dayOfMonth: 31)
        try {
            datetime.addHours(Int64.Max)
            @Expect(false)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "The result of year is outside the range [-999,999,999, 999,999,999].")
        }
    }

    @TestCase
    func addHoursOutOfRange_2(): Unit {
        var datetime = DateTime.ofUTC(year: MIN_YEAR, month: 1, dayOfMonth: 1)
        try {
            datetime.addHours(-HOURS_PER_DAY)
            @Expect(false)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "The result of year is outside the range [-999,999,999, 999,999,999].")
        }

        datetime = DateTime.ofUTC(year: -2023, month: 3, dayOfMonth: 31)
        try {
            datetime.addHours(Int64.Min)
            @Expect(false)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "The result of year is outside the range [-999,999,999, 999,999,999].")
        }
    }

    @TestCase
    func addAndSubHourSkipDst(): Unit {
        // 2022-03-27 02:00  ~ 2022-10-30 01:59
        // DST for London
        let london = TimeZone.load("Europe/London")
        let dateTime1 = DateTime.of(year: 2022, month: 3, dayOfMonth: 27, hour: 0, minute: 15, second: 0, nanosecond: 0,
            timeZone: london)
        var dateTime2 = dateTime1.addHours(2)
        @Expect(dateTime2.toString(), "2022-03-27T03:15:00+01:00")
        dateTime2 = dateTime2.addHours(-2)
        @Expect(dateTime2, dateTime1)
    }
}
