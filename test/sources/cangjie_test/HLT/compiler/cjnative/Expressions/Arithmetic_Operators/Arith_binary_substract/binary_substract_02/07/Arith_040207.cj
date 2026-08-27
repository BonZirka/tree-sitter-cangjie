/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main(): Int64 {
    let a: Float16 = -1023.2 - 64480.8
    let b: Float32 = -1023.2 - 64480.8
    let c: Float64 = -1023.2 - 64480.8

    if (a - (-65504.0) > 0.1) {
        return 1
    }

    if (b - (-65504.0) > 0.1) {
        return 1
    }

    if (c - (-65504.0) > 0.1) {
        return 1
    }

    return 0
}
