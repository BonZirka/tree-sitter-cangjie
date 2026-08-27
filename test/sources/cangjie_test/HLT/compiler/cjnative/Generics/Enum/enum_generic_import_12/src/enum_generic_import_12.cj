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
// EXEC: %compiler %cmp_opt %f pkga.%middle  -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

import pkga.TimeUnit as A

func run(): Int64 {
    var time = A<Int32>.Hour(3)
    var res: Int32 = match (time) {
        case Hour(x) => 2
    }
    if (res == 2) {
        return 0
    } else {
        return 1
    }
}

main(): Int64 {
    return run()
}
