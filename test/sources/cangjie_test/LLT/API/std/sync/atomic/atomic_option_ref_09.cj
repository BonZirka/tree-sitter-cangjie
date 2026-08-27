/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %enableO2 %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

/*
 * Test description: Should not compile failed even used wrong memory order
 * Test API:
 *          public init()
 *          public func load(): Option<T>
 *          public func store(val: Option<T>, memoryOrder: MemoryOrder): Unit
 */

internal import std.sync.*

class A {
    public var val: Int64
    public init(v: Int64) {
        val = v
    }
}

main(): Int64 {
    let N = 10
    let a = A(10)
    let b = A(20)
    let atomicOptRef = AtomicOptionReference<A>(a)

    for (i in 0..N) {
        spawn {
            atomicOptRef.store(b, memoryOrder: SeqCst)
        }
    }

    return match (atomicOptRef.load()) {
        case Some(obj) =>
            if (refEq(obj, a) || refEq(obj, b)) {
                0
            } else {
                1
            }
        case None => 1
    }
}
