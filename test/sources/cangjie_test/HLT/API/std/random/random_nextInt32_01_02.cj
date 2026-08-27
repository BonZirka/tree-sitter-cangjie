/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args
import std.random.*

main() {
    var count: UInt64 = 0 //记录结果正确次数
    var n: UInt64 = 200 //定义循环次数
    var r = Random()
    var bound: Int32 = -2147483648
    try {
        var m1 = r.nextInt32(bound)
    } catch (e: IllegalArgumentException) {
        return 0
    }
    return 1
}
