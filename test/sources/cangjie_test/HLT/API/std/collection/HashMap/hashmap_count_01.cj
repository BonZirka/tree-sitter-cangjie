/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.collection.*

var hashmap1: HashMap<Int8, String> = HashMap<Int8, String>([])
var hashmap2: HashMap<Int8, String> = HashMap<Int8, String>(hashmap1)
var hashmap3: HashMap<Int8, String> = HashMap<Int8, String>()
var hashmap4: HashMap<Int8, String> = HashMap<Int8, String>(0)
var hashmap5: HashMap<Int8, String> = HashMap<Int8, String>(0, {x: Int64 => (Int8(x), x.toString())})

main(): Int64 {
    if (hashmap1.size != 0) {
        return 1
    }
    if (hashmap2.size != 0) {
        return 2
    }
    if (hashmap3.size != 0) {
        return 3
    }
    if (hashmap4.size != 0) {
        return 4
    }
    if (hashmap5.size != 0) {
        return 5
    }
    return 0
}
