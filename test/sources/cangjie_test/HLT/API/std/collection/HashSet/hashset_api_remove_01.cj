/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args|compare %f
// ASSERT: scan success1

import std.collection.*

var str: Array<String> = ["a", "b", "c"]
var r1: HashSet<String> = HashSet<String>()
var r2: HashSet<String> = HashSet<String>(["a", "b", "c"])
var r3: HashSet<String> = HashSet<String>(str)
var r4: HashSet<String> = HashSet<String>(3)
var r5: HashSet<String> = HashSet<String>(3, {x: Int64 => x.toString()})

main(): Int64 {
    r2.remove("b")
    r3.remove("c")
    r5.remove("2")
    if (r2.contains("b") == true) {
        return 1
    }
    if (r3.contains("c") == true) {
        return 2
    }
    if (r5.contains("2") == true) {
        return 3
    }
    if (r2.size != 2) {
        return 4
    }
    if (r3.size != 2) {
        return 5
    }
    if (r5.size != 2) {
        return 6
    }
    print("success1\n")
    return 0
}
