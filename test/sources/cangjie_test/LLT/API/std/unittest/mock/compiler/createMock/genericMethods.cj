/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../helpers
// (CJNATIVE) EXEC: %compiler %cmp_opt -Woff=all -p helpers --mock=on %compile_lib_opt --output p.%middle
// (CJNATIVE) EXEC: %compiler %cmp_opt -Woff=all p.%middle %n.cj -o %output %cmp_utest_opt 2>&1
// (CJNATIVE) EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

import std.mock_test_util.*
import std.unittest.*
import std.unittest.testmacro.*

class PassedBar {}

class PassedAnotherBar <: ToString {
    public override func toString() {
        "This is AnotherBar"
    }
}

class ReturnedBar <: ToString {
    private let x: String
    init(x: String) {
        this.x = x
    }
    public override func toString() {
        "This is ReturnedBar (${x})"
    }
}

class Foo<K> {
    public func boo<T>(x: K, y: T): ReturnedBar {
        println("original `boo` was called")
        ReturnedBar("original")
    }
    public func bee<T, R>(x: K, y: T): R {
        println("original `bee` was called")
        ReturnedBar("original") as R ?? throw Exception()
    }
}

@Test
public class TestA {
    public override func afterEach(): Unit {
        clearMatchers()
    }

    func callBoo(x: Foo<String>) {
        println("Return value: " + x.boo("my str 33", PassedAnotherBar()).toString())
    }
    func callBee(x: Foo<String>) {
        println("Return value: " + x.bee<PassedAnotherBar, ReturnedBar>("my str 33", PassedAnotherBar()).toString())
    }

    @TestCase
    func case1(): Unit {
        let a = unsafe { createMock<Foo<String>>(dummyMockingCallHandler) }
        let original = Foo<String>()
        addMatcher(
            "_CN7default3FooIG_E3booIG0_HG_G0_",
            [1, "my str", 3],
            ReturnedBar("1")
        )
        callBoo(a)
        println("Return value: " + original.boo("my str 32", PassedAnotherBar()).toString())
        println("==============================")
    }

    @TestCase
    func case2(): Unit {
        let a = unsafe { createMock<Foo<String>>(dummyMockingCallHandler) }
        let original = Foo<String>()
        addMatcher(
            "_CN7default3FooIG_E3beeIG0_G1_HG_G0_",
            [2, "my str 2", 4],
            ReturnedBar("2")
        )
        callBee(a)
        println(
            "Return value: " + original.bee<PassedAnotherBar, ReturnedBar>("my str 32", PassedAnotherBar()).toString())
        println("==============================")
    }
}

/* SCAN-IN
Actual call: boo<default:PassedAnotherBar>("my str 33", "This is AnotherBar")
Declared method: boo<T>(x[1, P, ND], y[2, P, ND])[NA, ND, AC, NA, genericMethods.cj:36:17]: Class-ReturnedBar
Declared function name: boo -> _CN7default3FooIG_E3booIG0_HG_G0_
Outer decl name: Foo<std.core:String> -> _CN7default3FooIG_E
Receiver: [doesn't implement ToString]
------------------------------
Return value: This is ReturnedBar (1)
original `boo` was called
Return value: This is ReturnedBar (original)
==============================
Actual call: bee<default:PassedAnotherBar, default:ReturnedBar>("my str 33", "This is AnotherBar")
Declared method: bee<T, R>(x[1, P, ND], y[2, P, ND])[NA, ND, AC, NA, genericMethods.cj:40:17]: Generics-R
Declared function name: bee -> _CN7default3FooIG_E3beeIG0_G1_HG_G0_
Outer decl name: Foo<std.core:String> -> _CN7default3FooIG_E
Receiver: [doesn't implement ToString]
------------------------------
Return value: This is ReturnedBar (2)
original `bee` was called
Return value: This is ReturnedBar (original)
==============================
 */
