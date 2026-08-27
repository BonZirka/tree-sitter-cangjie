/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

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

@When[os == "Windows"]
foreign func _unlink(filename: CPointer<Byte>): Int32

@When[os == "Windows"]
func unlink(filename: String): Int32 {
    unsafe {
        let cph = acquireArrayRawData(filename.rawData())
        let ret = _unlink(cph.pointer)
        releaseArrayRawData(cph)
        return ret
    }
}

var ser = Option<UnixServerSocket>.None
var sum = 0

@Test
class Test_Unix_Incorrect_Invocation {
    public override func beforeEach(): Unit {
        sum = 0
    }

    public override func beforeAll(): Unit {
        if (exists("/tmp/testsocket")) {
            remove("/tmp/testsocket", recursive: true)
        }
        Directory.create("/tmp/testsocket")
    }

    public override func afterAll(): Unit {
        if (exists("/tmp/testsocket")) {
            remove("/tmp/testsocket", recursive: true)
        }
    }

    public override func afterEach(): Unit {
        unlink("/tmp/testsocket/socket")
    }

    func startServer(): Unit {
        var server = UnixServerSocket(bindAt: "/tmp/testsocket/socket")
        server.bind()
        ser = Option<UnixServerSocket>.Some(server)
    }

    @TestCase
    func test_client_no_connect(): Unit {
        var client = UnixSocket("/tmp/testsocket/socket")
        var buf = Array<Byte>(10, repeat: 0)

        startServer()
        try {
            client.readTimeout = Duration.second
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
    func test_client_init(): Unit {
        var client = UnixSocket("/tmp/testsocket/socket")
        var buf = Array<Byte>(10, repeat: 0)

        startServer()
        client.connect()
        try {
            client.readTimeout = Duration.second
            client.read(buf)
        } catch (e: SocketTimeoutException) {
        }
        client.write(buf)
        client.close()
    }
}
