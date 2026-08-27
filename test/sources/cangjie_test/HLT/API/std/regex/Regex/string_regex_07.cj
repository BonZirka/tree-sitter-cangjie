/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %compiler %cmp_opt   %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

import std.regex.*
import std.runtime.*
import std.argopt.*
import std.process

main() {
    var count: Int64 = 0
    var str = "?" // init(regex: String)
    try {
        var regex1 = Regex(str)
    } catch (e: Exception) {
        count = count + 1
    }
    try {
        var regex2 = Regex(str, RegexOption()) //init(regex: String, flagType: Int64)
    } catch (e: Exception) {
        count = count + 1
    }
    if (count != 2) {
        return 1
    }
    let ao = ArgOpt(process.Process.current.arguments, "", ["asan"])
    let map = ao.getArgumentsMap()
    if (map.contains("--asan")) {
        GC()
        sleep(Duration.second * 2)
    }
    return 0
}
