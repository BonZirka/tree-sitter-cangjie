/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main():Int64{
    (-UInt64(55) % ((((((Int32(-47)&127)..=(Int32(-57)&127):((-122)|1)), UInt8(17), UInt64(28))[2]) | 1)&127)..=(UInt64(UInt32(36))&127):(108|1))
    return 0
}
// ASSERT: scan chir_arithmetic_operator_overflow
// ASSERT: scan chir_dce_unused_expression


