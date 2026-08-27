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

class C<M> {
    var a: M
    init(x: M) {
        a = x
    }
}

interface A1<M> {}

struct A2<M, K> <: A1<M> {
    public var v1: M
    public static var v2: Int64 = 1
    init(x: M) {
        v1 = x
    }
    public prop p1: Int64 {
        get() {
            0
        }
    }
    public static prop p2: Int64 {
        get() {
            0
        }
    }
    public mut prop p3: M {
        get() {
            v1
        }
        set(v) {
            v1 = v
        }
    }
    public func test(x1: M, x2: (M) -> M, x3: C<M>): M {
        if (p1 != 0) {
            throw Exception()
        }
        generic_test<Int64>(x1, x2, x3, 1)
    }
    public func generic_test<K>(x1: M, x2: (M) -> M, x3: C<M>, x4: K): M {
        static_generic_test<K>(x1, x2, x3, x4).a
    }
    public static func static_test(x1: M, x2: (M) -> M, x3: C<M>): (M) -> M {
        var v1: M = x1
        var v2 = x2
        var v3 = x3
        var v4 = v1 is Option<M>
        var v5 = v2 as Option<(M) -> M>
        var v6 = match (v3) {
            case _: Option<C<M>> => false
            case _: C<M> => true
        }
        if (v4 || !v6 || p2 != 0) {
            throw Exception()
        }
        v2
    }
    public static func static_generic_test<K>(x1: M, x2: (M) -> M, x3: C<M>, x4: K): C<M> {
        C<M>(static_test(x1, x2, x3)(x1))
    }
}

interface I {}

extend<M> A2<M, Int64> <: I {}

main() {
    var a = A2<Int64, Int64>(1)
    var v1 = a.test(1, {x: Int64 => x}, C<Int64>(1))
    a.p3 = 1
    var v2 = a.p3
    var v3 = a.p1 + A2<Int64, Int64>.p2
    if (v1 is Int64 && v2 is Int64 && v3 == 0) {
        return 0
    }
    return 1
}
