/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_args
import std.collection.*

main() {
    var a: ArrayList<UInt32> = ArrayList<UInt32>([1, 2, 3])
    a.add(100)
    if (a.toString() != "[1, 2, 3, 100]") {
        return 1
    }
    return 0
}
