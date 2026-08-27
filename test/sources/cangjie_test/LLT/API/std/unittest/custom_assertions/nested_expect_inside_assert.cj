/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args --no-color 2>&1 | compare %f

// ASSERT: scan-1 Assert Failed: @Assert[checkIterAllSomeExpect](["Pascal", Option < String >.None, Option < String >.None, "Weierstrass"]):
// ASSERT: scan-1 ├── @Expect[checkNotNone](it):
// ASSERT: scan-1 │   └── Assert Failed: `(Expected it to be Some(_) but got None)`
// ASSERT: scan-1 └── @Expect[checkNotNone](it):
// ASSERT: scan-1     └── Assert Failed: `(Expected it to be Some(_) but got None)`

// ASSERT: scan-1 PASSED: 0
// ASSERT: scan-1 SKIPPED: 0
// ASSERT: scan-1 ERROR: 0
// ASSERT: scan-1 FAILED: 1
// ASSERT: scan-not SHOULD NOT RUN

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*

@CustomAssertion
func checkNotNone<V>(ctx: AssertionCtx, v: ?V): V {
    if (let Some(res) <- v) {
        return res
    }
    ctx.fail("Expected ${ctx.arg("v")} to be Some(_) but got None")
}

@CustomAssertion
func checkIterAllSomeAssert<T>(ctx: AssertionCtx, iter: Iterable<?T>): Array<T> {
    iter |> map {it: ?T => @Assert[checkNotNone](it)} |> collectArray
}

@CustomAssertion
func checkIterAllSomeExpect<T>(ctx: AssertionCtx, iter: Iterable<?T>): Unit {
    for (it in iter) {
        @Expect[checkNotNone](it)
    }
}

@Test
func testExpectInsideAssert() {
    @Assert[checkIterAllSomeExpect](["Pascal", Option<String>.None, Option<String>.None, "Weierstrass"])
    @Fail("SHOULD NOT RUN")
}
