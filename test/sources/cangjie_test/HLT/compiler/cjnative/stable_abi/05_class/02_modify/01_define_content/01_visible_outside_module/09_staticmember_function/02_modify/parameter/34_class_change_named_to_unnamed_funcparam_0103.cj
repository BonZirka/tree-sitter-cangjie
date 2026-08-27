/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
/*
  @No: 5.2.1.1.9.2.34
  @Scene: modify
  @Visibility: public class and non-public static func used in @Frozen declare
  @Object: class static func
  @Behavior: change named to unnamed func parameter
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
// ASSERT: scan-1 [API/ABI] Named parameter cannot be made unnamed parameter.
// ASSERT: scan-1 [API/ABI] Deleted default value of named parameter.
// ASSERT: scan-2 [API/ABI]
// ASSERT: scan-not [API]
// ASSERT: scan-1 [ABI] The body of a const function or function marked with @Frozen changed.
// ASSERT: scan-1 [ABI]

package test_stable_abi

// test class: staticmember function
open public class Father {}
public class Son <: Father {}

public class TestClass {
    public static func f1(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        a + 1
    }

    static const func f2(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        return a + 2
    }
    public static const func f3(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f2(a, b, c: 1, d: 1)
    }

    static func f4(a: Int64, b: Int64, c: Int64, d!: Int64 = 1): Int64 {
        return a + 4
    }
    @Frozen
    public static func f5(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f4(a, b, c, d: 1) + a
    }

    public static func p1(a: Int64, b!: Int64, c!: Int64 = 1, d!: Int64 = 1) {
        a + b + c
    }
    public static func p2(a: Son, b!: Son, c!: Son = Son()): Son {
        c
    }
    public static func p3(a: Father, b!: Father, c!: Father = Father()): Father {
        c
    }
}

open class baseClass {
    public static func f1(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        a + 1
    }

    static const func f2(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        return a + 2
    }
    public static const func f3(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f2(a, b, c: 1, d: 1)
    }

    static func f4(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        return a + 4
    }
    @Frozen
    public static func f5(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f4(a, b, c: 1, d: 1) + a
    }

    public static func p1(a: Int64, b!: Int64, c!: Int64 = 1, d!: Int64 = 1) {
        a + b + c
    }
    public static func p2(a: Son, b!: Son, c!: Son = Son()): Son {
        c
    }
    public static func p3(a: Father, b!: Father, c!: Father = Father()): Father {
        c
    }
}

public class B <: baseClass {
    let b: Int64 = 20
}

class privateClass {
    public static func f1(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        a + 1
    }

    static const func f2(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        return a + 2
    }
    public static const func f3(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f2(a, b, c: 1, d: 1)
    }

    static func f4(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        return a + 4
    }
    @Frozen
    public static func f5(a: Int64, b: Int64, c!: Int64 = 1, d!: Int64 = 1): Int64 {
        f4(a, b, c: 1, d: 1) + a
    }

    public static func p1(a: Int64, b!: Int64, c!: Int64 = 1, d!: Int64 = 1) {
        a + b + c
    }
    public static func p2(a: Son, b!: Son, c!: Son = Son()): Son {
        c
    }
    public static func p3(a: Father, b!: Father, c!: Father = Father()): Father {
        c
    }
}
