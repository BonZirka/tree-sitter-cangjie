/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt -o %n.%suffix %f
// EXEC:%set_stdx_path %run %run_opt %output %run_args | compare %f
// ASSERT: scan 1 true 0.800000 "hyy" null ["2"] {"1":"2"}
import stdx.encoding.json.*
import std.collection.*

main() {
    var a = JsonInt(1)
    var b = JsonBool(true)
    var c = JsonFloat(0.8)
    var d = JsonString("hyy")
    var e = JsonNull()
    var f = JsonArray(ArrayList<JsonValue>([JsonString("2")]))
    var g = JsonObject(HashMap<String, JsonValue>([("1", JsonString("2"))]))
    print("${a} ")
    print("${b} ")
    print("${c} ")
    print("${d} ")
    print("${e} ")
    print("${f} ")
    print("${g}")
    0
}
