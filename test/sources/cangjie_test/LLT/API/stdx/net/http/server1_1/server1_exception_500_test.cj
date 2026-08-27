/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1
package tests.server1_1

import std.unittest.*
import std.unittest.testmacro.*
import stdx.net.http.*
import stdx.net.tls
import stdx.crypto.kit

@Test
class TestServer1_1500 {
    let server = ServerBuilder().addr("127.0.0.1").port(0).build()

    func startHttpServer() {
        server.distributor.register("/a", handler1)
        server.serve()
    }
    func handler1(_: HttpContext): Unit {
        throw Exception("server is broken!")
    }
    @TestCase
    func testServer1_1500(): Unit {

        // http
        spawn {
            startHttpServer()
        }
        sleep(Duration.second)

        let client = ClientBuilder().build()
        let port = server.port
        let resp = client.get("http://127.0.0.1:${port}/a")
        println("--------------------------resp:------------------------")
        println(resp)
        @Expect(resp.toString().contains("connection: close\r\n"))
        @Expect(resp.toString().contains("content-type: text/plain; charset=utf-8\r\n"))
        @Expect(resp.toString().contains("content-length: 21\r\n"))
        let buf = Array<UInt8>(500, repeat: 0)
        let i = resp.body.read(buf)
        println("--------------------------body:------------------------")
        println(String.fromUtf8(buf[..i]))
        @Expect(String.fromUtf8(buf[..i]), "Internal Server Error")

        server.close()
        client.close()
    }
}
