/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color 2>&1 | compare %f

package unittest.mock.integration

import std.unittest.*
import std.unittest.testmacro.*
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*
import std.collection.ArrayList

class Example {
    func f(_: Int64, _: Int64): String {
        "a"
    }
}

@Test
class IT1 {
    let m = mock<Example>()

    protected override func beforeAll(): Unit {
        @On(m.f(1, 2)).returns("").times(2)
    }

    @TestCase
    func t1(): Unit {
    }
}

/* SCAN-IN
    Non-trivial stub not allowed
    stub m.f(1, 2) declared at stateful_stub_in_before_all2.cj:30 cannot specify non-trivial cardinality in initializer of class IT1.
    Consider moving this stub into test case body.
 */
