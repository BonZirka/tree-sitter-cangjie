/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 3
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.collection.*

main() {
    let a = TreeMap<Int64, Int64>([(10, 10)])
    let b = TreeMap<UInt64, Byte>([(10, 10)])
    a[10]++
    b[10]++
    if (a[10] != 11 && b[10] != 11) {
        return 1
    }
    a[10]--
    b[10]--
    if (a[10] != 10 && b[10] != 10) {
        return 2
    }
    0
}
