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
// RUN-EXEC: %run %run_opt %output %run_args

import std.regex.*
import asan.*

main(): Int64 {
    var pattern = [
        "",
        ".",
        "^.&",
        "a",
        "a*",
        "a+",
        "a?",
        "a|b",
        "a*|b*",
        "(a*|b)(c*|d)",
        "[a-z]",
        #"[a-abc-c\-\]\[]"#,
        "[a-z]+",
        "[^1234]",
        "[^\n]",
        #"\!\\"#
    ]
    var str = "aaa*aaa?aaa+"
    for (p in pattern) {
        println("pattern:${p}")
        var regex = Regex(p)
        var matcher = Matcher(regex, str)
    }
    asanGC()
    return 0
}
