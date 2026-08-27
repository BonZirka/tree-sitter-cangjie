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
internal import std.fs.*
internal import std.random.*
internal import std.process.*

func createTempFile(): String {
    let tempDir: Path = Process.current.tempDirectory

    let index: String = Random().nextUInt64().toString()

    return tempDir.join("tmp${index}").toString()
}

main(): Int64 {
    let serverSocket = UnixServerSocket(bindAt: createTempFile())

    serverSocket.close()
    try {
        serverSocket.backlogSize = 11
    } catch (e: SocketException) {
        return 0
    }

    return 100
}
