/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.test

import std.collection.*
import std.unittest.common.*

class JsonModule <: Serializable<JsonModule> {
    public var item1: Int8
    public var item2: UInt8
    public var item3: String
    public init(item1: Int8, item2: UInt8, item3: String) {
        this.item1 = item1
        this.item2 = item2
        this.item3 = item3
    }

    public func serializeInternal(): DataModel {
        let dms = DataModelStruct()
        dms.add(Field("item1", item1.serializeInternal()))
        dms.add(Field("item2", item2.serializeInternal()))
        dms.add(Field("item3", item3.serializeInternal()))
        return dms
    }

    public static func deserialize(dm: DataModel): JsonModule {
        let dms = (dm as DataModelStruct).getOrThrow()
        JsonModule(dms)
    }

    private init(dms: DataModelStruct) {
        this.item1 = Int8.deserialize(dms.get("item1"))
        this.item2 = UInt8.deserialize(dms.get("item2"))
        this.item3 = String.deserialize(dms.get("item3"))
    }

    public operator func ==(rhs: JsonModule): Bool {
        var result = true
        if (!(this.item1 == rhs.item1)) {
            print("item1 is not equal, the origin is ${this.item1}, the value convert from string is ${rhs.item1} \n")
            result = false
        }
        if (!(this.item2 == rhs.item2)) {
            print("item2 is not equal, the origin is ${this.item2}, the value convert from string is ${rhs.item2} \n")
            result = false
        }
        if (!(this.item3 == rhs.item3)) {
            print("item3 is not equal, the origin is ${this.item3}, the value convert from string is ${rhs.item3} \n")
            result = false
        }
        return result
    }
}

class TestJsonArray {
    /*
     * init()
     * func toJsonString(): String
     * func toString(): String
     * func size: Int64
     * func add(jv: JsonValue)
     * func get(index: Int64): Option<JsonValue>
     * func getItems(): ArrayList<JsonValue>
     */
    public func testInit(jsonArray: JsonArray, exp_size!: Int64 = 0): Int64 {
        var size = jsonArray.size()
        if (size != exp_size) {
            println("size = " + size.toString())
            return 1
        }
        return 0
    }
    public func testAdd(jsonValue: JsonValue, jsonArrary: JsonArray): Int64 {
        var size1 = jsonArrary.size()
        jsonArrary.add(jsonValue)
        var size2 = jsonArrary.size()
        if (size2 != size1 + 1) {
            println("size1 = " + size1.toString() + "size2 = " + size2.toString())
            return 1
        }
        return 0
    }

    public func testGet(exp_data: Array<String>, jsonArray: JsonArray): Int64 {
        for (i in 0..jsonArray.size()) {
            var get_result = jsonArray.get(i).getOrThrow().toString()
            if (get_result != exp_data[i]) {
                println(get_result)
                println(exp_data[i])
                return 1
            }
        }
        return 0
    }

    public func testGetItems(exp_jsonValue: Array<String>, jsonArray: JsonArray): Int64 {
        var items = jsonArray.getItems()
        for (i in 0..items.size) {
            var item_data = items[i].toString()
            if (item_data != exp_jsonValue[i]) {
                println("exp_jsonValue[i]=" + exp_jsonValue[i])
                return 1
            }
        }
        return 0
    }

    public func testToString(exp_jsonValue: String, jsonArray: JsonArray): Int64 {
        var toString = jsonArray.toString()
        if (toString != exp_jsonValue) {
            println("exp_jsonValue =" + exp_jsonValue)
            println("toString =" + toString)
            return 1
        }
        return 0
    }

    public func testToJsonString(expString: String, jsonArray: JsonArray): Int64 {
        var toJsonString = jsonArray.toJsonString()
        if (toJsonString != expString) {
            println("str1=" + toJsonString)
            println("str2=" + expString)
            return 1
        }
        return 0
    }
}

func creatJsonValue(param1: Int8, param2: UInt8, param3: String): JsonValue {
    let jsonModule = JsonModule(param1, param2, param3)
    let dataModel: DataModel = jsonModule.serializeInternal()
    let jsonValue: JsonValue = dataModel.toJson()
    return jsonValue
}
