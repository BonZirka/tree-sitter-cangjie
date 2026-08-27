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
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %compile_lib_opt config/tlsconfig.cj -o tlsconfig.%middle
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f asan.%middle tlsconfig.%middle -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1

/*
 * Test description:
 *
 * Test API:
 *
 */

package tests.client2_0

import stdx.net.http.*
import stdx.log.*
import std.time.*
import stdx.net.tls.*
import stdx.crypto.x509.X509Certificate
import std.sync.*
import std.unittest.*
import std.unittest.testmacro.*
import {asan.*, tlsconfig.*}

@Test
class Test100Continue {
    let client = ClientBuilder().tlsConfig(clientConfig()).writeTimeout(Duration.Max).readTimeout(Duration.Max).build()
    let server = ServerBuilder().addr("127.0.0.1").port(0).tlsConfig(serverConfig()).build()

    @TestCase
    func test100ContinueSuccess(): Unit {
        startServer()
        sleep(Duration.second)
        let req = HttpRequestBuilder()
            .version(HTTP2_0)
            .url("https://127.0.0.1:${server.port}/hd1")
            .header("expect", "100-continue")
            .body("hello")
            .build()
        let resp = client.send(req)
        let buf = Array<UInt8>(10, repeat: 0)
        let len = resp.body.read(buf)
        @Assert(String.fromUtf8(buf[..len]), "ok")
        client.close()
        server.close()
        asanGC()
    }

    func startServer(): Unit {
        server
            .distributor
            .register(
                "/hd1",
                {
                    ctx =>
                    ctx.request.body.read(Array<UInt8>(5, repeat: 0))
                    ctx.responseBuilder.body("ok")
                }
            )

        spawn {
            server.serve()
        }
    }
}
