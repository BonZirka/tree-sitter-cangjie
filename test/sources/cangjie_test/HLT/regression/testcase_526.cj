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
    (-try {
        UInt16(6)
    } catch (e: Exception) {
        UInt16(158)
    }) & 7
    return 0;
}
// ASSERT: scan chir_dce_unused_operator
// ASSERT: scan chir_arithmetic_operator_overflow


