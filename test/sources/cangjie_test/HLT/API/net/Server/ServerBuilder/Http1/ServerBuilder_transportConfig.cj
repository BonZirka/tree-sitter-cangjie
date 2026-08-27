/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %run_stdx %output %run_utest_opt %run_args 2>&1 | compare %f
//ASSERT: scan [HttpEngineConn1#readRequest] exception: SocketTimeoutException
//ASSERT: scan ()
//ASSERT: scan Buffer size should be positive, got 0
//ASSERT: scan Buffer size should be positive, got -9223372036854775808
//ASSERT: scan Buffer size should be positive, got 0
//ASSERT: scan Buffer size should be positive, got -9223372036854775808
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import std.net.*
import std.collection.*
import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit
import std.math.*

@Test
public class Test_transportConfig {
    @TestCase
    func default(): Unit {
        var cfg = TransportConfig()
        let server = ServerBuilder().addr("127.0.0.1").port(0).transportConfig(cfg).build()
        @Expect(server.transportConfig.readTimeout, Duration.Max)
        @Expect(server.transportConfig.writeTimeout, Duration.Max)
        @Expect(server.transportConfig.writeBufferSize, None)
        @Expect(server.transportConfig.readBufferSize, None)
        @Expect(server.transportConfig.keepAliveConfig.idle, Duration.second * 45)
        @Expect(server.transportConfig.keepAliveConfig.interval, Duration.second * 5)
        @Expect(server.transportConfig.keepAliveConfig.count, 5)
    }

    @TestCase
    func readTimeout_01(): Unit {
        var cfg = TransportConfig()
        cfg.readTimeout = Duration.Max
        let server = ServerBuilder().addr("127.0.0.1").port(0).transportConfig(cfg).build()
        @Expect(server.transportConfig.readTimeout, Duration.Max)
    }

    @TestCase
    func readTimeout_02(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.readTimeout = Duration.Zero
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.readTimeout, Duration.Zero)
    }

    @TestCase
    func readTimeout_03(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.readTimeout = Duration.Min
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.readTimeout, Duration.Zero)
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        var buf = Array<Byte>(10000, repeat: 0)
        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
        socket.read(buf)
    }

    @TestCase
    func writeTimeout_01(): Unit {
        var cfg = TransportConfig()
        cfg.writeTimeout = Duration.Max
        let server = ServerBuilder().addr("127.0.0.1").port(0).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeTimeout, Duration.Max)
    }

    @TestCase
    func writeTimeout_02(): Unit {
        var cfg = TransportConfig()
        cfg.writeTimeout = Duration.Zero
        let server = ServerBuilder().addr("127.0.0.1").port(0).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeTimeout, Duration.Zero)
    }

    @TestCase
    func writeTimeout_03(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.writeTimeout = Duration.Min
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeTimeout, Duration.Zero)
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
        let preface = "GET / HTTP/1.1\r\nHost: 127.0.0.1:${server.port}\r\nTransfer-encoding: chunked\r\nConnection: close\r\n\r\n9\r\ntest for \r\n7\r\nchunked\r\n0\r\n\r\n"
            .toArray()
        let resp = socket.write(preface)
        println(resp)
    }

    @TestCase
    func writeBufferSize_01(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.writeBufferSize = Int64.Max
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeBufferSize, Int64.Max)
    }

    @TestCase
    func writeBufferSize_02(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.writeBufferSize = 0
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeBufferSize, 0)
        server.distributor.register("/", {ctx => ctx.responseBuilder.body("hello")})
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
    }

    @TestCase
    func writeBufferSize_03(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.writeBufferSize = Int64.Min
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.writeBufferSize, Int64.Min)
        server.distributor.register("/", {ctx => ctx.responseBuilder.body("hello")})
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
    }

    @TestCase
    func readBufferSize_01(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.readBufferSize = Int64.Max
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.readBufferSize, Int64.Max)
    }

    @TestCase
    func readBufferSize_02(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.readBufferSize = 0
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.readBufferSize, 0)
        server.distributor.register("/", {ctx => ctx.responseBuilder.body("hello")})
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
    }

    @TestCase
    func readBufferSize_03(): Unit {
        let serverSocket = TcpServerSocket(bindAt: 0)
        var cfg = TransportConfig()
        cfg.readBufferSize = Int64.Min
        let server = ServerBuilder().listener(serverSocket).transportConfig(cfg).build()
        @Expect(server.transportConfig.readBufferSize, Int64.Min)
        server.distributor.register("/", {ctx => ctx.responseBuilder.body("hello")})
        spawn {server.serve()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }
        var socket = TcpSocket("127.0.0.1", server.port)
        socket.connect()
    }
}
