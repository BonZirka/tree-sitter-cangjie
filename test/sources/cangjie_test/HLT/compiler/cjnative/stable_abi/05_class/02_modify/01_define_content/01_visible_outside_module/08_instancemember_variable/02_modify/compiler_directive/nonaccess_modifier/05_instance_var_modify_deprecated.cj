/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @No: 5.2.1.1.8.2.5
  @Scene: modify
  @Visibility: protected
  @Object: class instance var
  @Behavior: modify @Deprecated: error -> warning
  @Expect: api compatible & abi compatible
 */
// LEVEL: 0
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

// test class: staticmember variable
public open class Father {}

public class Son <: Father {}

public class CC {
    public static let c1: Father = Son()

    protected var a1 = 1
    protected let a2 = 2
    protected let a3 = 3

    @Deprecated["this var is deprecated", strict: false]
    protected let b1 = 1

    @Deprecated["this var is deprecated", strict: false]
    protected var b2 = 2

    @Frozen
    public func f1() {
        a1
    }

    @Frozen
    public func f2() {
        a2
    }
}

public func assert<T>(expected: T, actual: T): Unit where T <: Equatable<T> & ToString {
    if (expected == actual) {
    } else {
        throw Exception("${expected} != ${actual}")
    }
}

public func checker(): Unit {
    let c = CC()
    assert(CC.c1 is Son, true)
    assert(c.a1, 1)
    assert(c.a2, 2)
    assert(c.a3, 3)
    assert(c.b1, 1)
    assert(c.b2, 2)
    assert(c.f1(), 1)
    assert(c.f2(), 2)
}
