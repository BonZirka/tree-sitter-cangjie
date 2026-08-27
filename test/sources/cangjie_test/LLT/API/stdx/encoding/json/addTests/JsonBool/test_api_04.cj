/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler  %import-cangjie-stdx  %cmp_opt -o %n.%suffix %f
// EXEC:%set_stdx_path %run %run_opt %output %run_args | compare %f
// ASSERT: scan 1

import stdx.encoding.json.*

main(): Int64 {
    var jv: JsonBool = JsonBool(true)
    judgeKind(jv.kind())
    return 0
}

func judgeKind(jk: JsonKind) {
    match (jk) {
        case JsNull => print("0 ")
        case JsBool => print("1 ")
        case JsInt => print("2 ")
        case JsFloat => print("3 ")
        case JsString => print("4 ")
        case JsArray => print("5 ")
        case JsObject => print("6 ")
    }
}
