/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// (not Windows) EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (not Windows) RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 
import std.unittest.*
import std.unittest.testmacro.*
import std.posix.*

@Test
class Test_isLnk {
    @TestCase
    func test_isLnk_01(): Unit {
        var res = isLnk("/")
        @Assert(res, false)
    }

    @TestCase
    func test_isLnk_02(): Unit {
        var cre = creat("test.lnk", S_IRWXU)
        @Assert(cre != -1, true)
        var res = isLnk("/")
        remove("test.lnk")
        @Assert(res, false)
    }
}
