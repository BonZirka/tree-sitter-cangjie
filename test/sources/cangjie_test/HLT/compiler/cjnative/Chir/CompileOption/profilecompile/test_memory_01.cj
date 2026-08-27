/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE: %compiler %cmp_opt %f --profile-compile-memory -o %output 2>&1
// (not Windows) EXEC-0: %cat default.mem.prof | compare %f
// (not Windows) EXEC-0: %cat default.info.prof
// (not Windows) EXEC-1: %cat default.time.prof
// ASSERT: regex-begin "Main Stage": {
// ASSERT: regex-next .*"Parser": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"ConditionalCompilation": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"ImportPackages": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"MacroExpand": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"AST Diff": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Semantic": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Desugar after Sema": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Generic Instantiation": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Overflow Strategy": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Perform Mangling": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Save cjo": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"CHIR": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"CodeGen": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Execute opt": [0-9]+\.[0-9]+,
// ASSERT: regex-next .*"Execute llc": [0-9]+\.[0-9]+,

interface I1 {
}
open class C1 <: I1 {
    var v11 = 1
    public static var v12 = 1
    public open mut prop p1: Int64 {
        get() {
            v11
        }
        set(v) {
            v11 = v
        }
    }
    public static mut prop p2: Int64 {
        get() {
            v12
        }
        set(v) {
            v12 = v
        }
    }
    public open func f1() {
        1
    }
    public func f2<T>(v: T) {
        v
    }
    public static func f3() {
        1
    }
    public static func f4<T>(v: T) {
        v
    }
}
open class C2 <: C1 & I1 {
    var v21 = 0
    public static var v22 = 0
    public override mut prop p1: Int64 {
        get() {
            v21
        }
        set(v) {
            v21 = v
        }
    }
    public redef static mut prop p2: Int64 {
        get() {
            v22
        }
        set(v) {
            v22 = v
        }
    }
    public override func f1() {
        0
    }
    public redef static func f3() {
        0
    }
    public redef static func f4<T>(v: T) {
        v
    }
}
class C3<M> <: C2 {
}

class C<M> {
    var a: M
    init(x: M) {
        a = x
    }
}

interface A1<M> {
    public mut prop p1: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
    public static mut prop p2: Int64 {
        get() {
            0
        }
        set(v) {
            v
        }
    }
    public mut func test(x1: M, x2: (M) -> M, x3: C<M>): M {
        p1 = 0
        static_generic_test<Int64>(x1, x2, x3, 1).a
    }
    public static func static_test(x1: M, x2: (M) -> M, x3: C<M>): (M) -> M {
        var v1: M = x1
        var v2 = x2
        var v3 = x3
        var v4 = v1 is Option<M>
        var v5 = v2 as Option<(M) -> M>
        var v6 = match(v3) {
            case _: Option<C<M>> => false
            case _: C<M> => true
        }
        if (v4 || !v6) {
            throw Exception()
        }
        v2
    }
    public static func static_generic_test<K>(x1: M, x2: (M) -> M, x3: C<M>, x4: K): C<M> {
        C<M>(static_test(x1, x2, x3)(x1))
    }
}

struct A2<M> where M <: C1 & I1 {
    public var v1: M
    public var v11 = 1
    public static var v12 = 1
    init(x: M) {
        v1 = x
    }
    public mut prop p1: Int64 {
        get() {
            v11
        }
        set(v) {
            v11 = v
        }
    }
    public static mut prop p2: Int64 {
        get() {
            v12
        }
        set(v) {
            v12 = v
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
    public mut func test(x1: M, x2: (M) -> M, x3: C<M>): M {
        v11 = 0
        generic_test<Int64>(x1, x2, x3, 1)
    }
    public mut func generic_test<K>(x1: M, x2: (M) -> M, x3: C<M>, x4: K): M {
        v12 = 0
        static_generic_test<K>(x1, x2, x3, x4).a
    }
    public static func static_test(x1: M, x2: (M) -> M, x3: C<M>): (M) -> M {
        var v1: M = x1
        var v2 = x2
        var v3 = x3
        var v4 = v1 is Option<M>
        var v5 = v2 as Option<(M) -> M>
        var v6 = match(v3) {
            case _: Option<C<M>> => false
            case _: C<M> => true
        }
        v1.p1 = 2
        M.p2 = 2
        var v7 = v1.p1 + M.p2 + v1.f1() + v1.f2<Int64>(0) + M.f3() + M.f4<Int64>(0)
        if (v4 || !v6 || v7 != 4) {
            throw Exception()
        }
        v2
    }
    public static func static_generic_test<K>(x1: M, x2: (M) -> M, x3: C<M>, x4: K): C<M> {
        C<M>(static_test(x1, x2, x3)(x1))
    }
}

extend<M> A2<M> <: A1<M> where M <: C1 & I1 {}

main(){
    var a = A2<C2>(C2())
    var b = A2<C3<Int64>>(C3<Int64>())
    var v1 = a.test(C2(), { x: C2 => x }, C<C2>(C2()))
    a.p3 = C2()
    var v2 = a.p3
    a.p1 = 2
    A2<C2>.p2 = 2
    var v3 = a.p1 + A2<C2>.p2
    var v4 = b.test(C3<Int64>(), { x: C3<Int64> => x }, C<C3<Int64>>(C3<Int64>()))
    b.p3 = C3<Int64>()
    var v5 = b.p3
    b.p1 = 3
    A2<C3<Int64>>.p2 = 3
    var v6 = b.p1 + A2<C3<Int64>>.p2
    if (v1 is C2 && v2 is C2 && v3 == 4 && v4 is C3<Int64> && v5 is C3<Int64> && v6 == 6) {
        return 0
    }
    return 1
}
