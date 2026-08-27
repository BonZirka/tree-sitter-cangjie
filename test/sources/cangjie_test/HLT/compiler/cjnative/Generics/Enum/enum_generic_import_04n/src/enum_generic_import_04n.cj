/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ../src
// EXEC: %compiler %cmp_opt %compile_lib_opt src/pkga/pkga.cj -o pkga.%middle
// EXEC-PIPE-1: %compiler %cmp_opt %f pkga.%middle   -o %output 2>&1 | compare %f

import pkga.TimeUnit

func run(): Int64 {
    var time = TimeUnit<Int32>.Hour(3)
    return 0
}

main(): Int64 {
    return run()
}
// ASSERT: scan package_decl_not_find_in_package
