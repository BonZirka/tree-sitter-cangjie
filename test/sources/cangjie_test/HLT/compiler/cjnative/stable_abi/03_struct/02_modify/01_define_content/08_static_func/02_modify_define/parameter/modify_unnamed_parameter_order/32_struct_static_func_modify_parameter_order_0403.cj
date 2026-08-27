/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 3.2.1.8.2.32
  @Scene: modify
  @Visibility: used in public @Frozen declare
  @Object: struct static func
  @Behavior: modify function parameter order: non named parameter
  @Expect: api incompatible & abi incompatible
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
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare %f
// ASSERT: scan Incompatible!
// ASSERT: scan-1 [API/ABI] Changed unnamed parameter order of function visible outside the module.
// ASSERT: scan-1 [ABI] The body of a const function or function marked with @Frozen changed.
// ASSERT: scan-not [API]
// ASSERT: scan-1 [ABI]
// ASSERT: scan-1 [API/ABI]

// test struct: modify function parameter order: non named parameter
package test_stable_abi

public struct Rectangle {
    let width = 10
    public func getWidth(): Int64{
        return width
    }
}

open public class A {const init() {}}
public class B <: A {const init() {}}
public class C <: A {const init() {}}

public struct S1 {
    public static func f1(a:Float64, b:B, c!:Int64, d!:Int64 = 1) {
        return a
    }

    const static func f2(a:Float64, b:B, c!:Int64, d!:Int64 = 2) {
        return a
    }
    public const static func f22() {
        return f2(1.1, B(), c:1, d:2)
    }

    static func f3(a:Float64, b:B, c!:Int64, d!:Int64 = 3) {
        return a
    }
    @Frozen
    public static func f33() {
        return f3(1.1, B(), c:1, d:3)
    }

    static func f4(a:Float64, b:B, c!:Int64, d!:Int64 = 4) {
        return a
    }
}

struct S2 {
    public static func f1(a:Float64, b:B, c!:Int64, d!:Int64 = 1) {
        return a
    }

    const static func f2(a:Float64, b:B, c!:Int64, d!:Int64 = 2) {
        return a
    }
    public const static func f22() {
        return f2(1.1, B(), c:1, d:2)
    }

    static func f3(a:Float64, b:B, c!:Int64, d!:Int64 = 3) {
        return a
    }
    @Frozen
    public static func f33() {
        return f3(1.1, B(), c:1, d:3)
    }

    static func f4(a:Float64, b:B, c!:Int64, d!:Int64 = 4) {
        return a
    }
}

public struct S22 {
    let s2 = S2()
}

struct S3 {
    public static func f1(a:Float64, b:B, c!:Int64, d!:Int64 = 1) {
        return a
    }

    const static func f2(a:Float64, b:B, c!:Int64, d!:Int64 = 2) {
        return a
    }
    public const static func f22() {
        return f2(1.1, B(), c:1, d:2)
    }

    static func f3(a:Float64, b:B, c!:Int64, d!:Int64 = 3) {
        return a
    }
    @Frozen
    public static func f33() {
        return f3(1.1, B(), c:1, d:3)
    }

    static func f4(a:Float64, b:B, c!:Int64, d!:Int64 = 4) {
        return a
    }
}

public struct S33 {
    @Frozen
    public static func f() {
        let s3 = S3()
    }
}

struct S4 {
    const init() {}
    public static func f1(a:Float64, b:B, c!:Int64, d!:Int64 = 1) {
        return a
    }

    const static func f2(a:Float64, b:B, c!:Int64, d!:Int64 = 2) {
        return a
    }
    public const static func f22() {
        return f2(1.1, B(), c:1, d:2)
    }

    static func f3(b:B, a:Float64, c!:Int64, d!:Int64 = 3) {
        return a
    }
    @Frozen
    public static func f33() {
        return f3(B(), 1.1, c:1, d:3)
    }

    static func f4(a:Float64, b:B, c!:Int64, d!:Int64 = 4) {
        return a
    }
}

public struct S44 {
    const init() {}
    public const static func f() {
        let s4 = S4()
    }
}

struct S5 {
    public static func f1(a:Float64, b:B, c!:Int64, d!:Int64 = 1) {
        return a
    }

    const static func f2(a:Float64, b:B, c!:Int64, d!:Int64 = 2) {
        return a
    }
    public const static func f22() {
        return f2(1.1, B(), c:1, d:2)
    }

    static func f3(a:Float64, b:B, c!:Int64, d!:Int64 = 3) {
        return a
    }
    @Frozen
    public static func f33() {
        return f3(1.1, B(), c:1, d:3)
    }

    static func f4(a:Float64, b:B, c!:Int64, d!:Int64 = 4) {
        return a
    }
}