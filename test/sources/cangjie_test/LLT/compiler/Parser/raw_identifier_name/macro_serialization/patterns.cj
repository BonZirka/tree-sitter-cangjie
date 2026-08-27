// EXEC:%compiler %n.cj %cmp_utest_opt 2>&1 | compare %f
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace
// ASSERT: scan-not error

import std.unittest.*
import std.unittest.testmacro.*


@Test
public class TestDemo {
    @TestCase
    func Case1(): Unit {
        let a = 1;
        let b = match (a) {
            case 0 => 0
            case `type` => `type`
        }
        @Assert(b == 1)
    }
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
