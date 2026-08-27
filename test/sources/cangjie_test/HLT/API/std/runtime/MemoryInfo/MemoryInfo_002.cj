/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %export cjHeapSize=3mb && %run %run_opt %output %run_args

import std.runtime.*

main(): Int64 {
    if (getMaxHeapSize() != 268435456) {
        println("1: ${getMaxHeapSize()}")
        return 1
    }
    if (getAllocatedHeapSize() == 0) {
        println("2: ${getAllocatedHeapSize()}")
        return 1
    }
    if (getUsedHeapSize() > getMaxHeapSize()) {
        println("3: ${getAllocatedHeapSize()}")
        println("4: ${getUsedHeapSize()}")
        return 1
    }
    var a = 0
    var b = 0
    var c = 0
    for (i in 0..10000) {
        a = getMaxHeapSize()
        b = getAllocatedHeapSize()
        c = getUsedHeapSize()
        if (a != 268435456) {
            println("5: ${a}")
            return 1
        }
        if (b > a) {
            println("6: ${b}")
            return 1
        }
        if (c > a) {
            println("7: ${c}")
            return 1
        }
    }
    return 0
}
