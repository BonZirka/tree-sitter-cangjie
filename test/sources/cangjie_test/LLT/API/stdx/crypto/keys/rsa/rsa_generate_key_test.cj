/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt  -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args

import stdx.crypto.keys.*
import stdx.crypto.common.*
import std.math.numeric.BigInt

@Test
class Test_rsa_generate_key {
    @TestCase
    func test_rsa_generate_key_01(): Unit {
        var sum = 0
        try {
            RSAPrivateKey(10)
        } catch (e: CryptoException) {
            sum += 1
            @Expect(e.message.contains("Key size too small"))
        }
        @Expect(sum, 1)
    }

    @TestCase
    func test_rsa_generate_key_02(): Unit {
        var sum = 0
        try {
            RSAPrivateKey(16385)
        } catch (e: CryptoException) {
            sum += 1
            @Expect(e.message.contains("Key size too long"))
        }
        @Expect(sum, 1)
    }

    @TestCase
    func test_rsa_generate_key_03(): Unit {
        var sum = 0
        try {
            RSAPrivateKey(2048, BigInt(6))
        } catch (e: CryptoException) {
            sum += 1
            @Expect(e.message.contains("Public exponent value is invalid because it is an even number."))
        }
        @Expect(sum, 1)
    }

    @TestCase
    func test_rsa_generate_key_04(): Unit {
        var sum = 0
        try {
            RSAPrivateKey(2048, BigInt(1))
        } catch (e: CryptoException) {
            sum += 1
            @Expect(e.message.contains("Public exponent value is too small."))
        }
        @Expect(sum, 1)
    }

    @TestCase
    func test_rsa_generate_key_05(): Unit {
        var sum = 0
        try {
            let exponentArray = Array<Byte>(33, repeat: 255)
            exponentArray[0] = 0
            let e = BigInt(exponentArray) + BigInt(2)
            RSAPrivateKey(2048, e)
        } catch (e: CryptoException) {
            sum += 1
            @Expect(e.message.contains("Public exponent value is too large."))
        }
        @Expect(sum, 1)
    }
}
