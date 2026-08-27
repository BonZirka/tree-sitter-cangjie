/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// (not Windows)EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (not Windows)RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 

/*
 * Test description: Test when we use unix apis in unproper situations
 * Test API: Apis in Class UnixServerSocket & UnixSocket
 */

import std.unittest.*
import std.unittest.testmacro.*
import std.net.*
import std.time.*
import std.sync.*
import std.fs.*
import std.posix.*

var ser = Option<UnixServerSocket>.None
var sum = 0
var bound = AtomicUInt16(0)

@Test
class Test_Unix_Incorrect_Invocation {
    public override func beforeEach(): Unit {
        sum = 0
        bound = AtomicUInt16(0)
    }

    public override func beforeAll(): Unit {
        if (exists("./testsocket")) {
            remove("./testsocket", recursive: true)
        }
        Directory.create("./testsocket")
    }

    public override func afterAll(): Unit {
        if (exists("./testsocket")) {
            remove("./testsocket", recursive: true)
        }
    }

    public override func afterEach(): Unit {
        unlink("./testsocket/socket")
    }

    func startServer(): Unit {
        var server = UnixServerSocket(bindAt: "./testsocket/socket")
        server.bind()
        bound.fetchAdd(1)
        ser = Option<UnixServerSocket>.Some(server)
        var _ = server.accept(timeout: 2 * Duration.second)
    }

    @TestCase
    func test_server_init(): Unit {
        @Assert(exists("./testsocket"), true)
        var server = UnixServerSocket(bindAt: "./testsocket/socket")
        try {
            server.accept()
        } catch (e: SocketException) {
            sum += 1
        }
        try {
            server.accept(timeout: 50 * Duration.millisecond)
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 2)
    }

    @TestCase
    func test_bind(): Unit {
        @Assert(exists("./testsocket"), true)
        var server = UnixServerSocket(bindAt: "./testsocket/socket")
        server.bind()
        try {
            server.bind()
        } catch (e: SocketException) {
            sum += 1
        }
        server.close()
        @Expect(sum, 1)
    }

    @TestCase
    func test_server_closed(): Unit {
        @Assert(exists("./testsocket"), true)
        var server = UnixServerSocket(bindAt: "./testsocket/socket")
        server.bind()
        server.close()
        @Expect(server.isClosed(), true)
        // can close many times
        server.close()
        @Expect(server.isClosed(), true)
    }

    @TestCase
    func test_client_init(): Unit {
        @Assert(exists("./testsocket"), true)
        var client = UnixSocket("./testsocket/socket")
        var buf = Array<Byte>(10, repeat: 0)
        try {
            client.read(buf)
        } catch (e: SocketException) {
            sum += 1
        }
        try {
            client.write(buf)
        } catch (e: SocketException) {
            sum += 1
        }
        client.close()
        @Expect(sum, 2)
    }

    @TestCase
    func test_client_closed(): Unit {
        @Assert(exists("./testsocket"), true)
        spawn {
            startServer()
        }
        while (!bound.compareAndSwap(1, 0)) {
            sleep(Duration.millisecond)
        }
        var client = UnixSocket("./testsocket/socket")
        client.connect()
        sleep(Duration.second)
        client.close()
        @Expect(client.isClosed(), true)
        for (_ in 0..100) {
            client.close()
        }
        @Expect(client.isClosed(), true)

        var buf = Array<Byte>(10, repeat: 0)
        @Expect(0, client.read(buf))
        try {
            client.write(buf)
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 1)
        ser.getOrThrow().close()
    }

    @TestCase
    func test_binding00(): Unit {
        @Assert(exists("./testsocket"), true)
        var udpsocket = UdpSocket(bindAt: IPSocketAddress("127.0.0.1", 0))
        udpsocket.bind()

        var data = Array<UInt8>(10, repeat: 10)
        try {
            udpsocket.send(data)
        } catch (e: SocketException) {
            sum += 1
            @Expect(e.message.contains("not connected"), true)
        }
        try {
            udpsocket.receive(data)
        } catch (e: SocketException) {
            sum += 1
            @Expect(e.message.contains("not connected"), true)
        }

        @Expect(udpsocket.isClosed(), false)
        udpsocket.close()

        @Expect(sum, 2)
    }
}
