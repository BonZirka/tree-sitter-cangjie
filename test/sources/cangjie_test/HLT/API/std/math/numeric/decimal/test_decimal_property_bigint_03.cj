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

var sum = 0

@Test
class Test_decimal_property_bigint_03 {
    public override func beforeEach(): Unit {
        sum = 0
    }

    @TestCase
    func test_decimal_bigint_01(): Unit {
        let dec = Decimal(BigInt("0"), 5)
        @Expect(dec.sign, 0)
        @Expect(dec.value, BigInt("0"))
        @Expect(dec.scale, 5)
        @Expect(dec.precision, 1)
        let dec1 = dec.reScale(0, roundingMode: RoundingMode.HalfEven)
        @Expect(dec1.toString(),"0")
        @Expect(dec.removeTrailingZeros().toString(), "0")
        @Expect(dec.scaleUnit().toString(), "0.00001")
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_bigint_02(): Unit {
        let dec = Decimal(BigInt("-1000"), Int32.Max)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-1000"))
        @Expect(dec.scale, Int32.Max)
        @Expect(dec.precision, 4)
    }

    @TestCase
    func test_decimal_bigint_03(): Unit {
        let dec = Decimal(BigInt("10000"), Int32.Min)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("10000"))
        @Expect(dec.scale, Int32.Min)
        @Expect(dec.precision, 5)
    }

