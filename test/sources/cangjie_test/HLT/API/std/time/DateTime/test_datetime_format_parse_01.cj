/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.time.*

@Test
class Test_datetime_format_tryparse_01 {
    @TestCase
    func test_datetime_format_01(): Unit {
        let time = DateTime.of(year: 2008, month: February, dayOfMonth: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        //println(time.format("&^%#$^*&()"))

        // let e = @AssertThrows[IllegalArgumentException](res.format(""))
        // println(e.message)
        //@Expect(e.message, "The opened end of the range 1 is greater than the size 0.")      

        // res.format("\0") 
        // res.format("$%&*^*%") 
        // res.format("仓颉鸿蒙")       
    }

    @TestCase
    func test_datetime_format_02(): Unit {
        let time = DateTime.of(year: 2008, month: February, dayOfMonth: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let str = "yyyy-MM-dd HH:mm:ss OOO"
        @Expect(time.format(str).contains("2008-02-29 00:00:00"))
    }

    @TestCase
    func test_datetime_format_03(): Unit {
        let time = DateTime.of(year: 2008, month: February, dayOfMonth: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let str = "yyyy-MM-dd HH:mm:ss"
        @Expect(time.format(str), "2008-02-29 00:00:00")
    }

    @TestCase
    func test_datetime_format_04(): Unit {
        let time = DateTime.of(year: 2008, month: February, dayOfMonth: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let str = "yyyy/MM/dd HH:mm:ss"
        @Expect(time.format(str), "2008/02/29 00:00:00")
    }

    @TestCase
    func test_datetime_format_05(): Unit {
        let time = DateTime.of(year: 2008, month: February, dayOfMonth: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let str = "2024年06月20日14时42分33秒+08:008"
        @Expect(time.format(str), "2024年06月20日14时42分33秒+08:008")
    }

    @TestCase
    func test_datetime_format_06(): Unit {
        let time = DateTime.ofEpoch(second: 60, nanosecond: 0)
        let str = "2024年06月20日14时42分33秒+08:008"
        @Expect(time.format(str), "2024年06月20日14时42分33秒+08:008")
    }

    @TestCase
    func test_datetime_format_07(): Unit {
        let time = DateTime.ofEpoch(second: 60, nanosecond: 0)
        let str = "202406月20日14时42分33秒+08:008"
        @Expect(time.format(str), "202406月20日14时42分33秒+08:008")
    }

    @TestCase
    func test_datetime_format_08(): Unit {
        let time = DateTime.ofEpoch(second: 60, nanosecond: 0)
        let str = "2023-04-24-Fri"
        @Expect(time.format(str), "2023-04-24-Fri")
    }

    @TestCase
    func test_datetime_format_09(): Unit {
        let time = DateTime.ofEpoch(second: 60, nanosecond: 0)
        let str = "2023-04-24-Fri"
        @Expect(time.format(str), "2023-04-24-Fri")
    }

    @TestCase
    func test_datetime_tryparse_10(): Unit {
        @Expect(DateTime.tryParse(""), Option<DateTime>.None)
        @Expect(DateTime.tryParse("\0"), Option<DateTime>.None)
        @Expect(DateTime.tryParse("仓颉鸿蒙"), Option<DateTime>.None)
        @Expect(DateTime.tryParse("%$#^@$#"), Option<DateTime>.None)
        @Expect(DateTime.tryParse("2023-04-10T08:00:00.123+08:00").getOrThrow().toString(), "2023-04-10T08:00:00.123+08:00")
        @Expect(DateTime.tryParse("2024年06月20日14时42分33秒+08:008"), Option<DateTime>.None)
        @Expect(DateTime.tryParse("yyyy-MM-ddTHH:mm:ssOOOO"), Option<DateTime>.None)

        @Expect(DateTime.tryParse("2023-04-10T08:00"), Option<DateTime>.None)
        @Expect(DateTime.tryParse("2023-04-10T08:00:00+09:00").getOrThrow().toString(), "2023-04-10T08:00:00+09:00")
        @Expect(DateTime.tryParse("2023-04-10T08:00:00.01"), Option<DateTime>.None)
    }
}
