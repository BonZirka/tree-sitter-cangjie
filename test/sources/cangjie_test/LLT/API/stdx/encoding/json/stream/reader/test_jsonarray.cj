/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt -V %f %cmp_utest_opt -o %output
// (CJNATIVE and Linux) EXEC: ldd %output
// EXEC-PIPE:%set_stdx_path %run %run_opt %output %run_utest_opt %run_args

import stdx.encoding.json.stream.*
import std.io.*
import std.collection.*

@Test
public class JsonArrayTest {
    @TestCase
    func jsonarrayEmpty(): Unit {
        let jsonStr = ##"[]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
    }

    @TestCase
    func jsonarray(): Unit {
        let jsonStr = ##"[null, true, 123.456e3, "\uD834\uDd1e", [123, false], {"key1": " ", "key2": "\\a"}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.JsonNull)
        @Expect(reader.readValue<Option<String>>(), None)
        @Expect(reader.peek(), JsonToken.JsonBool)
        @Expect(reader.readValue<Bool>(), true)
        @Expect(reader.peek(), JsonToken.JsonNumber)
        @Expect(reader.readValue<Float64>(), 123456.0)
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), "𝄞")
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.JsonNumber)
        @Expect(reader.readValue<Int64>(), 123)
        @Expect(reader.peek(), JsonToken.JsonBool)
        @Expect(reader.readValue<Bool>(), false)
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key1")
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), " ")
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key2")
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), "\\a")
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
    }

    @TestCase
    func jsonarrayNopeek(): Unit {
        let jsonStr = ##"[null, true, 123.456e3, "\uD834\uDd1e", [123, false], {"key1": " ", "key2": "\\a"}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        reader.startArray()
        @Expect(reader.readValue<Option<String>>(), None)
        @Expect(reader.readValue<Bool>(), true)
        @Expect(reader.readValue<Float64>(), 123456.0)
        @Expect(reader.readValue<String>(), "𝄞")
        reader.startArray()
        @Expect(reader.readValue<Int64>(), 123)
        @Expect(reader.readValue<Bool>(), false)
        reader.endArray()
        reader.startObject()
        @Expect(reader.readName(), "key1")
        @Expect(reader.readValue<String>(), " ")
        @Expect(reader.readName(), "key2")
        @Expect(reader.readValue<String>(), "\\a")
        reader.endObject()
        reader.endArray()
    }

    @TestCase
    func jsonarray2(): Unit {
        let jsonStr = ##"[null, true, 1.2, "a", [["b"], false], {"key1": {"key2": " "}, "key3": "\\a"}]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.JsonNull)
        @Expect(reader.readValue<Option<String>>(), None)
        @Expect(reader.peek(), JsonToken.JsonBool)
        @Expect(reader.readValue<Bool>(), true)
        @Expect(reader.peek(), JsonToken.JsonNumber)
        @Expect(reader.readValue<Float64>(), 1.2)
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), "a")
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), "b")
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
        @Expect(reader.peek(), JsonToken.JsonBool)
        @Expect(reader.readValue<Bool>(), false)
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key1")
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key2")
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), " ")
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
        @Expect(reader.peek(), JsonToken.Name)
        @Expect(reader.readName(), "key3")
        @Expect(reader.peek(), JsonToken.JsonString)
        @Expect(reader.readValue<String>(), "\\a")
        @Expect(reader.peek(), JsonToken.EndObject)
        reader.endObject()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
    }

    @TestCase
    func jsonarrayError1(): Unit {
        let jsonStr = ##"[}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        try {
            reader.peek()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Character not expected: '}'.")
        }
    }

    @TestCase
    func jsonarrayError2(): Unit {
        let jsonStr = ##"{[]}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginObject)
        reader.startObject()
        try {
            reader.peek()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Expect a string as Json Name, but peeked '['.")
        }
    }

    @TestCase
    func jsonarrayError3(): Unit {
        let jsonStr = ##"[[]}"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.BeginArray)
        reader.startArray()
        @Expect(reader.peek(), JsonToken.EndArray)
        reader.endArray()
        try {
            reader.peek()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Character not expected: '}'.")
        }
    }

    @TestCase
    func jsonarrayError4(): Unit {
        let jsonStr = ##""##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            reader.startArray()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "The JSON stream ends at an incorrect location.")
        }
    }

    @TestCase
    func jsonarrayError5(): Unit {
        let jsonStr = ##"[true,,false]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        reader.startArray()
        @Expect(reader.readValue<Bool>(), true)
        try {
            reader.peek()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Character not expected: ','.")
        }
    }

    @TestCase
    func jsonarrayError6(): Unit {
        let jsonStr = ##","##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            reader.peek()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Character not expected: ','.")
        }
    }

    @TestCase
    func jsonarrayError7(): Unit {
        let jsonStr = ##"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            reader.startArray()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "The next Token is not BeginArray.")
        }
    }

    @TestCase
    func jsonarrayError8(): Unit {
        let jsonStr = ##"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        try {
            reader.endArray()
            @Expect(false)
        } catch (e: IllegalStateException) {
            @Expect(e.message, "Failed to end array.")
        }
    }

    @TestCase
    func array1(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<Array<String>>()
        @Expect(arr, ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func array2(): Unit {
        let jsonStr = ##"[["aaa", "bbb"], ["ccc"]]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<Array<Array<String>>>()
        @Expect(arr, [["aaa", "bbb"], ["ccc"]])
    }

    @TestCase
    func arraylist1(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<ArrayList<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func arraylist2(): Unit {
        let jsonStr = ##"[["aaa", "bbb"], ["ccc"]]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<ArrayList<Array<String>>>()
        @Expect(arr.toArray(), [["aaa", "bbb"], ["ccc"]])
    }


    @TestCase
    func arrayHashSet(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<HashSet<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func arrayLinkedList(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<LinkedList<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func arrayArrayQueue(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<ArrayQueue<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func arrayArrayDeque(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<ArrayDeque<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }

    @TestCase
    func arrayArrayStack(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<ArrayStack<String>>()
        @Expect(arr.toArray(), ["ccc", "bbb", "aaa"])
    }

    @TestCase
    func arrayTreeSet(): Unit {
        let jsonStr = ##"["aaa", "bbb", "ccc"]"##
        var bas = ByteBuffer()
        unsafe { bas.write(jsonStr.rawData()) }
        var reader = JsonReader(bas)
        var arr = reader.readValue<TreeSet<String>>()
        @Expect(arr.toArray(), ["aaa", "bbb", "ccc"])
    }
}
