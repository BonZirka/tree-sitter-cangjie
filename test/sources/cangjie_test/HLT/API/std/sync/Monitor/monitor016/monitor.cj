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

import std.sync.*

var running: AtomicInt64 = AtomicInt64(0)

main(): Int64 {
    let mtr: Monitor = Monitor()
    let future: Future<Unit> = spawn {
        mtr.lock()
        running.fetchAdd(1)
        mtr.wait()
        mtr.unlock()
    }
    while (running.load() != 1) {}
    mtr.lock()
    mtr.notify()
    try {
        future.get(Duration.millisecond * 10)
    } catch (e: Exception) {
        return 0
    }

    return 1
}
