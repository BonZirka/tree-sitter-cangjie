/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main(): Int64 {
    let int64_One: Int64 = 9223372036854775808

    if (int64_One == 9223372036854775808) {
        return 1
    } else {
        return 0
    }
}
// ASSERT: scan sema_exceed_num_value_range
