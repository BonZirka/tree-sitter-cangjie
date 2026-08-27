/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler    %cmp_opt    -o %n.%suffix %f
// EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan pass

package std.unittest.test

import std.unittest.common.*

main() {
    var str1 = ##"{"name":"Tom","age":"18","version":"0.1.1"}"##
    var k1 = JsonValue.fromStr(str1)
    var res1 = k1.asObject().get("name").getOrThrow().toString()

    var str2 = ##"null"##
    var jv2 = JsonValue.fromStr(str2)
    var res2 = jv2.asNull().toString()

    var str3 = ##"false"##
    var jv3 = JsonValue.fromStr(str3)
    var res3 = jv3.asBool().toString()

    var str4 = ##"123"##
    var jv4 = JsonValue.fromStr(str4)
    var res4 = jv4.asInt().toString()

    var str5 = ##"1.00"##
    var jv5 = JsonValue.fromStr(str5)
    var res5 = jv5.asFloat().toString()

    var jv6: JsonValue = JsonString("hello")
    var res6 = jv6.asString().toString()

    var str7 = ##"[1,2]"##
    var jv7 = JsonValue.fromStr(str7)
    var res7 = jv7.asArray().toString()

    if (res1 == "\"Tom\"" && res2 == "null" && res3 == "false" && res4 == "123" && res5 == "1.000000" && res6 ==
        "\"hello\"" && res7 == "[1,2]") {
        print("pass")
    }

    0
}
