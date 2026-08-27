/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC: %run %run_opt %output %run_args

import std.io.*
import std.fs.*

main() {
    var arr: Array<Byte> = Array<Byte>(10000, {i => UInt8(i % 256)})
    var file = File("init_04.txt", ReadWrite)
    file.write(arr)
    file.close()
    var outputStream = ByteBuffer()
    var inputStream = File("init_04.txt", Read)
    var bufferedInputStream = BufferedInputStream(inputStream)
    var tempBuf = Array<Byte>(1024, repeat: 0)
    while (true) {
        var readNums = bufferedInputStream.read(tempBuf)
        if (readNums == 0) {
            break
        }
        outputStream.write(tempBuf.slice(0, readNums).toArray())
    }

    inputStream.close()
    remove("init_04.txt")
    if (arr != readToEnd(outputStream)) {
        return 1
    }
    return 0
}
