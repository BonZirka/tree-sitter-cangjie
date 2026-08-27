/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt   %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan 0

import std.time.*

//@Test
class TestParseFormat {
    // 测试Time静态函数parser生成的Time实例 以及相关的运算符重载
    //    @TestCase
    public func testTimeParse() :Int64{
        print("testTimeParse\n")
        let times = [("-0000-01-01T00:00:00Z", "0000-01-01T00:00:00Z"),
            ("-00000-01-01T00:00:00Z", "-0000-01-01T00:00:00Z")]
        var index = 0;
        for (dateTime in times) {
            let time0 = DateTime.parse(dateTime[0]).toString()
            assertEqule(time0, dateTime[1], "Compare result of DateTime.parse(), the index is ${index}:")
        }

        //        let day2 = DateTime.parse("-0001-12-31T23:59:59Z")
        //        let day3 = DateTime.parse("0000-01-01T00:00:01Z")

        return 0
    }
}

func assertEqule(actual: String, expected: String, msg: String): Bool {
    if (actual != expected) {
        print(msg + ": the expect is ${expected}, but ths actual is ${actual}\n")
        return true
    }
    return false
}

main(): Int64 {
    let cases: TestParseFormat = TestParseFormat()
    return cases.testTimeParse()
}
