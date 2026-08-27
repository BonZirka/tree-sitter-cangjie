/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %stdx-package  %f -o %output
// RUN-EXEC: %run_stdx %output %run_args

import stdx.crypto.crypto.*
import std.collection.*

main() {
    var n: Int64 = 8 // 8 is to make sure the probability of test failing twice in a row significantly gets reduced.
    var r: SecureRandom = SecureRandom(priv: true)
    var value02 = HashSet<Bool>()
    for (i in 0..n) {
        var ele = r.nextBool()
        if (ele is Bool) {
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
