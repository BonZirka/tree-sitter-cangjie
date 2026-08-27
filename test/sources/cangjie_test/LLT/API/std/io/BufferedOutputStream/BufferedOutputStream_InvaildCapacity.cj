/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %n.%suffix %run_args | compare %f
// ASSERT: scan IllegalArgumentException: Invalid capacity size: capacity = 0.
// ASSERT: scan IllegalArgumentException: Invalid capacity size: capacity = -1.
// ASSERT: scan ok

internal import std.io.*

main() {
    var outputStream = ByteBuffer()

    try {
        var bufferedOutputStream = BufferedOutputStream(outputStream, 0)
    } catch (e: IllegalArgumentException) {
        println(e)
    }

    try {
        var bufferedOutputStream = BufferedOutputStream(outputStream, -1)
    } catch (e: IllegalArgumentException) {
        println(e)
    }

    println("ok")
    return 0
}
