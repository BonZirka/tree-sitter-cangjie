/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

import std.collection.*

main() {
    var map01 = HashMap<Int64, String>([(1, "1"), (2, "2"), (3, "3"), (4, "4")])
    var map02 = HashMap<Int64, String>([(1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5")])
    if (map01 != map02) {
        return 0
    }
    return 1
}
