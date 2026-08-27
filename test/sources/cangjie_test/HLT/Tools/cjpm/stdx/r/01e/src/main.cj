// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package b

internal import p2.*
import stdx.compress.zlib.*
import std.io.*

main(): Int64 {
    let arr1 = "Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!".toArray()
    let byteBuffer = ByteBuffer(arr1)
    let bufferedInputStream = BufferedInputStream(byteBuffer)
    var compressInputStream: CompressInputStream = CompressInputStream(bufferedInputStream)
    compressInputStream.close()
    println("hello world")
    return 0
}
