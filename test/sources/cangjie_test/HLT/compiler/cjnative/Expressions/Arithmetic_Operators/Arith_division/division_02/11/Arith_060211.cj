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
    let a: Float16 = 65503.2
    let b: Float64 = 255.32
    let ab: Int32 = a / b

    return 0
}
// ASSERT: scan sema_invalid_binary_expr
