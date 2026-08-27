/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args.

/*
 * Test description: Test the limititation of datagram in UdpSocket
 * Test API: public override func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64)
 *           public override func sendTo(recipient: SocketAddress, payload: Array<Byte>):Unit
 *           public func send(payload: Array<Byte>): Unit
 *           public func receive(buffer: Array<Byte>): Int64
 */

import std.unittest.*
import std.unittest.testmacro.*
import std.net.*
import std.time.*
import std.sync.*

@Test
class Test_Udp_TransPortation_Datagram {
    @TestCase
    func test_datagram_maxsize(): Unit {
        var udpsocket0 = UdpSocket(bindAt: IPSocketAddress(IPv4Address.localhost, 0))
        udpsocket0.bind()
        var addr0 = udpsocket0.localAddress

        var udpsocket1 = UdpSocket(bindAt: IPSocketAddress(IPv4Address.localhost, 0))
        udpsocket1.bind()
        var addr1 = udpsocket1.localAddress

        udpsocket0.connect(addr1)
        udpsocket1.connect(addr0)

        var data = Array<Byte>(65507, repeat: 20)
        var buf = Array<Byte>(65535, repeat: 0)

        udpsocket0.sendBufferSize = 65535
        udpsocket1.receiveBufferSize = 65535
        udpsocket0.send(data)
        var datalen = udpsocket1.receive(buf)
        @Expect(datalen, data.size)

        for (i in 0..data.size) {
            @Expect(buf[i], data[i])
        }

        var sum = 0
        data = Array<Byte>(65508, repeat: 20)
        try {
            udpsocket0.send(data)
        } catch (e: SocketException) {
            sum += 1
        }
        @Expect(sum, 1)

        udpsocket0.close()
        udpsocket1.close()
    }
}
