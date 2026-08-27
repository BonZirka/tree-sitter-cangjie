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

/*
 * Test description:
 *      test server upgrade
 * Test API:
 *      public func upgrade(ctx: HttpContext): StreamingSocket
 */

package tests.server1_1

import stdx.net.http.*
import stdx.net.tls
import stdx.crypto.kit
import stdx.net.tls
import stdx.crypto.kit

import std.net.TcpSocket
import asan.*

@Test
class TestServer11Upgrade {
    let server = ServerBuilder().addr("127.0.0.1").port(0).build()
    var port = 0u16

    let client = ClientBuilder().build()

    @TestCase
    func upgradeTest(): Unit {
        startServer()

        let request = HttpRequestBuilder().url("http://127.0.0.1:${port}/").header("Upgrade", "abc").build()
        let (_, conn) = client.upgrade(request)

        let buf = Array<UInt8>(50, repeat: 0)
        let len = conn?.read(buf) ?? 0
        @Assert(String.fromUtf8(buf[..len]), "server write message")
        conn?.write("client write message".toArray())

        client.close()
        server.close()
        conn?.close()
        asanGC()
    }

    func startServer() {
        server.distributor.register("/", handler)
        spawn {
            server.serve()
        }
        sleep(Duration.millisecond * 200)
        port = server.port
    }

    func handler(ctx: HttpContext): Unit {
        ctx.responseBuilder.status(101)
        let conn = upgrade(ctx)
        conn.write("server write message".toArray())
        let buf = Array<UInt8>(50, repeat: 0)
        let len = conn.read(buf)
        @Assert(String.fromUtf8(buf[..len]), "client write message")
    }
}
