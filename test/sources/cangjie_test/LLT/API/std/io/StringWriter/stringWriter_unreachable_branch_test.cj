/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %n.%suffix %f
// EXEC: %run %run_opt %n.%suffix %run_args

/*
 * Test Test description:This test case is designed to test the hard-to-reach branches of the code.
 * Test API: public func write(v: UInt64): Unit
 */

internal import std.io.*
internal import std.fs.*

main() {
    var bas = ByteBuffer()
    var stringWriter = StringWriter(bas)
    var v: UInt64 = 21
    for (i in 0..2048) {
        stringWriter.write(v)
    }
    var buff = Array<Byte>(2, repeat: 0)
    bas.read(buff)
    if (String.fromUtf8(buff) != "21") {
        return -1
    }

    return 0
}
