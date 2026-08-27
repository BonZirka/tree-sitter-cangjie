/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %export cjHeapSize=3mb && %run %run_opt %output %run_args
// ASSERT: scan struct 'ThreadInfo' is deprecated. All static Properties are converted to public funtions.

import std.runtime.*
import std.collection.*
import std.sync.*

var flag = 0

main(): Int64 {
    if (ThreadInfo.threadCount != 1) {
        return 1
    }

    var fut = ArrayList<Future<Unit>>()
    let syncCounter = SyncCounter(1)

    for (i in 0..1000) {
        fut.add(spawn {
            flag += 1
            syncCounter.waitUntilZero()
            while (true) {}
        })
    }
    syncCounter.dec()
    while (flag < 10) {
        sleep(Duration.millisecond)
    }

    if (ThreadInfo.threadCount > 1001 || ThreadInfo.blockingThreadCount > 1000 || ThreadInfo.threadCount < ThreadInfo
        .blockingThreadCount) {
        println("ThreadInfo.threadCount: ${ThreadInfo.threadCount}")
        println("ThreadInfo.blockingThreadCount: ${ThreadInfo.blockingThreadCount}")
        println("ThreadInfo.nativeThreadCount: ${ThreadInfo.nativeThreadCount}")
        return 1
    }

    return 0
}
