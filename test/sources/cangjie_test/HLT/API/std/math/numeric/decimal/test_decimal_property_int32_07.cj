/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt -o %output %f %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.math.numeric.*
import std.math.*
import std.collection.*

@Test
class Test_decimal_property_int32_07 {
    @TestCase
    func test_decimal_int32_01(): Unit {
        let dec = Decimal(0i32)
        let dec1 = Decimal.parse("1")
        @Expect(dec.sign, 0)
        @Expect(dec.value, BigInt("0"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 1)
        @Expect(dec.toString(), "0")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_02(): Unit {
        let dec = Decimal(Int32.Max)
        let dec1 = Decimal.parse("1")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("2147483647"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 10)
        @Expect(dec.toString(), "2147483647")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_03(): Unit {
        let dec = Decimal(Int32.Min)
        let dec1 = Decimal.parse("1")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-2147483648"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 10)
        @Expect(dec.toString(), "-2147483648")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_04(): Unit {
        let dec = Decimal(Int32.Min).roundWithPrecision(5, roundingMode: Up)
        let dec1 = Decimal.parse("1e5")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-21475"))
        @Expect(dec.scale, -5)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "-2147500000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_05(): Unit {
        let dec = Decimal(Int32.Max).roundWithPrecision(5, roundingMode: Up)
        let dec1 = Decimal.parse("1e5")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("21475"))
        @Expect(dec.scale, -5)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "2147500000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_06(): Unit {
        let dec = Decimal(123456i32).roundWithPrecision(4, roundingMode: Down)
        let dec1 = Decimal.parse("1e2")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("1234"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 4)
        @Expect(dec.toString(), "123400")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_07(): Unit {
        let dec = Decimal(-123456i32).roundWithPrecision(4, roundingMode: Down)
        let dec1 = Decimal.parse("1e2")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-1234"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 4)
        @Expect(dec.toString(), "-123400")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_08(): Unit {
        let dec = Decimal(12345678i32).roundWithPrecision(4, roundingMode: Ceiling)
        let dec1 = Decimal.parse("1e4")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("1235"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 4)
        @Expect(dec.toString(), "12350000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_09(): Unit {
        let dec = Decimal(-12345678i32).roundWithPrecision(5, roundingMode: Ceiling)
        let dec1 = Decimal.parse("1e3")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-12345"))
        @Expect(dec.scale, -3)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "-12345000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_10(): Unit {
        let dec = Decimal(22345678i32).roundWithPrecision(6, roundingMode: Floor)
        let dec1 = Decimal.parse("1e2")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("223456"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 6)
        @Expect(dec.toString(), "22345600")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_11(): Unit {
        let dec = Decimal(-22345678i32).roundWithPrecision(5, roundingMode: Floor)
        let dec1 = Decimal.parse("1e3")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-22346"))
        @Expect(dec.scale, -3)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "-22346000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_12(): Unit {
        let dec = Decimal(-5678920i32).roundWithPrecision(5, roundingMode: HalfUp)
        let dec1 = Decimal.parse("1e2")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-56789"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "-5678900")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_13(): Unit {
        let dec = Decimal(5678990i32).roundWithPrecision(5, roundingMode: HalfUp)
        let dec1 = Decimal.parse("1e2")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("56790"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "5679000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_14(): Unit {
        let dec = Decimal(5678555i32).roundWithPrecision(6, roundingMode: HalfEven)
        let dec1 = Decimal.parse("1e1")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("567856"))
        @Expect(dec.scale, -1)
        @Expect(dec.precision, 6)
        @Expect(dec.toString(), "5678560")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int32_15(): Unit {
        let dec = Decimal(-5678555i32).roundWithPrecision(6, roundingMode: HalfEven)
        let dec1 = Decimal.parse("1e1")
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-567856"))
        @Expect(dec.scale, -1)
        @Expect(dec.precision, 6)
        @Expect(dec.toString(), "-5678560")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }
}
