/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt   %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan-not Failure
// ASSERT: scan-not Exception

import std.time.*

class TestParseFormat {
    public func testTimeParse() : Int64{
        let times = [("1999-12-10T11:30:00AMZ", "1999-12-10T11:30:00Z"),
            ("1999-12-10T11:30:00PMZ", "1999-12-10T23:30:00Z"), ("1999-12-10T06:00:00AMZ", "1999-12-10T06:00:00Z"),
            ("1999-12-10T06:00:00PMZ", "1999-12-10T18:00:00Z")]

        var index = 0
        for (dateTime in times) {
            let time0 = DateTime.parse(dateTime[0], "yyyy-MM-ddThh:mm:ssaOOOO").toString()
            let time1 = dateTime[1]
            assertEqual(time0, time1, "Comparing the result of DateTime.parse(), the index is ${index}\n")
            index++
        }
        return 0
    }
}

func assertEqual(actual: String, expected: String, msg: String): Bool {
    if (actual != expected) {
        print(msg + "Failure\nexpect: ${expected}\nresult: ${actual}\n")
        return true
    }
    return false
}

main(): Int64 {
    let cases: TestParseFormat = TestParseFormat()
    return cases.testTimeParse()
}
