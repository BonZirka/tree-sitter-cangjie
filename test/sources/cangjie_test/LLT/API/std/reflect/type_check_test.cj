/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// (CJNATIVE) EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (CJNATIVE) RUN-EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

/*
 * Test description:
 *      Test func apply(instance: Any, args: Array<Any>): Any
 *          Test whether type check is correct.
 */

import std.reflect.*

@Test
class typeCheckTest {
    @TestCase
    func testInstanceFunc() {
        let f = TypeInfo
            .of(A())
            .getInstanceFunction("test1", TypeInfo.of<UInt32>(), TypeInfo.of<Rune>(), TypeInfo.of<Float32>())
        try {
            f.apply(B(), [0u32, r'1', 1.1f32])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.apply(A(), [0, r'1', 1.1f32])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.apply(A(), [0u32, "1", 1.1f32])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.apply(A(), [0u32, r'1', 1])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        @Assert((f.apply(A(), 0u32, r'1', 1.1f32) as Int64).getOrThrow(), 1)
    }

    @TestCase
    func testStaticFunc() {
        let f = TypeInfo
            .of(A())
            .getStaticFunction("test2", TypeInfo.of<UInt32>(), TypeInfo.of<Rune>(), TypeInfo.of<Float32>())
        let ti = TypeInfo.of(A())
        try {
            f.apply(ti, [0, r'1', 1.1f32])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.apply(ti, [0u32, "1", 1.1f32])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.apply(ti, [0u32, r'1', 1])
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        @Assert((f.apply(ti, 0u32, r'1', 1.1f32) as Int64).getOrThrow(), 1)
    }

    @TestCase
    func testInstanceProp() {
        let f = TypeInfo.of(A()).getInstanceProperty("p1")
        try {
            f.getValue(B())
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.setValue(B(), 1)
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        try {
            f.setValue(A(), 0u32)
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        let obj = A()
        f.setValue(obj, 1)
        @Assert((f.getValue(obj) as Int64).getOrThrow(), 1)
    }

    @TestCase
    func testStaticProp() {
        let f = TypeInfo.of(A()).getStaticProperty("p2")
        try {
            f.setValue(0u32)
            @Expect(false)
        } catch (e: IllegalTypeException) {}
        let obj = A()
        f.setValue(1)
        @Assert((f.getValue() as Int64).getOrThrow(), 1)
    }
    @TestCase
    func testFatherType() {
        var a = A()
        var ci: CI = CI()
        let ti = TypeInfo.of(a)
        let instanceMethod = ti.getInstanceFunction("bar1", [TypeInfo.of<I>()])
        @Assert((instanceMethod.apply(a, ci) as Int64).getOrThrow(), 1)
        let staticMethod = ti.getStaticFunction("bar2", [TypeInfo.of<I>()])
        @Assert((staticMethod.apply(ti, ci) as Int64).getOrThrow(), 1)
    }
}

public class A {
    private var _p1 = 0
    private static var _p2 = 0
    public mut prop p1: Int64 {
        get() {
            _p1
        }
        set(v) {
            _p1 = v
        }
    }
    public mut static prop p2: Int64 {
        get() {
            _p2
        }
        set(v) {
            _p2 = v
        }
    }
    public func test1(p0: UInt32, p1: Rune, p2: Float32): Int64 {
        1
    }
    public static func test2(p0: UInt32, p1: Rune, p2: Float32): Int64 {
        1
    }
    public func bar1(a: I) {
        a.foo()
    }
    public static func bar2(a: I) {
        a.foo()
    }
}

public interface I {
    func foo(): Int64
}

public class CI <: I {
    public func foo(): Int64 {
        return 1
    }
}

public class B {}
