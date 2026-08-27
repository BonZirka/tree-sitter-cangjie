/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %n.%suffix %run_args | compare %f
// ASSERT: scan ok

internal import std.io.*

main() {
    var arr = Array<Byte>(8192, {i => UInt8(i % 256)})
    var inputStream = ByteBuffer()
    inputStream.write(arr)

    var tempBuf = Array<Byte>(1024, repeat: 0)

    var outputStream1 = ByteBuffer()
    var bufferedInputStream = BufferedInputStream(inputStream, 10000)
    while (true) {
        var readNums = bufferedInputStream.read(tempBuf)
        if (readNums == 0) {
            break
        }
        outputStream1.write(tempBuf.slice(0, readNums).toArray())
    }

    if (arr != readToEnd(outputStream1)) {
        return 1
    }
    println("ok")
    return 0
}
