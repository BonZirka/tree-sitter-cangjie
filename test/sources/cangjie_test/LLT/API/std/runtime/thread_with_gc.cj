/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %f %cmp_opt -o %n.%suffix
// EXEC-PIPE: %run %run_opt %n.%suffix | compare %f
// ASSERT: scan true

internal import std.runtime.GC
internal import std.collection.ArrayList
internal import std.sync.AtomicInt64

/*
 * Test description: spawning threads concurrently with GC
 */
class Load {
    let buffer = Array<Int64>(512, repeat: 0)
}

let count = AtomicInt64(0)

/**
 * Create a thread tree, where each node spawn 10 new threads.
 * The test case createa a tree with depth == 5.
 */
func recursive(deep: Int64): Unit {
    if (deep <= 0) {
        // All leaf node thread inc the count.
        let n = count.fetchAdd(1)
        // Invoke GC manually
        if (n % 10000 == 0) {
            GC(heavy: true)
        }
        return
    }
    let futures = ArrayList<Future<Unit>>()
    let N = 10
    for (i in 0..N) {
        let f = spawn {
            let load = Load()
            count.fetchAdd(load.buffer[0])
            recursive(deep - 1)
        }
        futures.add(f)
    }
    for (f in futures) {
        f.get()
    }
}

main() {
    recursive(5)
    println(count.load() == 10 * 10 * 10 * 10 * 10)
}
