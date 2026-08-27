/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: regex (.*FAIL.*) CASE: case01
// ASSERT: regex (.*FAIL.*) CASE: case02
// ASSERT: regex-not (.*FAIL.*) CASE: case03

import std.unittest.*
import std.unittest.testmacro.*

func getRes(a: Int32, b: Int32, c: Int32): Array<Int32> {
    var arr: Array<Int32> = [a, b, c]
    return arr
}

@Test
class TestA {
    @TestCase
    public func case01(): Unit {
        var expect: Array<Int32> = [1, 2, 3]
        var actual: Array<Int32> = [3, 2, 3]
        expectEqual("expect", "actual", expect, actual)
    }

    @TestCase
    public func case02(): Unit {
        var expect: Array<Int32> = [1, 2, 3]
        expectEqual("expect", "actual", expect, getRes(3, 2, 3))
    }

    @TestCase
    public func case03(): Unit {
        var expect: Array<Int32> = [1, 2, 3]
        expectEqual("expect", "actual", expect, getRes(1, 2, 3))
    }
}
