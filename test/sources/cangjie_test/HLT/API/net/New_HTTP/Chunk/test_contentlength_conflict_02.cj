/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %stdx-package  %cmp_utest_opt %f -o %output
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit
import std.time.*
import std.sync.*
import std.collection.*
import std.net.*
import stdx.log.*
import stdx.logger.*
import std.console.Console

var port = UInt16(0)
var server = ServerBuilder().addr("127.0.0.1").port(0).build()

@Test
class Test_Content_Length_Conflict_02 {
    func startserve(): Unit {
        server
            .distributor
            .register(
                "/ok",
                {
                    httpContext =>
                    httpContext.responseBuilder.header("content-length", "10")
                    httpContext.responseBuilder.body("abcdefgIII")
                }
            )
        server.logger.level = LogLevel.OFF
        server.serve()
    }

    // 校验服务端收非法报文
    @TestCase
    func test_01(): Unit {
        spawn {
            startserve()
        }

        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        port = server.port
        var client1 = TcpSocket("127.0.0.1", port)
        client1.connect(timeout: Duration.second)
        var str1 = "GET /ok HTTP/1.1\r\nhost: 127.0.0.1:${port}\r\ncontent-length: 5\r\ncontent-length: 15\r\n\r\n"
        var str2 = "GET /ok HTTP/1.1\r\nhost: 127.0.0.1:${port}\r\ncontent-length: 5\r\ntransfer-encoding: chunked\r\n\r\n"
        var str3 = "GET /ok HTTP/1.1\r\nhost: 127.0.0.1:${port}\r\ncontent-length: abc\r\n\r\n"
        var buf = Array<UInt8>(1000, repeat: 0)
        client1.write(str1.toArray())
        var readlen1 = client1.read(buf)
        var readbuf1 = String.fromUtf8(buf[0..readlen1])
        @Expect(readbuf1.contains("HTTP/1.1 400 Bad Request"), true)
        client1.close()

        var client2 = TcpSocket("127.0.0.1", port)
        client2.connect(timeout: Duration.second)
        client2.write(str2.toArray())
        var readlen2 = client2.read(buf)
        var readbuf2 = String.fromUtf8(buf[0..readlen2])
        @Expect(readbuf2.contains("HTTP/1.1 400 Bad Request"), true)
        client2.close()

        var client3 = TcpSocket("127.0.0.1", port)
        client3.connect(timeout: Duration.second)
        client3.write(str3.toArray())
        var readlen3 = client3.read(buf)
        var readbuf3 = String.fromUtf8(buf[0..readlen3])
        @Expect(readbuf3.contains("HTTP/1.1 400 Bad Request"), true)
        client3.close()
        server.close()
    }
}
