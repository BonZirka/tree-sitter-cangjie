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
    var n: Int64 = 10
    var op: Int32 = 10

    var res1 = n >> -op
    var res2 = n << -op
    return 0
}
// ASSERT: scan chir_dce_unused_variable
// ASSERT: scan chir_shift_length_overflow


