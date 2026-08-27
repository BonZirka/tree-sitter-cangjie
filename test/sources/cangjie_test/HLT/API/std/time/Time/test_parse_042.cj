/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (Windows) DEPENDENCE: ../zoneinfo.tar.gz
// (Windows) EXEC: tar -xf zoneinfo.tar.gz
// EXEC: %compiler %cmp_opt   %f -o %output
// (Windows) RUN-EXEC-PIPE-0: %export "CJ_TZPATH=%cd%/zoneinfo" && %run %run_opt %output %run_args | compare %f
// (not Windows)RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan-not Failure
// ASSERT: scan-not Exception

import std.time.*

class TestParseFormat {
    public func testTimeParse(): Int64 {
        let times = [("2020-10-01T00:00:00GMT", "2020-10-01T00:00:00Z"),
            ("1999-12-31T23:59:59GMT", "1999-12-31T23:59:59Z"), ("2021-05-31T12:30:00GMT", "2021-05-31T12:30:00Z")]

        var index = 0
        for (dateTime in times) {
            let time0 = DateTime.parse(dateTime[0], "yyyy-MM-ddTHH:mm:ssz").toString()
            let time1 = dateTime[1]
            assertEqual(time0, time1, "Comparing the result of DateTime.parse(), the index is ${index}\n")
            index++
        }
        return 0
    }
}

func assertEqual(actual: String, expected: String, msg: String): Bool {
    if (actual != expected) {
        print(msg + "Failure\nexpect: ${expected}\nresult: ${actual}\n\n")
        return true
    }
    return false
}

main(): Int64 {
    let cases: TestParseFormat = TestParseFormat()
    return cases.testTimeParse()
}
