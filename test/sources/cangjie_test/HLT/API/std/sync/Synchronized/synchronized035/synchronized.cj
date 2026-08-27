/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ./../../../../../API/asan
// EXEC: %compiler %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %cmp_opt %f asan.%middle -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.sync.*
import std.runtime.*
import std.argopt.*
import std.process
import asan.*

var running: AtomicInt64 = AtomicInt64(0)
var awake: AtomicInt64 = AtomicInt64(0)

main(): Int64 {
    let mtx: ReentrantMutex = ReentrantMutex()
    let future: Future<Unit> = spawn {
        synchronized(mtx) {
            running.fetchAdd(1)
            mtx.unlock()
            awake.fetchAdd(1)
        }
    }
    try {
        let res: Unit = future.get()
    } catch (e: IllegalSynchronizationStateException) {
        if (running.load() != 1 || awake.load() != 1 || !mtx.tryLock()) {
            asanGC()
            return 1
        }
        asanGC()
        return 0
    }
    asanGC()
    return 2
}
