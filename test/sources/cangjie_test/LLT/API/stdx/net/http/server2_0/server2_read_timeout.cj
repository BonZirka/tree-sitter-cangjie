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
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *      when readTimeout is set to Duration.Zero, and the size of request body is 10 MB, task of the corresponding timer will be triggered
 *      note: result depends on performance of Server and Client, we consumed that within 100 millisecond, a big request will timeout, while a small one will not timeout
 *
 * Test API: public class Server {
 *      public func serve(): Unit
 * }
 */
package tests.server2_0

import stdx.net.http.*
import std.time.*
import std.sync.*
import std.unittest.*
import std.unittest.testmacro.*
import stdx.net.tls.*
import stdx.crypto.x509.X509Certificate
import std.io.*
import {asan.*, tlsconfig.*}

@Test
class TestReadTimeout {
    var server = ServerBuilder().addr("127.0.0.1").port(0).readTimeout(Duration.Zero).tlsConfig(serverConfig()).build()

    let bodyArr = Array<UInt8>(10 * 1024 * 1024, repeat: 0)

    @TestCase
    func readTimeout(): Unit {
        startServer()

        let client = ClientBuilder().tlsConfig(clientConfig()).build()

        let request = HttpRequestBuilder()
            .version(HTTP2_0)
            .url("https://127.0.0.1:${server.port}/header")
            .header("trailer", "t1,t2,t3")
            .body(bodyArr)
            .build()

        try {
            let _ = client.send(request)
        } catch (e: Exception) {
            println("client failed: ${e}")
        }

        client.close()
        server.close()
        asanGC()
    }

    func startServer() {
        server.distributor.register("header", {ctx => consumeBody(ctx.request.body)})

        spawn {
            server.serve()
        }
        sleep(Duration.millisecond * 100)
    }

    func consumeBody(body: InputStream) {
        let buf = Array<UInt8>(10, repeat: 0)
        while (body.read(buf) > 0) {}
    }
}

//ASSERT:scan read request timeout on stream 1
