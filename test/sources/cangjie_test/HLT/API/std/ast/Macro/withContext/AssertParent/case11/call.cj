/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: define.cj
// EXEC: %compiler define.cj %cmp_macro 
// EXEC: %run_macro %compiler %cmp_opt  %f -o %output

// RUN-EXEC: %run %run_opt %output %run_args

import define.*

main(): Int64 {
    @Outer[1]
    @Inner[1](var b = 1)
    return b - 1
}
