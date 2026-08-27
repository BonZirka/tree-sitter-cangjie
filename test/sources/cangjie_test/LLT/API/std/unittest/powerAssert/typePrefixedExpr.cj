/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color 2>&1 | compare %f

import std.unittest.*
import std.unittest.testmacro.*

class Foo <: ToString {
    func fromUtf8(x: Array<UInt8>): String {
        "123"
    }
    public func toString() {
        "Foo"
    }
}

class S {
    static func fromUtf8(x: Array<UInt8>): String {
        "123"
    }
}

@Test
class AssertTest {
    @TestCase
    func assertTest1() {
        let a = "123".toArray()
        @PowerAssert(String.fromUtf8(a).contains("1234"))
    }
    @TestCase
    func assertTest2() {
        let a = "123".toArray()
        let string = Foo()
        @PowerAssert(string.fromUtf8(a).contains("1234"))
    }
    @TestCase
    func assertTest3() {
        let a = "123".toArray()
        let SOME_OF_MY_CONST = Foo()
        @PowerAssert(SOME_OF_MY_CONST.fromUtf8(a).contains("1234"))
    }
    @TestCase
    func assertTest4() {
        let a = "123".toArray()
        @PowerAssert(S.fromUtf8(a).contains("1234"))
    }
}

/* SCAN-IN
    Assert Failed: `(String.fromUtf8(a).contains("1234"))`
                    |               |_||
                    |           [49, 50, 51]
                    |__________________|
                            "123"
 */

/* SCAN-IN
    Assert Failed: `(string.fromUtf8(a).contains("1234"))`
                    |______|        |_||
                    |  Foo      [49, 50, 51]
                    |__________________|
                            "123"
 */

/* SCAN-IN
    Assert Failed: `(SOME_OF_MY_CONST.fromUtf8(a).contains("1234"))`
                    |________________|        |_||
                    |       Foo           [49, 50, 51]
                    |____________________________|
                                 "123"
 */

/* SCAN-IN
    Assert Failed: `(S.fromUtf8(a).contains("1234"))`
                    |          |_||
                    |      [49, 50, 51]
                    |_____________|
                         "123"
 */
