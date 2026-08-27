/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main(): Int64 {
    return 0
}

interface Data {}

type C = Data

extend C {
    public operator func ==(right: Rune): Bool {
        if (right == 'a') {
            return true
        } else {
            return false
        }
    }
}
// ASSERT: scan sema_illegal_extended_type
