/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// ASSERT: scan-full Compatible!\n
package test_stable_abi

// test class: instancemember function
public open class Father {}

public class Son <: Father {}

@Annotation
public class Version {
    let code: String
    const init(code: String) {
        this.code = code
    }
}

public open class TestClass {
    public func f1() {
        1
    }
    protected func f2() {
        2
    }

    private const func f3(): Int64 {
        return 3
    }
    public const func f4(): Int64 {
        f3()
    }
    internal const func pf3(): Int64 {
        return 3
    }
    protected const func pf4(): Int64 {
        pf3()
    }

    func f5(): Int64 {
        return 5
    }

    @Frozen
    public func f6(): Int64 {
        f5()
    }
    func pf5(): Int64 {
        return 5
    }

    @Frozen
    protected func pf6(): Int64 {
        pf5()
    }

    // 被全局函数调用
    internal func f7(): Int64 {
        return 7
    }

    @Deprecated["This API will be deprecated soon"]
    public func f8() {
        8
    }

    @Deprecated["This API is deprecated", strict: true]
    public func f9() {
        9
    }

    @Deprecated["This API will be deprecated soon"]
    protected func pf8() {
        8
    }

    @Deprecated["This API is deprecated", strict: true]
    protected func pf9() {
        9
    }

    func f10() {
        10
    }
    internal func f11() {
        11
    }
    private func f12() {
        12
    }

    public unsafe func f13(): Int64 {
        return 13
    }
    public const func f14(): Int64 {
        14
    }

    public func g1<X, Y, Z>(a: X, b: Y, c: Z): String where X <: ToString, Y <: ToString, Z <: Son {
        a.toString() + b.toString()
    }
    public func g2<X, Y, Z>(a: X, b: Y, c: Z): String where X <: ToString, Z <: Father {
        a.toString()
    }
    protected func pg1<X, Y, Z>(a: X, b: Y, c: Z): String where X <: ToString, Y <: ToString, Z <: Son {
        a.toString() + b.toString()
    }
    protected func pg2<X, Y, Z>(a: X, b: Y, c: Z): String where X <: ToString, Z <: Father {
        a.toString()
    }

    public func p1(a: Int64, b!: Int64, c!: Int64 = 1) {
        a + b + c
    }
    public func p2(a: Son, b!: Son, c!: Son = Son()): Son {
        c
    }
    public func p3(a: Father, b!: Father, c!: Father = Father()): Father {
        c
    }
    protected func pp1(a: Int64, b!: Int64, c!: Int64 = 1) {
        a + b + c
    }
    protected func pp2(a: Son, b!: Son, c!: Son = Son()): Son {
        c
    }
    protected func pp3(a: Father, b!: Father, c!: Father = Father()): Father {
        c
    }

    @Version["1.1"]
    public func ano1() {
        1
    }
    @Version["1.1"]
    protected func pano1() {
        1
    }
    @Version["1.1"]
    func ano2() {
        2
    }

    public open func openfunc() {
        1
    }

    public const init() {}
}

public func assert<T>(expected: T, actual: T): Unit where T <: Equatable<T> & ToString {
    if (expected == actual) {
    } else {
        throw Exception("${expected} != ${actual}")
    }
}

public unsafe func checker(tc: TestClass): Unit {
    assert(tc.f1(), 1)
    assert(tc.f4(), 3)
    assert(tc.f6(), 5)
    assert(tc.openfunc(), 1)
    assert(tc.f8(), 8)
    assert(tc.f13(), 13)
    assert(tc.f14(), 14)
    assert(tc.g1<Int64, Int64, Son>(1, 2, Son()), "12")
    assert(tc.g2<Int64, String, Son>(1, "a", Son()), "1")
    assert(tc.p1(1, b: 2, c: 3), 6)
    assert(tc.p2(Son(), b: Son()) is Son, true)
    assert(tc.p3(Father(), b: Father()) is Father, true)
    assert(tc.ano1(), 1)
}
