/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %f %cmp_opt -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix | compare %f
// ASSERT: scan ok

/*
 * Test description: Test the funcs in reentrant_read_write_mutex.cj
 * Reentrant read-mutex.
 * Test API:
 *   - ReentrantReadMutex.lock()
 *   - ReentrantReadMutex.unlock()
 */

internal import std.sync.AtomicInt64
internal import std.sync.ReentrantReadWriteMutex
internal import std.collection.ArrayList

main(): Unit {
    let futs = ArrayList<Future<Unit>>()
    let rwm = ReentrantReadWriteMutex()
    let counter = AtomicInt64(0)

    for (_ in 0..5) {
        let f = spawn {
            synchronized(rwm.readMutex) {
                for (_ in 0..10) {
                    synchronized(rwm.readMutex) {
                        counter.fetchAdd(1)
                        sleep(Duration.microsecond * 100)
                    }
                }
                while (counter.load() != 50) {
                }
            }
        }
        futs.add(f)
    }

    for (f in futs) {
        f.get()
    }
    println("ok")
}
