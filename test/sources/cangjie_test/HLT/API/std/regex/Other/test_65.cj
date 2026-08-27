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
// (not iOS) EXEC: %compiler %cmp_opt asan.%middle %f -o %output
// (not iOS) RUN-ERRCHECK: %run %run_opt %output %run_args
// ASSERT: scan RegexException: Compilation for pattern `a++++++b???????c*******d` failed at offset 3: quantifier does not follow a repeatable item.

import std.regex.*
import asan.*

main(): Int64 {
    var pattern = ["a++++++b???????c*******d"]
    var str = "abcd"
    for (p in pattern) {
        println("pattern:${p}")
        var regex = Regex(p)
        println(regex.string())
        var matcher = Matcher(regex, str)
        var res = matcher.findAll().getOrThrow()
        for (i in res) {
            println("res is ${i.matchString()}")
        }
    }
    asanGC()
    return 0
}
