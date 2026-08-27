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

struct A<T> {
    public operator func *(b: A<T>): Bool {
        (true)
    }
}

main(): Int64 {
    var a: A<Int32> = A<Int32>()
    var b: A<Int32> = A<Int32>()
    if (!(b * a)) {
        return 1
    }
    return 0
}
