/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %cmp_utest_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.net.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
class Test_Tcp_Nodelay {
    @TestCase
    func test_illegal_address(): Unit {
        try {
            TcpSocket("211111111111111111111111111111111.&B", 0)
            @Assert(false) // should throw exception.
        } catch (e: Exception) {
            println(e.message)
            @Expect(e.message.contains("resolve"))
        }
    }
}
