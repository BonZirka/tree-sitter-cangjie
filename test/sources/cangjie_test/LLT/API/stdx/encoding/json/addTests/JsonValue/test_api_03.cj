/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt -o %n.%suffix %f
// EXEC:%set_stdx_path %run %run_opt %output %run_args | compare %f
// ASSERT: scan 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1

import stdx.encoding.json.*

main() {
    var jv01: JsonValue = JsonNull()
    var jv02: JsonValue = JsonBool(false)
    var jv03: JsonValue = JsonInt(11)
    var jv04: JsonValue = JsonFloat(11.11)
    var jv05: JsonValue = JsonString("apple")
    var jv06: JsonValue = JsonArray()
    var jv07: JsonValue = JsonObject()
    try {
        var JN: JsonNull = jv01.asNull()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonNull = jv02.asNull()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonBool = jv02.asBool()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonBool = jv03.asBool()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonInt = jv03.asInt()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonInt = jv04.asInt()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonFloat = jv04.asFloat()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonFloat = jv05.asFloat()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonString = jv05.asString()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonString = jv06.asString()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonArray = jv06.asArray()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonArray = jv07.asArray()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonObject = jv07.asObject()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonObject = jv01.asObject()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }

    try {
        var JN: JsonFloat = jv03.asFloat()
        print("1 ")
    } catch (e: JsonException) {
        print("0 ")
    }
    0
}
