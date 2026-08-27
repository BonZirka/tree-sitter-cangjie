/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %cmp_utest_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

internal import std.{fs.*, net.*, random.Random, process.*}

@Test
class UnixFullQueueTest {
    @TestCase
    func full(): Unit {
        try (server = listen()) {
            try {
                connectLoop(server, count: 10000)
                throw Exception("SocketException should occur")
            } catch (expected: SocketException) {
            }
        }
    }

    @TestCase
    func notFull(): Unit {
        try (server = listen()) {
            connectLoop(server, count: 3)
        }
    }

    private static func listen(): ServerSocket {
        let server = UnixServerSocket(bindAt: createTempFile())
        try {
            server.backlogSize = 10
            server.bind()
            return server
        } catch (cause: Exception) {
            server.close()
            throw cause
        }
    }

    private static func connectLoop(server: ServerSocket, count!: Int64): Unit {
        let connections = Array<?StreamingSocket>(count, repeat: None)
        try {
            for (index in 0..count) {
                connections[index] = connectTo(server)
            }
        } finally {
            for (c in connections) {
                if (let Some(c) <- c) {
                    c.close()
                }
            }
        }
    }

    private static func connectTo(server: ServerSocket): UnixSocket {
        let socket = UnixSocket(server.localAddress)
        try {
            socket.connect(timeout: Duration.second * 5)
        } catch (cause: Exception) {
            socket.close()
            throw cause
        }
        return socket
    }

    private static func createTempFile(): String {
        let tempDir: Path = Process.current.tempDirectory

        let index: String = Random().nextUInt64().toString()

        return tempDir.join("tmp${index}").toString()
    }
}
