/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args 
import std.io.*

@Test
class Test_bufferoutputstream_writebyte_01 {
    @TestCase
    func test_bufferinputstream_readbyte_01(): Unit {
        var bb: ByteBuffer = ByteBuffer()
        var bs = BufferedOutputStream(bb)
        bs.writeByte(33)
        bs.flush()
        var arr = readToEnd(bb)
        @Expect(String.fromUtf8(arr), "!")
    }

    @TestCase
    func test_bufferinputstream_readbyte_02(): Unit {
        var bb: ByteBuffer = ByteBuffer()
        var bs = BufferedOutputStream(bb)
        bs.writeByte(33)
        bs.writeByte(33)
        bs.flush()
        var arr = readToEnd(bb)
        @Expect(String.fromUtf8(arr), "!!")
    }

    @TestCase
    func test_bufferinputstream_readbyte_03(): Unit {
        var bb: ByteBuffer = ByteBuffer()
        var bs = BufferedOutputStream(bb)
        bs.writeByte(33)
        bs.writeByte(126)
        bs.writeByte(b'z')
        bs.flush()
        var arr = readToEnd(bb)
        @Expect(String.fromUtf8(arr), "!~z")
    }
}
