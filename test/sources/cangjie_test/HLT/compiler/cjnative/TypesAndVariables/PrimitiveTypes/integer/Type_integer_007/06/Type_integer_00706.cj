/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f


main(): Int64 {
    let int64_One: in%t64 = 127

    if (int64_One == 127) {
        return 1
    } else {
        return 0
    }
}
// ASSERT: scan parse_expected_type
