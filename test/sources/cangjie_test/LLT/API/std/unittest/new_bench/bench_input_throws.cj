/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt --bench --no-color | compare %f
// ASSERT: scan ERROR: 1
// ASSERT: scan 123
// ASSERT: scan-not AssertException

import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*

@Test
class test001 {
    @Strategy
    func data(): GenerateEachInputProvider<Array<Int64>> {
        GenerateEachInputProvider {
            =>
            throw Exception("123")
            return Array<Int64>()
        }
    }

    @Bench[x in data]
    func test01(x: Array<Int64>) {
        println(x)
    }
}
