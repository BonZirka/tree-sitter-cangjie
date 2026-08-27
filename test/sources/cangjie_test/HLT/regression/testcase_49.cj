/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



main(): Int64 {
    let a: UInt64 = 18446744073709551614 *- 18446744073709551615 
    return 0
}
// ASSERT: scan sema_exceed_num_value_range


