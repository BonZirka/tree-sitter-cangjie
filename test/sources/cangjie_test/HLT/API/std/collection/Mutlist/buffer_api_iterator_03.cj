/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt -o %output %f
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

import std.collection.*

main() {
    var buf1: ArrayList<Int64> = ArrayList<Int64>([1, 2, 3, 4, 6, 5, 7, 8, 8, 10])
    var insertlist: ArrayList<Int64> = ArrayList<Int64>([45, 36, 43, 222, 34, 322, 225, 889])
    buf1.add(all: insertlist)
    var expbuffer1: ArrayList<Int64> = ArrayList<Int64>([1, 2, 3, 4, 6, 5, 7, 8, 8, 10, 45, 36, 43, 222, 34, 322, 225,
        889])
    if (buf1 != expbuffer1) {
        return 1
    }
    return 0
}
