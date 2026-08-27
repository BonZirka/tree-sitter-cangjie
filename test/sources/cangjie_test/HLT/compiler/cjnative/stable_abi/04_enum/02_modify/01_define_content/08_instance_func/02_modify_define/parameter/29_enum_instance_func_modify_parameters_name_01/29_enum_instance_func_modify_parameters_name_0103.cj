/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 4.2.1.8.2.29
  @Scene: modify
  @Visibility: public enum and non-public instance func used in const declare
  @Object: enum instance func
  @Behavior: modify named parameters name
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
// ASSERT: scan-1 [API/ABI] Cannot change name of named parameter.
// ASSERT: scan-1 [ABI] The body of a const function or function marked with @Frozen changed.
// ASSERT: scan-not [API]
// ASSERT: scan-1 [ABI]
// ASSERT: scan-1 [API/ABI]

// test enum: modify function parameter name: named
package test_stable_abi

open public class A {
    let a: Int64 = 10
}

public class B <: A {
    let b: Int64 = 20
}

public enum Rectangle {
    | Red | Green | Blue(UInt8)

    public func getWidth(): Int64{
        return 11
    }

    public func geta(a: String, b!: Int64, c!: Int64 = 1): Int64 {
        return b + c
    }

    func geta1(a: Int64, b!: Int64) {
        return 1
    }

    @Frozen
    public func geta2() {
        let x = geta1(1, b: 1)
        return x
    }

    public func geta3(a: Int64, b!: Int64) {
        return 1
    }

    func geta4(a: Int64, b: Float64, c!: Int64=1, d!: Float64=2.2) {
        return 1
    }

    @Frozen
    public func geta5() {
        let x = geta4(1, 2.1, c: 1, d: 2.2)
        return x
    }

    public func geta6(a: Int64, b: Float64, c!: Int64=1, d!: Float64=2.2) {
        return 1
    }

    func geta7(a: A, b: B) {
        return 1
    }

    @Frozen
    public func geta8() {
        let x = geta7(A(), B())
        return x
    }

    const func geta9(a: Int64, c!: Float64) {
        return 1
    }

    public const func geta10(a: Int64, b: Float64, c!: Int64=1, d!: Float64=2.2) {
        geta9(1, c: 1.2)
        return 1
    }

    func geta11(a: Int64, b: Float64, c!: Int64=1) {
        return 1
    }
}
