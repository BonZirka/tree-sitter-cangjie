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
    var matcherstr1 = "fggfhhhgkkkg"
    //量词{n,m}:only one
    var regexstr1 = "[k]{1,2}"
    var matcher1 = Regex(regexstr1).matcher(matcherstr1)
    var result1 = matcher1.find().getOrThrow().matchString()
    if (result1 != "kk") {
        print("Part1+${result1}\n") //
        return 1
    }

    var regexstr9 = "[k]{1,3}"
    var matcher9 = Regex(regexstr9).matcher(matcherstr1)
    var result9 = matcher9.find().getOrThrow().matchString()
    if (result9 != "kkk") {
        print("Part9+${result9}\n")
        return 2
    }

    var regexstr10 = "[k]{1,4}"
    var matcher10 = Regex(regexstr10).matcher(matcherstr1)
    var result10 = matcher10.find().getOrThrow().matchString()
    if (result10 != "kkk") {
        print("Part10+${result10}\n")
        return 3
    }

    //量词{n,m}?:only one
    var regexstr11 = "[k]{1,2}?g"
    var matcherstr2 = "fggfhhhgkkkg"
    var matcher11 = Regex(regexstr11).matcher(matcherstr2)
    var result11 = matcher11.find().getOrThrow().matchString() //kkg
    if (result11 != "kkg") {
        print("Part11+${result11}\n")
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
