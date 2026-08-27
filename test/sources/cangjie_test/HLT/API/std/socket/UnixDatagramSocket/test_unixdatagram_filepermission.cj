/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// (not Windows)EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// (not Windows)RUN-EXEC: export USER=`whoami` && %run %run_opt %output %run_utest_opt %run_args

import std.unittest.*
import std.unittest.testmacro.*
import std.net.*
import std.time.*
import std.sync.*
import std.fs.*
import std.process.*
import std.posix.*

var data = Array<Byte>(50, repeat: 10)
var unixdatagram = Option<UnixDatagramSocket>.None
var sum = 0
var user = Option<String>.None

@Test
class Test_Unixdatagram_Filepermission {
    public override func beforeAll(): Unit {
        if (exists("./testunixdatagram1")) {
            remove("./testunixdatagram1", recursive: true)
        }
        Directory.create("./testunixdatagram1")

        if (exists("./testunixdatagram2")) {
            remove("./testunixdatagram2", recursive: true)
        }
        Directory.create("./testunixdatagram2")

        user = Process.current.getEnv("USER")
    }
    public override func afterAll(): Unit {
        if (exists("./testunixdatagram1")) {
            remove("./testunixdatagram1", recursive: true)
        }
        if (exists("./testunixdatagram2")) {
            remove("./testunixdatagram2", recursive: true)
        }
    }
    public override func beforeEach(): Unit {
        sum = 0
    }

    @TestCase
    func test_01(): Unit {
        @Assert(exists("./testunixdatagram1"), true)
        @Assert(exists("./testunixdatagram2"), true)
        match (user) {
            case Some("root") => ()
            case _ =>
                var dirinfo1 = FileInfo("./testunixdatagram1")
                @Expect(dirinfo1.setWritable(false), true)

                var unixdatagramsocket1 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket1")
                try {
                    unixdatagramsocket1.bind()
                } catch (e: SocketException) {
                    @Expect(e.message.contains("Permission denied"))
                    sum += 1
                }
                @Expect(sum, 1)
                @Expect(dirinfo1.setWritable(true), true)
                unlink("./testunixdatagram1/socket1")
        }
    }

    @TestCase
    func test_02(): Unit {
        @Assert(exists("./testunixdatagram1"), true)
        @Assert(exists("./testunixdatagram2"), true)
        var unixdatagramsocket1 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket1")
        unixdatagramsocket1.bind()
        var addr1 = unixdatagramsocket1.localAddress
        var unixdatagramsocket2 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket2")
        unixdatagramsocket2.bind()
        var addr2 = unixdatagramsocket2.localAddress
        var dirinfo1 = FileInfo("./testunixdatagram1")
        @Expect(dirinfo1.setWritable(false), true)
        try {
            unixdatagramsocket1.connect(addr2)
            unixdatagramsocket2.connect(addr1)
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 0)
        var buf = Array<Byte>(50, repeat: 0)
        unixdatagramsocket1.send(data)
        unixdatagramsocket2.receive(buf)
        @Expect(data, buf)
        @Expect(dirinfo1.setWritable(true), true)
        unlink("./testunixdatagram1/socket1")
        unlink("./testunixdatagram1/socket2")
    }

    @TestCase
    func test_03(): Unit {
        @Assert(exists("./testunixdatagram1"), true)
        @Assert(exists("./testunixdatagram2"), true)
        var dirinfo1 = FileInfo("./testunixdatagram1")
        var dirinfo2 = FileInfo("./testunixdatagram2")
        @Expect(dirinfo1.setReadable(false), true)
        @Expect(dirinfo2.setReadable(false), true)

        var unixdatagramsocket1 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket1")
        unixdatagramsocket1.bind()
        var addr1 = unixdatagramsocket1.localAddress
        var unixdatagramsocket2 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket2")
        unixdatagramsocket2.bind()
        var addr2 = unixdatagramsocket2.localAddress

        unixdatagramsocket1.connect(addr2)
        unixdatagramsocket2.connect(addr1)

        var buf = Array<Byte>(50, repeat: 0)
        unixdatagramsocket1.send(data)
        unixdatagramsocket2.receive(buf)
        @Expect(data, buf)
        @Expect(dirinfo1.setReadable(true), true)
        @Expect(dirinfo2.setReadable(true), true)
        unlink("./testunixdatagram1/socket1")
        unlink("./testunixdatagram1/socket2")
    }

    @TestCase
    func test_04(): Unit {
        @Assert(exists("./testunixdatagram1"), true)
        @Assert(exists("./testunixdatagram2"), true)
        match (user) {
            case Some("root") => ()
            case _ =>
                var dirinfo1 = FileInfo("./testunixdatagram1")
                @Expect(dirinfo1.setExecutable(false), true)

                var unixdatagramsocket1 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket1")
                try {
                    unixdatagramsocket1.bind()
                } catch (e: SocketException) {
                    @Expect(e.message.contains("Permission denied"))
                    sum += 1
                }
                @Expect(sum, 1)
                @Expect(dirinfo1.setExecutable(true), true)
                unlink("./testunixdatagram1/socket1")
        }
    }

    @TestCase
    func test_05(): Unit {
        @Assert(exists("./testunixdatagram1"), true)
        @Assert(exists("./testunixdatagram2"), true)
        match (user) {
            case Some("root") => ()
            case _ =>
                var unixdatagramsocket1 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket1")
                unixdatagramsocket1.bind()
                var addr1 = unixdatagramsocket1.localAddress
                var unixdatagramsocket2 = UnixDatagramSocket(bindAt: "./testunixdatagram1/socket2")
                unixdatagramsocket2.bind()
                var addr2 = unixdatagramsocket2.localAddress
                var dirinfo1 = FileInfo("./testunixdatagram1")
                @Expect(dirinfo1.setExecutable(false), true)
                try {
                    unixdatagramsocket1.connect(addr2)
                    unixdatagramsocket2.connect(addr1)
                } catch (e: SocketException) {
                    sum += 1
                    @Expect(e.message.contains("Permission denied"))
                }
                @Expect(sum, 1)
                @Expect(dirinfo1.setExecutable(true), true)
                unlink("./testunixdatagram1/socket1")
                unlink("./testunixdatagram1/socket2")
        }
    }
}
