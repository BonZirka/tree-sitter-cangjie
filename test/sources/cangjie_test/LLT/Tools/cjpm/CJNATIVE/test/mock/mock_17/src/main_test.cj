// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package b

internal import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

@Test
class FooTest {
    @Bench
    @Configure[batchSize: 1]
    func test_to_be_benched_with_mock(): Unit {
        let m = mock<ClassToMock>()
        @On(m.foo()).returns(false)

        @Expect(m.foo(), false)
    }
}
