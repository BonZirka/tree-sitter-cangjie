/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./jsonChecker
// EXEC: %compiler    %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan pass4

package std.unittest.test

import std.fs.*
import std.unittest.common.*

main() {
    var num: Int64 = 0
    for (i in 1..5) {
        var s = File.readFrom("./jsonChecker/pass" + i.toString() + ".json")
        var str = String.fromUtf8(s)
        var jv: JsonValue = JsonValue.fromStr(str)
        num++
    }
    sleep(Duration.millisecond * 1)
    println("pass${num}")
    0
}
