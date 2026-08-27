/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f
// ASSERT: regex (.*FAIL.*) CASE: case01
// ASSERT: regex (.*FAIL.*) CASE: case02
// ASSERT: regex-not (.*FAIL.*) CASE: case03
// ASSERT: regex-not (.*FAIL.*) CASE: case04

import std.unittest.*
import std.unittest.testmacro.*

struct A <: Equatable<A> & ToString {
    public var x: Int32
    public var y: Rune
    public var z: String

    public init(a: Int32, b: Rune, c: String) {
        this.x = a
        this.y = b
        this.z = c
    }

    public operator func ==(that: A): Bool {
        if ((that.x == this.x) && (that.y == this.y) && (that.z == this.z)) {
            return true
        } else {
            return false
        }
    }

    public operator func !=(that: A): Bool {
        if ((that.x != this.x) || (that.y != this.y) || (that.z != this.z)) {
            return true
        } else {
            return false
        }
    }

    public func toString(): String {
        var res: String = "x: " + this.x.toString() + ", y: " + this.y.toString() + ", z: " + this.z
        return res
    }
}

func foo<T>(x: Option<T>): Option<T> {
    return x
}

@Test
class TestA {
    @TestCase
    public func case01(): Unit {
        var expect: Option<A> = Some<A>(A(0, r'a', "abc"))
        var actual: Option<A> = Some<A>(A(0, r'a', "efg"))
        expectEqual("expect", "actual", expect, actual)
    }

    @TestCase
    public func case02(): Unit {
        var expect: Option<A> = Option<A>.None
        expectEqual("expect", "actual", expect, foo(Some<A>(A(0, r'a', "efg"))))
    }

    @TestCase
    public func case03(): Unit {
        var expect: Option<A> = Some<A>(A(0, r'a', "abc"))
        expectEqual("expect", "actual", expect, foo(Some<A>(A(0, r'a', "abc"))))
    }

    @TestCase
    public func case04(): Unit {
        var expect: Option<A> = Option<A>.None
        expectEqual("expect", "actual", expect, foo(Option<A>.None))
    }
}
