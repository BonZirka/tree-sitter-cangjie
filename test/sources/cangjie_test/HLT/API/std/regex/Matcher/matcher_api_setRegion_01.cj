/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt   %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

import std.runtime.*
import std.regex.*
import std.argopt.*
import std.process

main() {
    var regexString = "[0-9][a-z]"
    var matchString = "a6U8Sd8f7M9sd4j5Uu"
    var regex1 = Regex(regexString)
    var regex2 = Regex(regexString, RegexOption().ignoreCase())
    var region1 = Matcher(regex1, matchString).setRegion(0, 0).region()
    var region2 = Matcher(regex2, matchString).setRegion(3, 4).region()
    var region3 = regex1.matcher(matchString).setRegion(0, matchString.size).region()
    var region4 = regex2.matcher(matchString).setRegion(1, matchString.size - 1).region()

    if (region1.start != 0 || region1.end != 0) {
        print("Part1\n")
        print("${region1.start}+${region1.end}\n")
        return 1
    } else if (region2.start != 3 || region2.end != 4) {
        print("Part2\n")
        print("${region2.start}+${region2.end}\n")
        return 2
    } else if (region3.start != 0 || region3.end != matchString.size) {
        print("Part3\n")
        print("${region3.start}+${region3.end}\n")
        return 3
    } else if (region4.start != 1 || region4.end != matchString.size - 1) {
        print("Part4\n")
        print("${region4.start}+${region4.end}\n")
        return 4
    }
    asan()
    return 0
}

func asan() {
    let ao = ArgOpt(process.Process.current.arguments, "", ["asan"])
    let map = ao.getArgumentsMap()
    if (map.contains("--asan")) {
        sleep(Duration.millisecond * 100)
        GC()
        sleep(Duration.millisecond * 100)
    }
}
