/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 7.2.1.5.1.2.34
  @Scene: modify
  @Visibility: extend non-public class and non public/protected instance func
  @Object: extend instance func
  @Behavior: modify func namedparam to nonnamed
  @Expect: api compatible & abi compatible
*/
// LEVEL: 1
// DEPENDENCE: main.cj, template.cj
// EXEC: %compiler %cmp_opt %compile_dylib_opt template.cj -o libstable_abi.%dylib_suffix
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// EXEC: %rm libstable_abi.*
// EXEC: %mv test_stable_abi.cjo old.cjo
// EXEC: %compiler %cmp_opt %compile_dylib_opt %f -o libstable_abi.%dylib_suffix

// TEST CJCPL
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare template.cj
// TEST ABI Compatibility
// RUN-EXEC: %run %run_opt %output %run_args
// TEST API Compatibility
// EXEC: %compiler %cmp_opt main.cj %cmp_stable_abi_dylib -o %output
// RUN-EXEC: %run %run_opt %output %run_args

package test_stable_abi

// test extend: instance function
interface I{}
open public class Father {}
public class Son <: Father & I{}
interface I2 <: I {}

open public class TestClass {
    public const init() {}
}
extend TestClass {
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
    internal func f11(a:Int64, b!:Int64=1) {
        11
    }
    private func f12(a:Int64, b!:Int64=1) {
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

    private const func fa3(a:Int64, b!:Int64): Int64 {
        return 3
    }
    public const func f4(a!:Int64 = 1): Int64 {
        fa3(1,b:2)
    }
    internal const func paf3(a:Int64, b!:Int64): Int64 {
        return 3
    }
    protected const func paf4(a!:Int64 = 1): Int64 {
        paf3(1,b:2)
    }

    func fa5(a:Int64, b!:Int64): Int64 {
        return 5
    }
    @Frozen
    public func f6(a!:Int64 = 1): Int64 {
        fa5(1,b:2)
    }
}

open class privateClass {
    public const init() {}
}

extend privateClass {
    public func f1(a:Int64, b!:Int64) {
        1
    }
    protected func f2(a:Int64, b!:Int64) {
        2
    }

    private const func f3(a:Int64, b!:Int64): Int64 {
        return 3
    }
    public const func f4(): Int64 {
        f3(1,b:2)
    }
    internal const func pf3(a:Int64, b!:Int64): Int64 {
        return 3
    }
    protected const func pf4(): Int64 {
        pf3(1,b:2)
    }

    func f5(a:Int64, b!:Int64): Int64 {
        return 5
    }
    @Frozen
    public func f6(): Int64 {
        f5(1,b:2)
    }
    func pf5(a:Int64, b!:Int64): Int64 {
        return 5
    }
    @Frozen
    protected func pf6(): Int64 {
        pf5(1,b:2)
    }

    internal func f7(a:Int64, b:Int64) {
        7
    }
    private func f8(a:Int64, b:Int64) {
        8
    }
}

public func global() {
    let v1 = TestClass()
    v1.f7()
}
