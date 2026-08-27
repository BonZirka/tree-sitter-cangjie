/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ../src 
// EXEC: %compiler %cmp_opt %compile_lib_opt src/pkgs/pkgs.cj -o pkgs.%middle  
// EXEC: %compiler %cmp_opt %f pkgs.%middle -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import pkgs.cls

main(): Int64 {
    if (cls.f() == 1) {
        return 0
    }
    return 1
}
