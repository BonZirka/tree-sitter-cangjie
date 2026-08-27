/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ../data
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

/*
 * Test description:
 *      test upgrade method dealing with body
 * Test API:
 *      public func upgrade(ctx: HttpContext): StreamingSocket
 */

import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit
import std.time.*
import std.net.*
import std.collection.*

@Test
class Test_Upgrade_Body {
    let server = ServerBuilder().addr("127.0.0.1").port(0).build()
    var port = 0u16
    var arrbody = Array<UInt8>(16 * 1024, repeat: 66)
    var arrbody_0 = Array<UInt8>(16 * 1024, repeat: 65)
    let client = ClientBuilder().build()

    // 请求，响应均含有body：请求中的body在socket中读取，响应中被忽略
    @TestCase
    func upgradeTest(): Unit {
        startServer()

        let request = HttpRequestBuilder()
            .url("http://127.0.0.1:${port}/ok")
            .header("Upgrade", "abc")
            .body(arrbody)
            .build()
        let (_, conn) = client.upgrade(request)
        conn?.readTimeout = Duration.second * 3
        let buf = Array<UInt8>(50, repeat: 0)
        let len = conn?.read(buf) ?? 0
        @Expect(len, 5)
        @Expect("hello".toArray(), buf[0..len])
        sleep(4 * Duration.second)
        client.close()
        server.close()
        conn?.close()
    }

    func startServer() {
        server.distributor.register("/ok", handler)
        spawn {
            server.serve()
        }
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        port = server.port
    }

    func handler(ctx: HttpContext): Unit {
        ctx.responseBuilder.status(101)
        ctx.responseBuilder.body(arrbody_0)
        let conn = upgrade(ctx)
        conn.readTimeout = Duration.second * 3
        conn.write("hello".toArray())
        let buf = Array<UInt8>(16 * 1024, repeat: 0)
        let allBody = ArrayList<UInt8>()
        var readLen = conn.read(buf)
        while (readLen > 0) {
            try {
                allBody.add(all: buf[..readLen])
                readLen = conn.read(buf)
            } catch (e: Exception) {
                readLen = 0
            }
        }
        @Expect(allBody.toArray(), arrbody)
        println("read body success")
        conn.close()
    }
}
