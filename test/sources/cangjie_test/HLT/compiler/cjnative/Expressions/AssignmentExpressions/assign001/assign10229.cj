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
struct LA {
    public LA(var a: Int32) {}
}

main(): Int64 {
    var l_a = LA(4)
    var r_a: Int32 = 2
    l_a.a = r_a
    if (l_a.a == Int32(2)) {
        return 0
    }
    return 1
}
