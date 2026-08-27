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
internal import std.fs.*

main() {
    var fileName1 = "test_File1.txt"
    var fileName2 = "test_File2.txt"
    var fileName3 = "test_File3.txt"
    var fileName4 = "test_File4.txt"

    var arr = Array<Byte>(256, {i => UInt8(i % 256)})
    File.writeTo(fileName1, arr.slice(0, 100).toArray())
    File.writeTo(fileName2, arr.slice(100, 156).toArray())
    File.writeTo(fileName3, Array<Byte>())

    var file1 = File(fileName1, Read)
    var file2 = File(fileName2, Read)
    var file3 = File(fileName3, Read)
    var fileArr = [file1, file2, file3]

    var chainedInputStream = ChainedInputStream(fileArr)
    var tempArr = Array<Byte>(360, repeat: 0)
    var destFile = File(fileName4, Write)
    while (true) {
        var readNum = chainedInputStream.read(tempArr)
        if (readNum <= 0) {
            break
        }
        destFile.write(tempArr.slice(0, readNum).toArray())
    }

    file1.close()
    file2.close()
    file3.close()
    destFile.close()

    var destFileAllBytes = File.readFrom(fileName4)
    if (destFileAllBytes != arr) {
        return 1
    }

    remove(fileName1)
    remove(fileName2)
    remove(fileName3)
    remove(fileName4)

    println("ok")
    return 0
}
