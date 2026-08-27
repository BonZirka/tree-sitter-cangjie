/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %run %run_opt %n.%suffix %run_args

internal import std.net.*

main(): Int64 {
    let unixSocket1: UnixSocket = UnixSocket("/tmp/sock123")

    let socketAddres1: SocketAddress = UnixSocketAddress("/tmp/sock1234")
    let unixSocket2: UnixSocket = UnixSocket(socketAddres1)

    try {
        let unixSocket3: UnixSocket = UnixSocket("/tmp/\0sock123")
        return 1
    } catch (e: IllegalArgumentException) {}

    return 0
}
