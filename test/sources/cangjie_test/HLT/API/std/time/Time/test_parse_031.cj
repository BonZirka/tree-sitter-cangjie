/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt   %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run %run_opt %output %run_utest_opt %run_args | compare %f
// ASSERT: scan-not Failure
// ASSERT: scan-not Exception
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

@Test
class TestParseFormat {
    @TestCase
    public func testTimeParse(): Unit {
        var index = 0
        try {
            let time0 = DateTime.parse("00:00:10", "yyyy-MM-dd-wwww").toString()
        } catch (e0: TimeParseException) {
            index += 1
            @Expect(e0.message, "Fail to parse at index 2: \":\" should be integer.")
        }

        try {
            let time1 = DateTime.parse("00:30:01", "yyyy-MM-dd-wwww").toString()
        } catch (e1: TimeParseException) {
            index += 1
            @Expect(e1.message, "Fail to parse at index 2: \":\" should be integer.")
        }

        try {
            let time2 = DateTime.parse("12:59:00", "yyyy-MM-dd-wwww").toString()
        } catch (e2: TimeParseException) {
            index += 1
            @Expect(e2.message, "Fail to parse at index 2: \":\" should be integer.")
        }

        @Expect(index, 3)
    }
}
