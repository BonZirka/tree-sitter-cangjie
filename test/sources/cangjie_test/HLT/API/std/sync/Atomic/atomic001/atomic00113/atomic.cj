/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC:%compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan in main\n

import std.sync.*

main(): Int64 {
    let test = AtomicInt16(-1)
    let a: Int16 = test.swap(1)

    let thread: Future<Unit> = spawn {
        if (a == -1) {
            test.swap(-32768)
        }
    }

    while (test.load() != -32768) {
        sleep(Duration.Zero)
    }

    if (test.load() == -32768) {
        print("in main\n")
    }
    return 0
}
