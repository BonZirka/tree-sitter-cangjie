// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package submodule.pack2

internal import std.unittest.*
import std.unittest.testmacro.*
internal import std.process.*

@Test
@Parallel
class Pack2Test {
    @TestCase
    func passing1() {
        println("Hello from Pack2Test.passing1")
        @Assert(1, 1)
    }

    @TestCase
    func crashing() {
        Process.current.exit(42)
    }

    @TestCase
    func passing2() {
        @Assert(2, 2)
    }

    @TestCase
    func failing1() {
        @Assert(1, 2)
    }

    @TestCase
    func failing2() {
        throw Exception("Pack2Test.failing2")
    }
}
