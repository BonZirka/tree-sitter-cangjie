/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

interface I1 {
    func f(): Int32 {
        return 1
    }
}

class C2 <: I1 {
    public static var f: Int32 = 2
}

main(): Int64 {
    return 0
}
// ASSERT: scan sema_static_and_non_static_member_cannot_have_same_name
