/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../../../../asan
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f asan.%middle -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1

package tests.client

import stdx.net.http.*
import stdx.net.tls
import stdx.crypto.kit
import std.unittest.*
import std.unittest.testmacro.*
import asan.*

@Test
class TestUrlEncode {
    var server = ServerBuilder().addr("127.0.0.1").port(0).build()

    @TestCase
    func testUrlEncode(): Unit {
        startServer()
        let client = ClientBuilder().build()
        let resp = client.get("http://127.0.0.1:${server.port}/%E4%BB%93%E9%A2%89")
        @Assert(resp.status, 200)
        let resp1 = client.get("http://127.0.0.1:${server.port}/仓颉")
        @Assert(resp1.status, 200)
        client.close()
        server.close()
        asanGC()
    }

    func startServer(): Unit {
        server.distributor.register("/仓颉", {
            ctx => ctx.responseBuilder.body("hello")
        })
        spawn {
            server.serve()
        }
        sleep(Duration.second)
    }
}
