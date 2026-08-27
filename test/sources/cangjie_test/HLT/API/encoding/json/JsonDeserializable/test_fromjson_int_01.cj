/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt  %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import stdx.encoding.json.stream.*
import std.io.*
import std.math.*

@Test
class Test_fromjson_int_01 {
    @TestCase
    func test_int8_min_01(): Unit {
        let jsonStr = ##"-128"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int8.fromJson(reader), -128)
    }

    @TestCase
    func test_int8_max_02(): Unit {
        let jsonStr = ##"127"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int8.fromJson(reader), 127)
    }

    @TestCase
    func test_int8_03(): Unit {
        let jsonStr = ##"0"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int8.fromJson(reader), 0)
    }

    @TestCase
    func test_int8_04(): Unit {
        let jsonStr = ##"0.0"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int8.fromJson(reader), 0)
    }

    @TestCase
    func test_int8_05(): Unit {
        let jsonStr = ##"1.8"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int8.fromJson(reader), 1)
    }

    @TestCase
    func test_int8_06(): Unit {
        let jsonStr = ##"129"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            Int8.fromJson(reader)
            @Expect(false)
        } catch (e: OverflowException) {
            @Expect(e.message,"The next number is out of range for Int8.")
        }
    }

    @TestCase
    func test_int16_min_07(): Unit {
        let jsonStr = ##"-32768"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int16.fromJson(reader), Int16.Min)
    }

    @TestCase
    func test_int16_max_08(): Unit {
        let jsonStr = ##"32767"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int16.fromJson(reader), Int16.Max)
    }

    @TestCase
    func test_int16_09(): Unit {
        let jsonStr = ##"0"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int16.fromJson(reader), 0)
    }

    @TestCase
    func test_int16_10(): Unit {
        let jsonStr = ##"0.8"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int16.fromJson(reader), 0)
    }

    @TestCase
    func test_int16_11(): Unit {
        let jsonStr = ##"0.0000"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int16.fromJson(reader), 0)
    }

    @TestCase
    func test_int16_12(): Unit {
        let jsonStr = ##"-1010000002"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            Int16.fromJson(reader)
            @Expect(false)
        } catch (e: OverflowException) {
            @Expect(e.message,"The next number is out of range for Int16.")
        }
    }

    @TestCase
    func test_int32_min_13(): Unit {
        let jsonStr = ##"-2147483648"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int32.fromJson(reader), Int32.Min)
    }

    @TestCase
    func test_int32_max_14(): Unit {
        let jsonStr = ##"2147483647"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int32.fromJson(reader), Int32.Max)
    }

    @TestCase
    func test_int32_15(): Unit {
        let jsonStr = ##"0"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int32.fromJson(reader), 0)
    }

    @TestCase
    func test_int32_16(): Unit {
        let jsonStr = ##"0.8"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int32.fromJson(reader), 0)
    }

    @TestCase
    func test_int32_17(): Unit {
        let jsonStr = ##"0.0000"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(Int32.fromJson(reader), 0)
    }

    @TestCase
    func test_int32_18(): Unit {
        let jsonStr = ##"10000000000000"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            Int32.fromJson(reader)
            @Expect(false)
        } catch (e: OverflowException) {
            @Expect(e.message,"The next number is out of range for Int32.")
        }
    }

    @TestCase
    func test_intnative_min_19(): Unit {
        let jsonStr = ##"-9223372036854775808"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(IntNative.fromJson(reader), IntNative(-9223372036854775808))
    }

    @TestCase
    func test_intnative_max_20(): Unit {
        let jsonStr = ##"9223372036854775807"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(IntNative.fromJson(reader), IntNative(9223372036854775807))
    }

    @TestCase
    func test_intnative_21(): Unit {
        let jsonStr = ##"0"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(IntNative.fromJson(reader), 0)
    }

    @TestCase
    func test_intnative_22(): Unit {
        let jsonStr = ##"-1.8"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(IntNative.fromJson(reader), -1)
    }

    @TestCase
    func test_intnative_23(): Unit {
        let jsonStr = ##"0.0000"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(IntNative.fromJson(reader), 0)
    }

    @TestCase
    func test_intnative_24(): Unit {
        let jsonStr = ##"10000000000000000000"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            IntNative.fromJson(reader)
            @Expect(false)
        } catch (e: OverflowException) {
            @Expect(e.message,"The next number is out of range for IntNative.")
        }
    }
}
