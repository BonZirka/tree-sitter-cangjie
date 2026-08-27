/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../../tls/files
// DEPENDENCE: ../../../../asan
// DEPENDENCE: ../config
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %compile_lib_opt config/tlsconfig.cj -o tlsconfig.%middle
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f asan.%middle tlsconfig.%middle -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1

/*
 * Test description:
 *
 * Test API:
 *
 */

package tests.client

import stdx.net.http.*
import stdx.log.*
import std.sync.*
import stdx.net.tls.*
import std.io.*
import stdx.crypto.x509.X509Certificate
import std.time.*
import std.unittest.*
import std.unittest.testmacro.*
import {asan.*, tlsconfig.*}

@Test
class TestClientRequestH2Frames {
    static const msg = "abcdefghijklmnopqrstuvwxyz" * 1000
    var recv = ""

    var client: Client = ClientBuilder().tlsConfig(clientConfig()).build()
    var server = ServerBuilder().addr("127.0.0.1").port(0).tlsConfig(serverConfig()).build()

    @TestCase
    func testRequestFrames(): Unit {
        startServer()
        let buffer = ByteBuffer()
        buffer.write(msg.toArray())
        client.put("https://127.0.0.1:${server.port}/req", buffer)
        @Expect(recv, msg)
    }

    func startServer(): Unit {
        server
            .distributor
            .register(
                "/req",
                {
                    ctx =>
                    let buf = Array<Byte>(30000, repeat: 0)
                    var offset = 0
                    while (true) {
                        let len = ctx.request.body.read(buf[offset..])
                        if (len <= 0) {
                            break
                        }
                        offset += len
                    }
                    ctx.request.body.read(buf)
                    recv = String.fromUtf8(buf[..offset])
                    ctx.responseBuilder.body("OK")
                }
            )

        spawn {
            server.serve()
        }
        sleep(Duration.second)
    }
}
