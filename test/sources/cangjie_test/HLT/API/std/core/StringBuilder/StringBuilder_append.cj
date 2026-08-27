/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 
import std.math.*

@Test
class Test_stringBuilder_append {
    @TestCase
    func test_stringBuilder_append_rune(): Unit {
        let str = StringBuilder(10)
        str.append(r'a')
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "a")
    }

    @TestCase
    func test_stringBuilder_append_string(): Unit {
        let str = StringBuilder(10)
        str.append("a")
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "a")
    }

    @TestCase
    func test_stringBuilder_append_stringbuilder(): Unit {
        let s = StringBuilder(r'a', 1)
        let str = StringBuilder(10)
        str.append(s)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "a")
    }

    @TestCase
    func test_stringBuilder_append_bool(): Unit {
        let b = true
        let str = StringBuilder(10)
        str.append(b)
        @Expect(str.size, 4)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "true")
    }

    @TestCase
    func test_stringBuilder_append_arrayRune(): Unit {
        let arr = [r'1', r'a', r'一', r'に', r'!', r'\u{4f60}', r'\u{597d}']
        let str = StringBuilder(10)
        str.append(arr)
        @Expect(str.size, 15)
        @Expect(str.capacity, 15)
        @Expect(str.toString(), "1a一に!你好")
    }

    @TestCase
    func test_stringBuilder_append_int64(): Unit {
        let i: Int64 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_int32(): Unit {
        let i: Int32 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_int16(): Unit {
        let i: Int16 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_int8(): Unit {
        let i: Int8 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_uint64(): Unit {
        let i: UInt64 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_uint32(): Unit {
        let i: UInt32 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_uint16(): Unit {
        let i: UInt16 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_uint8(): Unit {
        let i: UInt8 = 1
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1")
    }

    @TestCase
    func test_stringBuilder_append_float64(): Unit {
        let i: Float64 = 1.0
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 8)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1.000000")
    }

    @TestCase
    func test_stringBuilder_append_float32(): Unit {
        let i: Float32 = 1.0
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 8)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1.000000")
    }

    @TestCase
    func test_stringBuilder_append_float16(): Unit {
        let i: Float16 = 1.0
        let str = StringBuilder(10)
        str.append(i)
        @Expect(str.size, 8)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "1.000000")
    }

    @TestCase
    func test_stringBuilder_appendFromUtf8(): Unit {
        let arr = [90u8]
        let str = StringBuilder(10)
        str.appendFromUtf8(arr)
        @Expect(str.size, 1)
        @Expect(str.capacity, 10)
        @Expect(str.toString(), "Z")
    }
}
