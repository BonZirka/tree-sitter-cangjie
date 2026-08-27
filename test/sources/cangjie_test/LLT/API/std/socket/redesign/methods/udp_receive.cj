/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_args

internal import std.net.*
internal import std.time.*
internal import std.sync.*

func runUpdServer(serverPort: AtomicUInt16, clientPort: AtomicUInt16) {
    try (serverSocket = UdpSocket(bindAt: 0)) {
        serverSocket.bind()
        serverPort.store((serverSocket.localAddress as IPSocketAddress)?.port ?? 0)

        sleep(Duration.millisecond * 1000)
        println(IPSocketAddress("127.0.0.1", clientPort.load()))
        serverSocket.sendTo(
            IPSocketAddress("127.0.0.1", clientPort.load()),
            [1u8, 2u8, 3u8]
        )
    }
}

main(): Int64 {
    let serverPort = AtomicUInt16(0)
    let clientPort = AtomicUInt16(0)
    spawn {
        runUpdServer(serverPort, clientPort)
    }

    try (udpSocket = UdpSocket(bindAt: 0)) {
        udpSocket.bind()
        udpSocket.receiveTimeout = Duration.second * 2
        sleep(Duration.millisecond * 500)
        udpSocket.connect(IPSocketAddress("127.0.0.1", serverPort.load()))
        clientPort.store((udpSocket.localAddress as IPSocketAddress)?.port ?? 0)

        let buf = Array<Byte>(3, repeat: 0)
        let read = udpSocket.receive(buf)
        if (read != 3 || buf != [1u8, 2u8, 3u8]) {
            return 2
        }
    }
    return 0
}
