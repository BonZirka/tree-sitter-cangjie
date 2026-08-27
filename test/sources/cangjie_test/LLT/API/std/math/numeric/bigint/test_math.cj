/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 

import std.math.numeric.*

@Test
class BigIntMathTest {
    @TestCase
    func add(): Unit {
        let a = BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16)
        let b = BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16)
        let c = a + b
        @Expect(c.toString(radix: 16).toAsciiLower(), "1fffffffffffffffe")
        let d = BigInt.parse("1", radix: 2)
        let e = a + d
        @Expect(e.toString(radix: 16).toAsciiLower(), "10000000000000000")
        let f = BigInt.parse("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let g = BigInt.parse("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let h = f + g
        @Expect(h.toString(radix: 16).toAsciiLower(), "1fffffffffffffffffffffffffffffffffffffffffffffffe")
        let f0 = BigInt.parse("-FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let g0 = BigInt.parse("-FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let h0 = f0 + g0
        @Expect(h0.toString(radix: 16).toAsciiLower(), "-1fffffffffffffffffffffffffffffffffffffffffffffffe")
        let i = f + d
        @Expect(i.toString(radix: 16).toAsciiLower(), "1000000000000000000000000000000000000000000000000")
        let j = BigInt.parse("123", radix: 10)
        let k = BigInt.parse("0", radix: 10)
        let l = BigInt.parse("-1", radix: 10)
        let m = BigInt.parse("1", radix: 10)
        @Expect((j+k).toString(), "123")
        @Expect((j+l).toString(), "122")
        @Expect((j+m).toString(), "124")
        let n = BigInt("1234567891012345645678910123456")
        let o = BigInt("-1244567891012345645678910123456")
        @Expect(n+o == o+n)
        @Expect((n+o).toString(), "-10000000000000000000000000000")
        @Expect(BigInt("-1") + BigInt("18446744073709551617"), BigInt("18446744073709551616"))
        @Expect(BigInt("-114514") + (BigInt("18446744073709551616") + BigInt("114514")), BigInt("18446744073709551616"))
    }

    @TestCase
    func sub(): Unit {
        let a = BigInt.parse("1fffffffffffffffe", radix: 16)
        let b = BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16)
        let c = a - b
        @Expect(c.toString(radix: 16), "FFFFFFFFFFFFFFFF")
        let c0 = b - a
        @Expect(c0==-c)
        let d0 = BigInt.parse("10000000000000000", radix: 16)
        let d = BigInt.parse("1", radix: 2)
        let e = d0 - d
        @Expect(e.toString(radix: 16), "FFFFFFFFFFFFFFFF")
        let f = BigInt.parse("1fffffffffffffffffffffffffffffffffffffffffffffffe", radix: 16)
        let g = BigInt.parse("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let h = f - g
        let h0 = g - f
        @Expect(h==-h0)
        @Expect(h.toString(radix: 16), "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
        let d1 = BigInt.parse("1000000000000000000000000000000000000000000000000", radix: 16)
        let i = d1 - d
        @Expect(i.toString(radix: 16), "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
        let j = BigInt.parse("123", radix: 10)
        let k = BigInt.parse("0", radix: 10)
        let l = BigInt.parse("-1", radix: 10)
        let m = BigInt.parse("1", radix: 10)
        @Expect((j-k).toString(), "123")
        @Expect((j-l).toString(), "124")
        @Expect((j-m).toString(), "122")
        var n = BigInt.parse("-2000000000000e", radix: 16)
        var o = BigInt.parse("-1000000000000f", radix: 16)
        var p = o - n
        @Expect(p.toString(radix: 16).toAsciiLower(), "fffffffffffff")
        n = BigInt.parse("-2000000000000e", radix: 16)
        o = BigInt.parse("-1000000000000d", radix: 16)
        p = o - n
        @Expect(p.toString(radix: 16), "10000000000001")
        n = BigInt.parse("-2000000000000e", radix: 16)
        o = BigInt.parse("-2000000000000e", radix: 16)
        p = o - n
        @Expect(p.toString(radix: 16), "0")
        @Expect(BigInt("-1") - BigInt("-18446744073709551617"), BigInt("18446744073709551616"))
    }

    @TestCase
    func mul(): Unit {
        let a = BigInt.parse("FFFFFFFFFFFFFFFF", radix: 16)
        let b = BigInt.parse("-FFFFFFFFFFFFFFFF", radix: 16)
        let c = a * b
        @Expect(c.toString(radix: 16).toAsciiLower(), "-fffffffffffffffe0000000000000001")
        @Expect((a*b).toString(), (b*a).toString())
        let d = BigInt.parse("-2", radix: 3)
        let e = d * b
        @Expect(e.toString(radix: 16).toAsciiLower(), "1fffffffffffffffe")
        @Expect(e.toString(), (b*d).toString())
        let f = BigInt.parse("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let g = BigInt.parse("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", radix: 16)
        let h = f * g
        @Expect(h.toString(radix: 16).toAsciiLower(), "fffffffffffffffffffffffffffffffffffffffffffffffe000000000000000000000000000000000000000000000001")
        @Expect(h.toString(), (g*f).toString())
        let i = f * d
        @Expect(i.toString(radix: 16).toAsciiLower(), "-1fffffffffffffffffffffffffffffffffffffffffffffffe")
        @Expect(i.toString(), (d*f).toString())
        let j = BigInt.parse("123", radix: 10)
        let k = BigInt.parse("0", radix: 10)
        let l = BigInt.parse("-1", radix: 10)
        let m = BigInt.parse("1", radix: 10)
        @Expect((j*k).toString(), "0")
        @Expect((j*k).toString(), (k*j).toString())
        @Expect((j*l).toString(), "-123")
        @Expect((j*m).toString(), "123")
    }

    @TestCase
    func divAndMod(): Unit {
        var dividend = BigInt.parse("0", radix: 10)
        var divisor = BigInt.parse("1", radix: 10)
        var r = dividend / divisor
        @Expect(r.toString(), "0")
        r = dividend.divAndMod(divisor)[0]
        @Expect(r.toString(), "0")
        divisor = BigInt.parse("0", radix: 10)
        try {
            dividend.divAndMod(divisor)
            @Expect(1, 2)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "Divided by zero!")
        }
        try {
            dividend / divisor
            @Expect(1, 2)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "Divided by zero!")
        }
        try {
            dividend % divisor
            @Expect(1, 2)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "Divided by zero!")
        }
        dividend = BigInt.parse("-98", radix: 10)
        divisor = BigInt.parse("10", radix: 10)
        var r0 = dividend / divisor
        var mod = dividend % divisor
        r = dividend.divAndMod(divisor)[0]
        var mod0 = dividend.divAndMod(divisor)[1]
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "-9")
        @Expect(mod.toString(), "-8")
        @Expect(r*divisor+mod == dividend)

        r = divisor.divAndMod(dividend)[0]
        mod = divisor.divAndMod(dividend)[1]
        r0 = divisor / dividend
        mod0 = divisor % dividend

        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "0")
        @Expect(mod.toString(), "10")
        @Expect(r*dividend+mod == divisor)
        // 2^64 = 18,446,744,073,709,551,616
        dividend = BigInt.parse("-18446744073709551616", radix: 10)
        divisor = BigInt.parse("-18446744073709551618", radix: 10)
        r0 = dividend / divisor
        mod0 = dividend % divisor
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "0")
        @Expect(mod.toString(), "-18446744073709551616")
        @Expect(r*divisor+mod == dividend)
        r = divisor.divAndMod(dividend)[0]
        mod = divisor.divAndMod(dividend)[1]
        r0 = divisor / dividend
        mod0 = divisor % dividend
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "1")
        @Expect(mod.toString(), "-2")
        @Expect(r*dividend+mod == divisor)
        dividend = BigInt.parse("-18446744073709551615", radix: 10)
        divisor = BigInt.parse("-18446744073709551618", radix: 10)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "0")
        @Expect(mod.toString(), "-18446744073709551615")
        @Expect(r*divisor+mod == dividend)
        // divisor less or equal than 0xFFFF_FFFF
        dividend = BigInt.parse("18446744073709551616", radix: 10)
        divisor = BigInt.parse("-4294967295", radix: 10)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(), "-4294967297")
        @Expect(mod.toString(), "1")
        @Expect(r*divisor+mod == dividend)
        // divisor less or equal than 0xFFFF_FFFF_FFFF_FFFF and bigger than 0xFFFF_FFFF
        dividend = BigInt.parse("-800000000000000000000000", radix: 16)
        divisor = BigInt.parse("8000000000000001", radix: 16)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "-ffffffff")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "-7fffffff00000001")
        @Expect(r*divisor+mod == dividend)
        dividend = BigInt.parse("-200000000000000000000000", radix: 16)
        divisor = BigInt.parse("2000000000000001", radix: 16)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "-ffffffff")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "-1fffffff00000001")
        @Expect(r*divisor+mod == dividend)
        // array Knuth
        dividend = BigInt.parse("-80000000000000000000000000000000", radix: 16)
        divisor = BigInt.parse("800000000000000000000001", radix: 16)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "-ffffffff")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "-7fffffffffffffff00000001")
        @Expect(r*divisor+mod == dividend)

        dividend = BigInt.parse("-80000000000000000000000000000000", radix: 16)
        divisor = BigInt.parse("800000000001000000000001", radix: 16)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "-ffffffff")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "-7fff00000000ffff00000001")
        @Expect(r*divisor+mod == dividend)

        dividend = BigInt.parse("-20000000000000000000000000000000", radix: 16)
        divisor = BigInt.parse("200000000000000000000001", radix: 16)
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "-ffffffff")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "-1fffffffffffffff00000001")
        @Expect(r*divisor+mod == dividend)

        dividend = BigInt("10000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
        divisor = BigInt("100000000000000000000")
        var (qu, re) = dividend.divAndMod(divisor)
        @Expect(qu, BigInt("100000000000000000000000000000000000000000000000000000000000000000"))
        @Expect(re, BigInt("0"))
        r = dividend.divAndMod(divisor)[0]
        mod = dividend.divAndMod(divisor)[1]
        r0 = dividend / divisor
        mod0 = dividend % divisor
        @Expect(r0 == r)
        @Expect(mod == mod0)
        @Expect(r.toString(radix: 16).toAsciiLower(), "f316271c7fc3908a8bef464e3945ef7a25360a0000000000000000")
        @Expect(mod.toString(radix: 16).toAsciiLower(), "0")
        @Expect(r*divisor+mod == dividend)
    }

    @TestCase
    func quoAndRem(): Unit {
        var dividend = BigInt(-3)
        var divisor = BigInt(4)
        var q0 = dividend.quo(divisor)
        var r0 = dividend.rem(divisor)
        var q = dividend.quoAndRem(divisor)[0]
        var r = dividend.quoAndRem(divisor)[1]
        @Expect(q0 == q)
        @Expect(r0 == r)
        @Expect(q.toString(), "-1")
        @Expect(r.toString(), "1")
        @Expect(q*divisor+r == dividend)
        var d = dividend / divisor
        var m = dividend % divisor
        @Expect(d.toString(), "0")
        @Expect(m.toString(), "-3")

        dividend = BigInt(-3)
        divisor = BigInt(-4)
        q0 = dividend.quo(divisor)
        r0 = dividend.rem(divisor)
        q = dividend.quoAndRem(divisor)[0]
        r = dividend.quoAndRem(divisor)[1]
        @Expect(q0 == q)
        @Expect(r0 == r)
        @Expect(q.toString(), "1")
        @Expect(r.toString(), "1")
        @Expect(q*divisor+r == dividend)
        d = dividend / divisor
        m = dividend % divisor
        @Expect(d.toString(), "0")
        @Expect(m.toString(), "-3")

        dividend = BigInt(-4)
        divisor = BigInt(4)
        q0 = dividend.quo(divisor)
        r0 = dividend.rem(divisor)
        q = dividend.quoAndRem(divisor)[0]
        r = dividend.quoAndRem(divisor)[1]
        @Expect(q0 == q)
        @Expect(r0 == r)
        @Expect(q.toString(), "-1")
        @Expect(r.toString(), "0")
        @Expect(q*divisor+r == dividend)
        d = dividend / divisor
        m = dividend % divisor
        @Expect(d == q)
        @Expect(r == m)

        dividend = BigInt(3)
        divisor = BigInt(-4)
        q0 = dividend.quo(divisor)
        r0 = dividend.rem(divisor)
        q = dividend.quoAndRem(divisor)[0]
        r = dividend.quoAndRem(divisor)[1]
        @Expect(q0 == q)
        @Expect(r0 == r)
        @Expect(q.toString(), "0")
        @Expect(r.toString(), "3")
        @Expect(q*divisor+r == dividend)
        d = dividend / divisor
        m = dividend % divisor
        @Expect(d == q)
        @Expect(r == m)

        dividend = BigInt.parse("-" + "f" * 16 + "0" + "f" * 15, radix: 16)
        divisor = BigInt.parse("1" + "0" * 16, radix: 16)
        q = dividend.quo(divisor)
        r = dividend.rem(divisor)
        d = dividend / divisor
        m = dividend % divisor
        @Expect(d.toString(radix: 16), "-ffffffffffffffff".toAsciiUpper())
        @Expect(m.toString(radix: 16), "-fffffffffffffff".toAsciiUpper())
        @Expect(q.toString(radix: 16), "-10000000000000000".toAsciiUpper())
        @Expect(r.toString(radix: 16), "f000000000000001".toAsciiUpper())
        @Expect((q*divisor+r) == dividend)
        @Expect(d*divisor+m == dividend)

        dividend = BigInt.parse("-" + "f" * 16 + "0" + "f" * 15, radix: 16)
        divisor = BigInt.parse("-1" + "0" * 16, radix: 16)
        q = dividend.quo(divisor)
        r = dividend.rem(divisor)
        d = dividend / divisor
        m = dividend % divisor
        @Expect(d.toString(radix: 16), "ffffffffffffffff".toAsciiUpper())
        @Expect(m.toString(radix: 16), "-fffffffffffffff".toAsciiUpper())
        @Expect(q.toString(radix: 16), "10000000000000000".toAsciiUpper())
        @Expect(r.toString(radix: 16), "f000000000000001".toAsciiUpper())
        @Expect((q*divisor+r) == dividend)
        @Expect(d*divisor+m == dividend)
    }

    @TestCase
    func modInverse(): Unit {
        var n = BigInt(0)
        var m = BigInt(1)
        var i = n.modInverse(m)
        @Expect(i == BigInt(0))

        n = BigInt(22)
        i = n.modInverse(m)
        @Expect(i == BigInt(0))

        m = BigInt(0)
        try {
            n.modInverse(m)
            @Expect(false)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The BigInt is not relatively prime with the input.")
        }

        m = BigInt(4)
        try {
            i = n.modInverse(m)
            println(i)
            @Expect(false)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The BigInt is not relatively prime with the input.")
        }

        n = BigInt.parse("10000000000000000", radix: 16)
        m = BigInt.parse("ffffffffffffffff", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt(1))

        m = BigInt.parse("-ffffffffffffffff", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt(1))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("-10000000000000000", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt(-1))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("-1000000000000000", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt.parse("-10", radix:16))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("ffffffffffffffff", radix: 16)
        m = BigInt.parse("10000000000000000", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt.parse("ffffffffffffffff", radix:16))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("-ffffffffffffffff", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt.parse("-ffffffffffffffff", radix:16))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("fffffffff", radix: 16)
        m = BigInt.parse("100000000000000000000", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt.parse("feffffffffefffffffff", radix:16))
        @Expect(i*n%m == BigInt(1))

        n = BigInt.parse("-fffffffff", radix: 16)
        i = n.modInverse(m)
        @Expect(i == BigInt.parse("-feffffffffefffffffff", radix:16))
        @Expect(i*n%m == BigInt(1))
    }

    @TestCase
    func abs(): Unit {
        var i = BigInt.parse("ffffffffffffffff", radix: 16)
        var ii = abs(i)
        @Expect(i == ii)
        i = BigInt.parse("-ffffffffffffffff", radix: 16)
        ii = abs(i)
        @Expect(i+ii == BigInt(0))
        i = BigInt.parse("-1ffffffffffffffff", radix: 16)
        ii = abs(i)
        @Expect(i+ii == BigInt(0))
        i = BigInt.parse("-10", radix: 16)
        ii = -i
        @Expect(i+ii == BigInt(0))
    }

    @TestCase
    func opposite(): Unit {
        var i = BigInt.parse("ffffffffffffffff", radix: 16)
        var ii = -i
        @Expect(i+ii == BigInt(0))
        i = BigInt.parse("-ffffffffffffffff", radix: 16)
        ii = -i
        @Expect(i+ii == BigInt(0))
        i = BigInt.parse("-1ffffffffffffffff", radix: 16)
        ii = -i
        @Expect(i+ii == BigInt(0))
        i = BigInt.parse("-10", radix: 16)
        ii = -i
        @Expect(i+ii == BigInt(0))
    }

    @TestCase
    func pow(): Unit {
        var i = BigInt(1)
        var ii = i ** 3
        @Expect(ii.toString(), "1")
        i = BigInt(-1)
        ii = i ** 3
        @Expect(ii.toString(), "-1")
        ii = i ** 1086868686
        @Expect(ii.toString(), "1")
        i = BigInt.parse("98391283y91274391797qeqeqe", radix: 36)
        ii = i ** 0
        @Expect(ii.toString(), "1")
        i = BigInt(-2)
        ii = i ** 63
        @Expect(ii.toString(), "-9223372036854775808")
        ii = i ** 64
        @Expect(ii.toString(), "18446744073709551616")
        var s = "000000000000000000000000000000"
        i = BigInt(("-1" + s))
        ii = i ** 64
        s *= 64
        @Expect(ii.toString(), ("1"+s))
        i = BigInt(0)
        ii = i ** 0
        @Expect(ii.toString(), "1")
        ii = i ** 10
        @Expect(ii.toString(), "0")
    }

    @TestCase
    func modPow(): Unit {
        var i = BigInt(1)
        var ii = i.modPow(BigInt(3))
        @Expect(ii.toString(), "1")
        i = BigInt(-1)
        ii = i.modPow(BigInt(3))
        @Expect(ii.toString(), "-1")
        ii = i.modPow(BigInt(1086868686))
        @Expect(ii.toString(), "1")
        i = BigInt.parse("98391283y91274391797qeqeqe", radix: 36)
        ii = i.modPow(BigInt(0))
        @Expect(ii.toString(), "1")
        i = BigInt(-2)
        ii = i.modPow(BigInt(63))
        @Expect(ii.toString(), "-9223372036854775808")
        ii = i.modPow(BigInt(64))
        @Expect(ii.toString(), "18446744073709551616")
        var s = "000000000000000000000000000000"
        i = BigInt(("-1" + s))
        ii = i.modPow(BigInt(64))
        s *= 64
        @Expect(ii.toString(), ("1"+s))
        i = BigInt(0)
        ii = i.modPow(BigInt(0))
        @Expect(ii.toString(), "1")
        ii = i.modPow(BigInt(10))
        @Expect(ii.toString(), "0")

        try {
            i.modPow(BigInt(-1))
            @Expect(false)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The exponent can not be negative.")
        }
        try {
            i.modPow(BigInt(1), m: BigInt(0))
            @Expect(false)
        } catch (e: ArithmeticException) {
            @Expect(e.message, "Divided by zero!")
        }

        i = BigInt(-2)
        ii = i.modPow(BigInt(63), m: BigInt(-1))
        @Expect(ii == BigInt(0))

        var e = BigInt.parse("10000000000000000", radix: 16)
        var m = BigInt.parse("fffffffffffff", radix: 16)
        ii = i.modPow(e, m: m)
        @Expect(ii.toString(radix: 16), "10000")

        e = BigInt.parse("1000000", radix: 16)
        ii = i.modPow(e, m: m)
        @Expect(ii.toString(radix: 16), "10000000000")

        m = BigInt.parse("fffffffffffffffffffffff", radix: 16)
        ii = i.modPow(e, m: m)
        @Expect(ii.toString(radix: 16), "10")

        i = BigInt.parse("-44444444444444", radix: 16)
        ii = i.modPow(e, m: m)
        @Expect(ii.toString(radix: 16).toAsciiLower(), "88b4f54edd0f1f66423e695")
        @Expect(e == BigInt.parse("1000000", radix: 16))
        e = BigInt.parse("ffffffffffffffff", radix: 16)
        ii = i.modPow(e, m: m)
        @Expect(ii.toString(radix: 16).toAsciiLower(), "-3db770fad8eca54bc9483a2")

        i = BigInt(-1)
        ii = i.modPow(BigInt(3), m: BigInt(2))
        @Expect(ii.toString(), "-1")
        ii = i.modPow(BigInt(3), m: BigInt(1))
        @Expect(ii.toString(), "0")
    }

    @TestCase
    func sqrt(): Unit {
        var i = BigInt("64")
        var si = sqrt(i)
        @Expect(si.toString(), "8")
        i = BigInt("65")
        si = sqrt(i)
        @Expect(si.toString(), "8")
        i = BigInt("63")
        si = sqrt(i)
        @Expect(si.toString(), "7")

        i = BigInt.parse("10000000000000000", radix: 16)
        si = sqrt(i)
        @Expect(si.toString(radix: 16), "100000000")
        i = BigInt.parse("10000000000000001", radix: 16)
        si = sqrt(i)
        @Expect(si.toString(radix: 16), "100000000")
        i = BigInt.parse("ffffffffffffffff", radix: 16)
        si = sqrt(i)
        @Expect(si.toString(radix: 16), "FFFFFFFF")

        i = BigInt.parse("0000000000000000", radix: 16)
        si = sqrt(i)
        @Expect(si.toString(), "0")

        i = BigInt.parse("123456789012345678901234567890", radix: 10)
        si = sqrt(i)
        @Expect(si.toString(), "351364182882014")

        i = BigInt.parse("-1", radix: 16)
        try {
            si = sqrt(i)
            @Expect(1, 2)
        } catch (e: IllegalArgumentException) {
            @Expect(e.message, "The BigInt be used to calculate the square root must >= 0.")
        }
    }

    @TestCase
    func compare(): Unit {
        let i = BigInt.parse("10000000000000001", radix: 16)
        let ii = BigInt.parse("10000000000000002", radix: 16)
        let iii = BigInt.parse("20000000000000001", radix: 16)
        @Expect(i<ii)
        @Expect(i==i)
        @Expect(i<=ii)
        @Expect(i!=ii)
        @Expect(i<=i)
        @Expect(min(i, ii)==i)
        @Expect(max(i, ii)==ii)

        @Expect(i<iii)
        @Expect(iii==iii)
        @Expect(i<=iii)
        @Expect(i!=iii)
        @Expect(iii<=iii)
        @Expect(min(i, iii)==i)
        @Expect(max(i, iii)==iii)

        @Expect(ii<iii)
        @Expect(ii==ii)
        @Expect(ii<=iii)
        @Expect(ii!=iii)
        @Expect(ii<=ii)
        @Expect(min(ii, iii)==ii)
        @Expect(max(ii, iii)==iii)

        let ni = -i
        let nii = -ii
        let niii = -iii
        @Expect(ni>nii)
        @Expect(ni==ni)
        @Expect(ni>=nii)
        @Expect(ni!=nii)
        @Expect(ni>=ni)
        @Expect(min(ni, nii)==nii)
        @Expect(max(ni, nii)==ni)

        @Expect(ni>niii)
        @Expect(niii==niii)
        @Expect(ni>=niii)
        @Expect(ni!=niii)
        @Expect(niii>=niii)
        @Expect(min(ni, niii)==niii)
        @Expect(max(ni, niii)==ni)

        @Expect(nii>niii)
        @Expect(nii==nii)
        @Expect(nii>=niii)
        @Expect(nii!=niii)
        @Expect(nii>=nii)
        @Expect(min(nii, niii)==niii)
        @Expect(max(nii, niii)==nii)

        let z = BigInt(0)
        @Expect(z<ii)
        @Expect(z>nii)
        @Expect(z<=iii)
        @Expect(z>=niii)
        @Expect(min(z, ii)==z)
        @Expect(max(z, nii)==z)
    }

    @TestCase
    func gcd(): Unit {
        var n = BigInt.parse("100000000000000000000000000", radix: 16)
        var m = BigInt.parse("1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1000000000000")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("ffffffffff0000", radix: 16)
        m = BigInt.parse("ffffffffff", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "FFFFFFFFFF")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("-100000000000000000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1000000000000")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("-1", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("-1000000000000001000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("-1000000000000001000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("-1000000000000001000000000001", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1")
        @Expect(gcd(n, m) == gcd(m, n))

        n = BigInt.parse("0", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(gcd(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(gcd(n, m) == gcd(m, n))
    }

    @TestCase
    func lcm(): Unit {
        var n = BigInt.parse("100000000000000000000000000", radix: 16)
        var m = BigInt.parse("1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "100000000000000100000000000000000000000000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("ffffffffff0000", radix: 16)
        m = BigInt.parse("ffffffffff", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "FFFFFFFFFF0000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("-100000000000000000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "100000000000000100000000000000000000000000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("-1", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("-1000000000000001000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("-1000000000000001000000000000", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "1000000000000001000000000000")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("-1000000000000001000000000001", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), (n*m).toString(radix: 16))
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("0", radix: 16)
        m = BigInt.parse("-1000000000000001000000000000", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "0")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("10", radix: 16)
        m = BigInt.parse("0", radix: 16)
        @Expect(lcm(n, m).toString(radix: 16), "0")
        @Expect(lcm(n, m) == lcm(m, n))

        n = BigInt.parse("666666666", radix: 10)
        m = BigInt.parse("777777777", radix: 10)
        @Expect(lcm(n, m).toString(), "4666666662")
        @Expect(lcm(n, m) == lcm(m, n))
    }
}
