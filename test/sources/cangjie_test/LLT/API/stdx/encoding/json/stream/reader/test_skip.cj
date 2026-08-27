/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE:%set_stdx_path %run %run_opt %output %run_utest_opt %run_args

import stdx.encoding.json.stream.*
import std.io.*
import std.collection.*

@Test
public class SkipTest {
    @TestCase
    func skipNull(): Unit {
        let jsonStr = ##"null"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.JsonNull)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipBool(): Unit {
        let jsonStr = ##"true"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.JsonBool)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipNumber(): Unit {
        let jsonStr = ##"123"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.JsonNumber)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipString(): Unit {
        let jsonStr = ##""1\"23""##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.JsonString)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipArray(): Unit {
        let jsonStr = ##"[[true], "][}{\n", {}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipObject(): Unit {
        let jsonStr = ##"{"key1\\a": null, "key2": {"key4": "][}{\n"}, "key3": []}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipNameAndNull(): Unit {
        let jsonStr = ##"{"name": null}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameAndBool(): Unit {
        let jsonStr = ##"{"key1": true}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameAndNumber(): Unit {
        let jsonStr = ##"{"name": 123}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameAndString(): Unit {
        let jsonStr = ##"{"name": "value"}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameAndArray(): Unit {
        let jsonStr = ##"{"name": [1,2,3]}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameAndObject(): Unit {
        let jsonStr = ##"[{"name": null}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
    }

    @TestCase
    func skipValueInArray(): Unit {
        let jsonStr = ##"["][}{\\a", [true], {}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.JsonString)
        reader.skip()
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.skip()
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
    }

    @TestCase
    func skipValueInObject(): Unit {
        let jsonStr = ##"{"key1": null, "key2": {"key4": "][}{"}, "key3": []}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key1")
        @Expect(reader.peek(), JsonToken.JsonNull)
        reader.skip()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key2")
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.skip()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key3")
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.skip()
        @Expect(reader.peek(), EndObject)
        reader.endObject()
    }

    @TestCase
    func skipNameInObject(): Unit {
        let jsonStr = ##"{"key1": null, "key2": {"key4": "][}{"}, "key3": []}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), JsonToken.Name)
        reader.skip()
        @Expect(reader.peek(), EndObject)
        reader.endObject()
    }

    @TestCase
    func skipEndarray(): Unit {
        let jsonStr = ##"[]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndArray)
    }

    @TestCase
    func skipEndobject(): Unit {
        let jsonStr = ##"{}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.skip()
        @Expect(reader.peek(), JsonToken.EndObject)
    }

    @TestCase
    func skipEnd(): Unit {
        let jsonStr = ##""##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), None)
        reader.skip()
        @Expect(reader.peek(), None)
    }

    @TestCase
    func skipToManyTop(): Unit {
        let jsonStr = ##"{}{}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.skip()
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.skip()
        @Expect(reader.peek(), None)
    }
}
