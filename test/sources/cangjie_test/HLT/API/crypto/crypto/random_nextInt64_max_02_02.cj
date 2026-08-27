/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %stdx-package  %f -o %output
// RUN-EXEC: %run_stdx %output %run_args
import stdx.crypto.crypto.*
import std.collection.*
import std.math.*

main() {
    var n = 5
    var r: SecureRandom = SecureRandom()
    var value02 = HashSet<Int64>()
    for (i in 0..n) {
        var max = Int64.Max
        var ele = r.nextInt64(max)
        if ((ele is Int64) && Int64.Min <= ele && ele < max) {
            value02.add(ele)
        } else {
            return 2
        }
    }
    if (value02.size <= 1) {
        return 1
    }
    return 0
}
