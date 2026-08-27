/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.unittest.*
import std.unittest.testmacro.*
import std.net.*
import std.time.*

var data = Array<Byte>(5000, repeat: 10)
@When[os == "Windows"]
var localBindAddress = "127.0.0.1"
@When[os != "Windows"]
var localBindAddress = "0.0.0.0"
let localSA: SocketAddress = IPSocketAddress("127.0.0.1", 0)
let localBindSA: SocketAddress = IPSocketAddress(localBindAddress, 0)

/*
This test covers update of address 0.0.0.0 -> 127.0.0.1 what is not applicable on windows as
connections to 0.0.0.0 are prohibited.
 */
@Test
class Test_Udp_Address {
    @TestCase
    func test_not_connect(): Unit {
        var udpsocket = UdpSocket(bindAt: localSA)
        var udpsocket1 = UdpSocket(bindAt: localBindSA)
        @Expect(udpsocket.localAddress, localSA)
        @Expect(udpsocket1.localAddress, localBindSA)
        var sum = 0
        try {
            udpsocket.remoteAddress
        } catch (e: SocketException) {
            sum += 1
        }
        try {
            udpsocket1.remoteAddress
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 2)
        udpsocket.bind()
        udpsocket1.bind()
        var addr = udpsocket.localAddress
        var addr1 = udpsocket1.localAddress
        try {
            udpsocket.remoteAddress
        } catch (e: SocketException) {
            sum += 1
        }
        try {
            udpsocket1.remoteAddress
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 4)

        udpsocket.close()
        udpsocket1.close()
    }

    @TestCase
    func test_connect(): Unit {
        var udpsocket = UdpSocket(bindAt: localSA)
        var udpsocket1 = UdpSocket(bindAt: localBindSA)
        @Expect(udpsocket.localAddress, localSA)
        @Expect(udpsocket1.localAddress, localBindSA)

        udpsocket.bind()
        udpsocket1.bind()
        var addr = udpsocket.localAddress as IPSocketAddress ?? throw SocketException("invalid localAddress")
        var addr1 = udpsocket1.localAddress as IPSocketAddress ?? throw SocketException("invalid localAddress")

        udpsocket1.connect(addr)
        udpsocket.connect(addr1)

        let sa: SocketAddress = IPSocketAddress("127.0.0.1", addr.port)
        let sa1: SocketAddress = IPSocketAddress("127.0.0.1", addr1.port)

        @Expect(udpsocket.localAddress, sa)
        @Expect(udpsocket1.localAddress, sa1)
        @Expect(udpsocket.remoteAddress, sa1)
        @Expect(udpsocket1.remoteAddress, sa)

        udpsocket.close()
        udpsocket1.close()
    }

    @TestCase
    func test_tcp_connect(): Unit {
        let tcpserver = TcpServerSocket(bindAt: localBindSA)
        @Expect(tcpserver.localAddress, localBindSA)
        tcpserver.bind()
        var saddr = tcpserver.localAddress as IPSocketAddress ?? throw SocketException("invalid localAddress")

        let tmp = spawn {tcpserver.accept()}
        var udpsocket1 = TcpSocket(IPSocketAddress(localBindAddress, saddr.port))
        udpsocket1.connect()
        var udpsocket = tmp.get()
        let addr = udpsocket.localAddress as IPSocketAddress ?? throw SocketException("invalid localAddress")
        let addr1 = udpsocket1.localAddress as IPSocketAddress ?? throw SocketException("invalid localAddress")

        let sa: SocketAddress = IPSocketAddress("127.0.0.1", addr.port)
        let sa1: SocketAddress = IPSocketAddress("127.0.0.1", addr1.port)

        @Expect(udpsocket.localAddress, sa)
        @Expect(udpsocket1.localAddress, sa1)
        @Expect(udpsocket.remoteAddress, sa1)
        @Expect(udpsocket1.remoteAddress, sa)

        udpsocket.close()
        udpsocket1.close()
    }
}
