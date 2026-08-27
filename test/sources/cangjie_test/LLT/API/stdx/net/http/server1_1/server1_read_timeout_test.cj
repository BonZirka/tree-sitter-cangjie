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

import stdx.net.http.*
import stdx.net.tls
import stdx.crypto.kit
import stdx.encoding.url.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import stdx.log.*
import std.io.*

@Test
class TestServerReadTimeout {
    var server: ?Server = None

    @TestCase
    func testCT1(): Unit {
        startServer(Duration.second)
        let port = server?.port ?? 0
        let client = TcpSocket("127.0.0.1", port)
        client.connect()
        client.write(
            "GET /hello HTTP/1.1\r\nHost: 127.0.0.1:${port}\r\nConnection: keep-alive\r\nContent-Length: 100\r\n\r\n"
                .toArray())
        sleep(Duration.second * 2)
        try {
            client.write("aaaaaaaaa".toArray())
            sleep(Duration.second)
            client.write("aaaaaaaaaaaaaa".toArray())
        } catch (e: SocketException) {
            @Expect(true)
            return
        } finally {
            client.close()
            server?.close()
        }
        @Expect(false)
    }

    func startServer(timeout: Duration): Unit {
        server = ServerBuilder().addr("127.0.0.1").port(0).readTimeout(timeout).build()
        server?.logger.level = LogLevel.DEBUG
        server?
            .distributor
            .register(
                "/hello",
                {
                    ctx =>
                    let request = ctx.request
                    let buf = Array<Byte>(100, repeat: 0)
                    var i = 0
                    try {
                        do {
                            i = request.body.read(buf)
                        } while (i != 0)
                        @Expect(false)
                    } catch (e: HttpTimeoutException) {
                        @Expect(e.message, "Read body timeout and the connection is closed.")
                    }

                    ctx.responseBuilder.body("hello")
                }
            )
        spawn {
            server?.serve()
        }
        sleep(Duration.second)
    }
}
