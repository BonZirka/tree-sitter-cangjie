/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args
import std.random.*

main() {
    var count: UInt64 = 0 //记录结果正确次数
    var n: UInt64 = 200 //定义循环次数
    var r = Random(UInt64(9))
    for (i in 0..n) {
        if (r.nextInt8() is Int8) {
            count += 1
        }
    }
    if (count != n) {
        return 1
    }

    return 0
}
