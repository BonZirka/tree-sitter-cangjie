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
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *      Test Client1_1#receiveStatusLineHeader
 * Test API:
 *      public func request(request: HttpRequest): HttpResponse
 */
package tests.client1_1

import stdx.net.http.*
import asan.*
import stdx.encoding.url.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import stdx.log.*

@Test
class TestClient1_1ReceiveStatusLineHeader {
    let serverSocket = TcpServerSocket(bindAt: 0)

    @TestCase
    func client1_1ReceiveStatusLineHeader(): Unit {
        let fut = spawn {serverWriteStatusLineHeader()}
        sleep(Duration.millisecond * 10)

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let port = (serverSocket.localAddress as IPSocketAddress)?.port ?? 0
        let u = URL.parse("http://127.0.0.1:${port}/a")
        let r = HttpRequestBuilder().url(u).header("Host", "huawei.com").body("hello".toArray()).build()
        let response = client.send(r)
        @Expect(response.version, HTTP1_1)
        @Expect(response.status, 204)
        let responseString = response.toString()
        @Expect(responseString.contains("content-length: 10\r\n"))
        @Expect(responseString.contains("a: b\r\n"))
        @Expect(responseString.contains("b: c\r\n"))
        client.close()
        fut.get()
        serverSocket.close()
        println("ok")
        asanGC()
    }

    func serverWriteStatusLineHeader() {
        serverSocket.bind()
        let server = serverSocket.accept()
        let buf = Array<UInt8>(500, repeat: 0)
        sleep(Duration.millisecond * 10)
        server.read(buf)
        server.write("HTTP/1.1 204 ok\r\ncontent-length: 10\r\na: b\r\nb: c\r\n\r\n".toArray())
        server.close()
    }
}

/* SCAN-IN
ok
 */
