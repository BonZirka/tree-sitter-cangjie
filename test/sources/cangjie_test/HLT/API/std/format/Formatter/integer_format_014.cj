/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args
import std.convert.*

main(): Int64 {
    var a: UInt32 = 20
    var b: Int64 = -20

    var res1 = a.format(".1")
    var res2 = b.format("10.2")
    var res3 = 0.format("010.1")
    var res4 = b.format("010.0")

    if (res1 != "20") {
        return 1
    }
    if (res2 != "       -20") {
        return 2
    }
    if (res3 != "         0") {
        return 3
    }
    if (res4 != "       -20") {
        return 4
    }

    return 0
}
