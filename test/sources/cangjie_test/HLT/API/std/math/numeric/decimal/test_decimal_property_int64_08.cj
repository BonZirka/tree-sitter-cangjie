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

let dec1 = Decimal.parse("1")
let dec2 = Decimal.parse("1e2")
let dec3 = Decimal.parse("1e4")

@Test
class Test_decimal_property_int64_08 {
    @TestCase
    func test_decimal_int64_01(): Unit {
        let dec = Decimal(0i64)
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
    func test_decimal_int64_02(): Unit {
        let dec = Decimal(Int64.Max)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("9223372036854775807"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 19)
        @Expect(dec.toString(), "9223372036854775807")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_03(): Unit {
        let dec = Decimal(Int64.Min)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-9223372036854775808"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 19)
        @Expect(dec.toString(), "-9223372036854775808")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_04(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(15, roundingMode: Up)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-922337203685478"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "-9223372036854780000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_05(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(17, roundingMode: Up)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("92233720368547759"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 17)
        @Expect(dec.toString(), "9223372036854775900")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_06(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(15, roundingMode: Down)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-922337203685477"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "-9223372036854770000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_07(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(17, roundingMode: Down)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("92233720368547758"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 17)
        @Expect(dec.toString(), "9223372036854775800")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_08(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(17, roundingMode: Ceiling)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-92233720368547758"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 17)
        @Expect(dec.toString(), "-9223372036854775800")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_09(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(15, roundingMode: Ceiling)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("922337203685478"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "9223372036854780000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_10(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(15, roundingMode: Floor)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-922337203685478"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "-9223372036854780000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_11(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(17, roundingMode: Floor)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("92233720368547758"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 17)
        @Expect(dec.toString(), "9223372036854775800")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_12(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(15, roundingMode: HalfUp)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-922337203685478"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "-9223372036854780000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_13(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(17, roundingMode: HalfUp)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("92233720368547758"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 17)
        @Expect(dec.toString(), "9223372036854775800")
        @Expect(dec.isInteger(), true)
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_14(): Unit {
        let dec = Decimal(Int64.Min).roundWithPrecision(15, roundingMode: HalfEven)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-922337203685478"))
        @Expect(dec.scale, -4)
        @Expect(dec.precision, 15)
        @Expect(dec.toString(), "-9223372036854780000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_15(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(16, roundingMode: HalfEven)
        let dec1 = Decimal.parse("1e3")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("9223372036854776"))
        @Expect(dec.scale, -3)
        @Expect(dec.precision, 16)
        @Expect(dec.toString(), "9223372036854776000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_int64_16(): Unit {
        let dec = Decimal(Int64.Max).roundWithPrecision(12, roundingMode: HalfEven)
        let dec1 = Decimal.parse("1e7")
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("922337203685"))
        @Expect(dec.scale, -7)
        @Expect(dec.precision, 12)
        @Expect(dec.toString(), "9223372036850000000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }
}
