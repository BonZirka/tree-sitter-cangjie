/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan 145

main(): Int64 {
    var b: Int32 = 0
    var i: Int32 = 0
    while (i < 10) {
        b = b + i
        var j: Int32 = 0
        while (j < 5) {
            b = b + j
            j++
        }
        i++
    }
    print(b.toString())
    return 0
}
