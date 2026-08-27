/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 4.2.1.6.2.30
  @Scene: modify
  @Visibility: used in public const decl
  @Object: enum[static member function]
  @Behavior: modify unnamed parameters to named parameters
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
// E-EXEC-PIPE: %cjcpl %old_cjo old.cjo %new_cjo test_stable_abi.cjo 2>&1 | compare %f
// ASSERT: scan Incompatible!
// ASSERT: scan-1 [API/ABI] Unnamed parameter cannot be made named parameter.
// ASSERT: scan-not [API]
// ASSERT: scan-not [ABI]
// ASSERT: scan-1 [API/ABI]

// test enum: modify unnamed parameters to named parameters
// 修改非命名参数为命名参数
package test_stable_abi

import std.random.*

public class A {}

public enum RectangleA {
    | Red | Green | Blue(UInt8)

    public func getWidth(): Int64{
        return 11
    }

    public const static func getA(a: Random, b!: Int64, c!: Int64 = 1): Int64 {
        let x = Rectangle.Red
        return b + c
    }
}

enum Rectangle {
    | Red | Green | Blue(UInt8)

    public func getWidth(): Int64{
        return 11
    }

    @Frozen
    public static func getA(a!: Random, b!: Int64, c!: Int64 = 1): Int64 {
        let x = getC(1, b:1)
        return b + c
    }

    public const static func getB(a: Int64, b!: Int64, c!: Int64 = 1): Int64 {
        let x = getD(1, b:1)
        return b + c
    }

    static const func getC(a: Int64, b!: Int64, c!: Int64 = 1): Int64 {
        return b + c
    }

    static const func getD(a: Int64, b!: Int64, c!: Int64 = 1): Int64 {
        return b + c
    }

    static const func getE(a: Int64, b!: Int64, c!: Int64 = 1): Int64 {
        return b + c
    }
}