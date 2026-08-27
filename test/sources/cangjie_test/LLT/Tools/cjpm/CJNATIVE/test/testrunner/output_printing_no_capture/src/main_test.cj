// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package mainmodule

internal import std.unittest.*
import std.unittest.testmacro.*

@Test
class MainTest {
    @TestCase
    func passing1() {
        println("Print for passed visible with --no-capture-output")
        @Assert(1, 1)
    }

    @TestCase
    func failing1() {
        @Assert(1, 2)
    }

    @TestCase
    func passing2() {
        @Assert(2, 2)
    }

    @TestCase
    func failing2() {
        throw Exception("MainTest.failing2")
    }
}
