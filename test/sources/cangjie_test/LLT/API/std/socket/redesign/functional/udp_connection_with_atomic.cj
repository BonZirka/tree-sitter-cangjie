/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan server received
// ASSERT: scan client address correct

internal import std.net.*
internal import std.time.*
internal import std.sync.*

func runUpdServer(serverPort: AtomicUInt16, clientPort: AtomicUInt16) {
    try (serverSocket = UdpSocket(bindAt: 0)) {
        serverSocket.bind()
        serverPort.store((serverSocket.localAddress as IPSocketAddress)?.port ?? 0)

        let buf = Array<Byte>(3, repeat: 0)

        let (clientAddr, read) = serverSocket.receiveFrom(buf)

        if (read == 3 && buf == [1u8, 2u8, 3u8]) {
            println("server received")
        }
        if (clientAddr.toString() == "127.0.0.1:${clientPort.load()}") {
            println("client address correct")
        }
    }
}

main(): Int64 {
    let serverPort = AtomicUInt16(0)
    let clientPort = AtomicUInt16(0)
    spawn {
        runUpdServer(serverPort, clientPort)
    }
    sleep(Duration.second)

    try (udpSocket = UdpSocket(bindAt: 0)) {
        udpSocket.sendTimeout = Duration.second * 2
        udpSocket.bind()
        udpSocket.connect(IPSocketAddress("127.0.0.1", serverPort.load()))
        clientPort.store((udpSocket.localAddress as IPSocketAddress)?.port ?? 0)

        sleep(Duration.millisecond * 300)

        udpSocket.send([1u8, 2u8, 3u8])

        sleep(Duration.millisecond * 300)
    }
    return 0
}
