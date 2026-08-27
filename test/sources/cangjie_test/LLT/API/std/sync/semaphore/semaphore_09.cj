/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %f %cmp_opt -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

/*
 * Test description: Test the funcs in Semaphore.cj
 * Test API:
 *   - Semaphore.init()
 *   - Semaphore.acquire()
 *   - Semaphore.release()
 */

internal import std.sync.Semaphore
internal import std.sync.AtomicInt64
internal import std.sync.SyncCounter

let N = 50
let sem_1 = Semaphore(N)
let sum = AtomicInt64(0)
let syncCounter = SyncCounter(N)

/**
 * Multiple producer, multiple consumer.
 */
func consumer(): Unit {
    sem_1.acquire()
    sum.fetchAdd(1)
    syncCounter.dec()
}

func producer(): Unit {
    sem_1.release()
}

main(): Int64 {
    // Clear the semaphore
    for (i in 0..N) {
        sem_1.acquire()
    }

    for (i in 0..N) {
        spawn {consumer()}
    }

    for (i in 0..N) {
        spawn {producer()}
    }

    syncCounter.waitUntilZero()

    if (sum.load() == N) {
        return 0
    } else {
        return 1
    }
}
