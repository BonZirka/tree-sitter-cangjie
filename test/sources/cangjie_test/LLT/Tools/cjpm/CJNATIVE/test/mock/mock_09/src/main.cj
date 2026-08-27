// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package b

internal import std.unittest.*
import std.unittest.testmacro.*
internal import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

main() {}

class C {
    func foo(): Bool {
        true
    }
}

@Test
class PackageFormat_Decl_Extend_Test {
    @TestCase
    func testParams(): Unit {
        let c = mock<C>()
        @On(c.foo()).returns(true)

        @Expect(c.foo(), true)
    }
}
