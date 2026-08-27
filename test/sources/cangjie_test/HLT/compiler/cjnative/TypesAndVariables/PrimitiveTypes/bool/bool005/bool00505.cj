/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
main(): Int64 {
    var t: Bool = true
    var f: Bool = false
    var j: Int32 = 0
    do {
        j = j + 1
    } while (j < 20)
    if (j != 20) {
        return 1
    }
    return 0
}