    @TestCase
    func test_decimal_bigint_04(): Unit {
        let dec = Decimal(BigInt("10000"))
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("10000"))
        @Expect(dec.scale, 0)
        @Expect(dec.precision, 5)
    }

    @TestCase
    func test_decimal_bigint_05(): Unit {
        let dec = Decimal(BigInt("10000"), 5).roundWithPrecision(1, roundingMode: Up)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("1"))
        @Expect(dec.scale, 1)
        @Expect(dec.precision, 1)
        @Expect(dec.toString(), "0.1")
        let dec1 = dec.reScale(10, roundingMode: RoundingMode.Up)
        @Expect(dec1.toString(), "0.1000000000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), false)
    }

    @TestCase
    func test_decimal_bigint_06(): Unit {
        let dec = Decimal(BigInt("20000"), 5).roundWithPrecision(5, roundingMode: Up)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("20000"))
        @Expect(dec.scale, 5)
        @Expect(dec.precision, 5)
        @Expect(dec.toString(), "0.20000")
        let dec1 = dec.reScale(-10, roundingMode: RoundingMode.Down)
        let dec2 = Decimal(BigInt("20000"), 5).roundWithPrecision(1, roundingMode: Up)
        let dec3 = Decimal(BigInt("1"), 5).roundWithPrecision(5, roundingMode: Up)
        @Expect(dec1.toString(), "0")
        @Expect(dec.removeTrailingZeros(), dec2)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), false)
    }

    @TestCase
    func test_decimal_bigint_07(): Unit {
        let dec = Decimal(BigInt("12345"), 6).roundWithPrecision(2, roundingMode: Down)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("12"))
        @Expect(dec.scale, 3)
        @Expect(dec.precision, 2)
        @Expect(dec.toString(), "0.012")
        let dec1 = dec.reScale(2, roundingMode: RoundingMode.Ceiling)
        let dec2 = Decimal(BigInt("1"), 3).roundWithPrecision(5, roundingMode: Up)
        @Expect(dec1.toString(), "0.02")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), false)
    }

    @TestCase
    func test_decimal_bigint_08(): Unit {
        let dec = Decimal(BigInt("12345"), -6).roundWithPrecision(2, roundingMode: Down)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("12"))
        @Expect(dec.scale, -9)
        @Expect(dec.precision, 2)
        @Expect(dec.toString(),"12000000000")
        let dec1 = dec.reScale(4, roundingMode: RoundingMode.Ceiling)
        let dec2 = Decimal(BigInt("1"), -9).roundWithPrecision(5, roundingMode: Up)
        @Expect(dec1.toString(), "12000000000.0000")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_bigint_09(): Unit {
        let dec = Decimal(BigInt("-12345"), 10).roundWithPrecision(3, roundingMode: Ceiling)
        @Expect(dec.sign, -1)
        @Expect(dec.value, BigInt("-123"))
        @Expect(dec.scale, 8)
        @Expect(dec.precision, 3)
        @Expect(dec.toString(),"-0.00000123")
        let dec1 = dec.reScale(10, roundingMode: RoundingMode.HalfEven)
        let dec2 = dec.reScale(8, roundingMode: RoundingMode.HalfEven)
        let dec3 = Decimal(BigInt("1"), 8).roundWithPrecision(5, roundingMode: Up)
        @Expect(dec1.toString(), "-0.0000012300")
        @Expect(dec1.removeTrailingZeros(), dec2)
        @Expect(dec.scaleUnit(), dec3)
        @Expect(dec.isInteger(), false)
    }

    @TestCase
    func test_decimal_bigint_10(): Unit {
        let dec = Decimal(BigInt("0"), 10).roundWithPrecision(3, roundingMode: Floor)
        @Expect(dec.sign, 0)
        @Expect(dec.value, BigInt("0"))
        @Expect(dec.scale, 10)
        @Expect(dec.precision, 1)
        @Expect(dec.toString(),"0.0000000000")
        let dec1 = dec.reScale(-1, roundingMode: RoundingMode.HalfEven)
        @Expect(dec1.toString(), "0")
        @Expect(dec1.toSciString(), "0E1")
        @Expect(dec1.toEngString(), "0.00E3")

        let dec2 = dec.reScale(0, roundingMode: RoundingMode.HalfEven)
        @Expect(dec2.toString(), "0")
        @Expect(dec2.toSciString(), "0E0")
        @Expect(dec2.toEngString(), "0E0")

        let dec3 = dec.reScale(3, roundingMode: RoundingMode.HalfEven)
        @Expect(dec3.toString(), "0.000")
        @Expect(dec3.toSciString(), "0E-3")
        @Expect(dec3.toEngString(), "0E-3")
        let dec4 = Decimal(BigInt("0"), 0).roundWithPrecision(3, roundingMode: Ceiling)
        let dec5 = Decimal(BigInt("1"), 10).roundWithPrecision(3, roundingMode: Ceiling)
        @Expect(dec.removeTrailingZeros(), dec4)
        @Expect(dec.scaleUnit(), dec5)
        @Expect(dec.isInteger(), true)
    }
    @TestCase
    func test_decimal_bigint_11(): Unit {
        let dec = Decimal(BigInt("1"), 10).roundWithPrecision(3, roundingMode: Floor)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("1"))
        @Expect(dec.scale, 10)
        @Expect(dec.precision, 1)
        @Expect(dec.toString(),"0.0000000001")
        let dec1 = dec.reScale(-10, roundingMode: RoundingMode.HalfEven)
        @Expect(dec1.toString(), "0")
        @Expect(dec1.toSciString(), "0E10")
        @Expect(dec1.toEngString(), "0.00E12")
        let dec2 = dec.reScale(0, roundingMode: RoundingMode.HalfEven)
        @Expect(dec2.toString(), "0")
        @Expect(dec2.toSciString(), "0E0")
        @Expect(dec2.toEngString(), "0E0")
        let dec3 = dec.reScale(3, roundingMode: RoundingMode.HalfEven)
        @Expect(dec3.toString(), "0.000")
        @Expect(dec3.toSciString(), "0E-3")
        @Expect(dec3.toEngString(), "0E-3")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec)
        @Expect(dec.isInteger(), false)
    }

    @TestCase
    func test_decimal_bigint_12(): Unit {
        let dec = Decimal(BigInt("12"), -10).roundWithPrecision(3, roundingMode: HalfUp)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("12"))
        @Expect(dec.scale, -10)
        @Expect(dec.precision, 2)
        @Expect(dec.toString(),"120000000000")
        let dec1 = dec.reScale(10, roundingMode: RoundingMode.HalfEven)
        @Expect(dec1.toString(), "120000000000.0000000000")
        @Expect(dec1.toSciString(), "1.200000000000000000000E11")
        @Expect(dec1.toEngString(), "120.0000000000000000000E9")
        let dec2 = Decimal(BigInt("1"), -10).roundWithPrecision(3, roundingMode: Floor)
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec2)
        @Expect(dec.isInteger(), true)
    }

    @TestCase
    func test_decimal_bigint_13(): Unit {
        let dec = Decimal(BigInt("12345"), 0).roundWithPrecision(3, roundingMode: HalfEven)
        let dec1 = Decimal(BigInt("1"), -2).roundWithPrecision(3, roundingMode: HalfEven)
        @Expect(dec.sign, 1)
        @Expect(dec.value, BigInt("123"))
        @Expect(dec.scale, -2)
        @Expect(dec.precision, 3)
        @Expect(dec.toString(),"12300")
        @Expect(dec.removeTrailingZeros(), dec)
        @Expect(dec.scaleUnit(), dec1)
        @Expect(dec.isInteger(), true)
    }
}
