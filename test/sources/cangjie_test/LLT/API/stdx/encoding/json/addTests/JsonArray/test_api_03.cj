/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: creat_data.cj
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt %stdx-package  creat_data.cj -o %n.%suffix %f
// EXEC:%set_stdx_path %run %run_opt %output %run_args | compare %f
// ASSERT: scan test_init_ok test_add_ok test_add2_ok test_add3_ok test_get_ok test_getItem_ok test_toString_ok test_toJsonString_ok

import stdx.encoding.json.*

main(): Int64 {
    var buf: Array<JsonValue> = [creatJsonValue(-3, 3, "apple")]
    var initFunc = JsonArray(buf)
    var caseClass = TestJsonArray()
    if (caseClass.testInit(initFunc, exp_size: 1) == 0) {
        print("test_init_ok ")
    }

    // add 添加一项
    var jsonValue1 = creatJsonValue(-4, 4, "red")
    if (caseClass.testAdd(jsonValue1, initFunc) == 0) {
        print("test_add_ok ")
    }

    // add 添加已存在的相同的一项
    var jsonValue2 = creatJsonValue(-3, 3, "apple")
    if (caseClass.testAdd(jsonValue2, initFunc) == 0) {
        print("test_add2_ok ")
    }

    // add 连续添加
    var jsonValue3 = creatJsonValue(-5, 5, "blue")
    if (caseClass.testAdd(jsonValue3, initFunc) == 0) {
        print("test_add3_ok ")
    }

    // get
    var exp_data: Array<String> = ["{\"item1\":-3,\"item2\":3,\"item3\":\"apple\"}",
        "{\"item1\":-4,\"item2\":4,\"item3\":\"red\"}", "{\"item1\":-3,\"item2\":3,\"item3\":\"apple\"}",
        "{\"item1\":-5,\"item2\":5,\"item3\":\"blue\"}"]
    if (caseClass.testGet(exp_data, initFunc) == 0) {
        print("test_get_ok ")
    }

    // getItem
    if (caseClass.testGetItems(exp_data, initFunc) == 0) {
        print("test_getItem_ok ")
    }

    // toString
    var exp_toString: String = "[{\"item1\":-3,\"item2\":3,\"item3\":\"apple\"},{\"item1\":-4,\"item2\":4,\"item3\":\"red\"},{\"item1\":-3,\"item2\":3,\"item3\":\"apple\"},{\"item1\":-5,\"item2\":5,\"item3\":\"blue\"}]"
    if (caseClass.testToString(exp_toString, initFunc) == 0) {
        print("test_toString_ok ")
    }

    // toJsonString
    var exp_toJsonString = ##"[
  {
    "item1": -3,
    "item2": 3,
    "item3": "apple"
  },
  {
    "item1": -4,
    "item2": 4,
    "item3": "red"
  },
  {
    "item1": -3,
    "item2": 3,
    "item3": "apple"
  },
  {
    "item1": -5,
    "item2": 5,
    "item3": "blue"
  }
]"##
    if (caseClass.testToJsonString(exp_toJsonString, initFunc) == 0) {
        println("test_toJsonString_ok")
    }
    return 0
}
