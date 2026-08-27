/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

enum E<T> {
    | e(T, T)
    | e(T, T, T)
    | e(T, T, T, T)
}

enum F {
    | e(Int64)
    | e(Int64, Int64)
}

main(): Int64 {
    e(true, 1)
    return 0
}
// ASSERT: scan sema_unable_to_infer_generic_func
