/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 

import std.net.*
import std.time.*
import std.sync.*
import std.unittest.*
import std.unittest.testmacro.*

var port = AtomicUInt16(0)
var ser = Option<TcpServerSocket>.None

@Test
class TestTcpServer {
    func startServer(): Unit {
        var server = TcpServerSocket(bindAt: IPSocketAddress("127.0.0.1", 0))
        server.bind()
        ser = Option<TcpServerSocket>.Some(server)
        port.store((server.localAddress as IPSocketAddress)?.port ?? 0)
        try {
            server.accept().close()
        } catch (e: SocketException) {
            @Assert("", "should accept successfully") // Server should accept client1 connection
        }
        try {
            server.accept().close()
            @Assert("shouldn't accept", "") // Server should be closed while client2 is waiting for connection
        } catch (e: SocketException) {
            // error message is randomly output, issue
            println("caught")
        }
    }

    @TestCase
    func test_server_closed(): Unit {
        let s = spawn {
            startServer()
        }
        sleep(200 * Duration.millisecond)

        try (client1 = TcpSocket(IPSocketAddress("127.0.0.1", port.load()))) {
            client1.connect()
        }
        sleep(Duration.second)
        ser.getOrThrow().close()
        sleep(Duration.second)

        try (client2 = TcpSocket(IPSocketAddress("127.0.0.1", port.load()))) {
            client2.connect()
            @Expect("", "shouldn't connect") // should not have connect success
        } catch (e: SocketException) {
            println(e.message) // error message is not the same on windows
            // @Expect(e.message.contains("Connection refused"))
        }

        s.get()
    }
}

// SCAN caught
