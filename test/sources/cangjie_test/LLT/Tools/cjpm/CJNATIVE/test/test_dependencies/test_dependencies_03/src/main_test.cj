// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package test

internal import std.unittest.*
internal import devDep.dev.*

@Test
public class TestM {
    @TestCase
    func addTest(): Unit {
        @Assert(add(12, 34), 46)
    }
}
