/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.collection.*
import std.sync.*

class A {
    static var a = AtomicInt64(0)
    var b = 0
    init() {
        b = a.fetchAdd(1)
    }
}

var a = A()

main(): Int64 {
    let atomicRef = AtomicOptionReference<A>(Some(a))
    let arr = ArrayList<Future<Unit>>()
    for (_ in 0..10) {
        arr.add(spawn {
            a = atomicRef.swap(Some(A())).getOrThrow()
        })
    }
    for (i in 0..10) {
        arr[i].get()
    }
    a = atomicRef.swap(A()).getOrThrow()

    if (A.a.load() != 12) {
        return 1
    }
    if (atomicRef.load().getOrThrow().b != 11) {
        return 2
    }
    return 0
}
