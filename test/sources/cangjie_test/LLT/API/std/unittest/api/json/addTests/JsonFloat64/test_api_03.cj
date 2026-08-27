/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler    %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan 3

package std.unittest.test

import std.unittest.common.*

main(): Int64 {
    var jv: JsonFloat = JsonFloat(12.90)
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
