/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE:  ../../asan
// EXEC: %compiler %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %cmp_opt asan.%middle %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan res is 1
// ASSERT: scan res is +1
// ASSERT: scan res is -1.1
// ASSERT: scan res is 0.12
// ASSERT: scan res is +9

import asan.*
import std.regex.*

main(): Int64 {
    var pattern = #"(\+|\-)?((\d+\.\d+)|(\d+\.)|(\.\d+)|(\d+))((E|e)(\+|\-)?\d+)?"#
    var str = "aA1+1-1.1=0.12+9"
    var regex = Regex(pattern)
    var matcher = Matcher(regex, str)
    var res = matcher.findAll().getOrThrow()
    for (i in res) {
        println("res is ${i.matchString()}")
    }
    asanGC()
    return 0
}
