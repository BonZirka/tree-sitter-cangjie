/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

extend Int8 <: I {
    public static func me() {
        return foo()
    }
}

interface I {
    static func foo() {
        1
    }
}

main(): Int64 {
    if (Int8.me() == 1) {
        return 0
    }
    return 2
}
