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

import std.math.*

@Test
class Test_math_logbase_01 {
    @TestCase
    func test_logbase_float16_01(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(-1),Float16(9)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_02(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(0),Float16(9)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_03(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(1),Float16(-100)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_04(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(1),Float16(0)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_05(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(1),Float16(1)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_06(): Unit {
        let e = @AssertThrows[IllegalArgumentException](logBase(Float16(-100),Float16(1)))
        @Expect(e.message, "The input parameter is invalid. Please enter a correct parameter.")
    }

    @TestCase
    func test_logbase_float16_07(): Unit {
        let logbase = logBase(Float16(32.0), Float16(2.0))
        @Expect(logbase, 4.99609)
    }

    @TestCase
    func test_logbase_float16_08(): Unit {
        let logbase = logBase(Float16(32.234), Float16(2.12))
        @Expect(logbase, 4.625)
    }
}
