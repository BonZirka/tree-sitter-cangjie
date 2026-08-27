/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @No: 5.2.1.1.7.2
  @Scene: modify
  @Visibility: non public
  @Object: class static var
  @Behavior: class staticmember variable nonpublic to public
  @Expect: api compatible & abi compatible
 */
// LEVEL: 0
// DEPENDENCE: ../../../main.cj, ../../../template.cj
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

// test class: staticmember variable
public open class Father {}

public class Son <: Father {}

public class CC {
    public static let a1 = 1
    public static var a2 = 2
    public static const a3 = 3

    static let b1 = 1
    static var b2 = 2
    static const b3 = 3
    public static let b4 = 4
    public static var b5 = 5
    public static const b6 = 6

    public static let c1: Father = Son()

    static const d1 = 1
    public static const d2 = d1

    static const e1 = 1
    static let e2 = 2
    public static const func e3() {
        e1
    }

    @Frozen
    public func e4() {
        e2
    }
}

public func assert<T>(expected: T, actual: T): Unit where T <: Equatable<T> & ToString {
    if (expected == actual) {
    } else {
        throw Exception("${expected} != ${actual}")
    }
}

public func checker(): Unit {
    let c0 = CC()
    assert(CC.a1, 1)
    assert(CC.a2, 2)
    CC.a2 = 22
    assert(CC.a2, 22)
    CC.a2 = 2
    assert(CC.a2, 2)
    assert(CC.a3, 3)

    assert(CC.b1, 1)
    assert(CC.b2, 2)
    CC.b2 = 22
    assert(CC.b2, 22)
    CC.b2 = 2
    assert(CC.b2, 2)
    assert(CC.b3, 3)

    assert(CC.b4, 4)
    assert(CC.b5, 5)
    CC.b5 = 55
    assert(CC.b5, 55)
    CC.b5 = 5
    assert(CC.b5, 5)

    assert(CC.b6, 6)
    assert(CC.c1 is Son, true)
    assert(CC.d1, 1)
    assert(CC.d2, 1)

    assert(CC.e1, 1)
    assert(CC.e2, 2)
    assert(CC.e3(), 1)
    assert(c0.e4(), 2)
}
