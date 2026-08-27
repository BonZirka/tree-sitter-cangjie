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
class Test_bytebuffer_read_write_01 {
    @TestCase
    func test_bytebuffer_read_write_01(): Unit {
        var bb: ByteBuffer = ByteBuffer(Array<Byte>())
        var bb1: ByteBuffer = ByteBuffer("123cangjie".toArray())
        @Expect(bb.readByte(), Option<Byte>.None)
        bb.writeByte(0)
        @Expect(bb.readByte(), Option<Byte>.Some(0))

        @Expect(bb1.readByte(), Option<Byte>.Some(49))
        bb1.writeByte(0)
        @Expect(bb1.readByte(), Option<Byte>.Some(50))
        @Expect(bb.capacity, 1)
        @Expect(bb1.capacity, 15)
    }

    @TestCase
    func test_bytebuffer_read_write_02(): Unit {
        var bb: ByteBuffer = ByteBuffer(Array<Byte>())
        var bb1: ByteBuffer = ByteBuffer("".toArray())
        @Expect(bb.readByte(), Option<Byte>.None)
        bb.writeByte(255)
        bb.writeByte(128)
        @Expect(bb.readByte(), Option<Byte>.Some(255))
        @Expect(bb.readByte(), Option<Byte>.Some(128))

        @Expect(bb1.readByte(), Option<Byte>.None)
        bb1.writeByte(0)
        @Expect(bb1.readByte(), Option<Byte>.Some(0))
    }

    @TestCase
    func test_bytebuffer_read_write_03(): Unit {
        var bb: ByteBuffer = ByteBuffer(Array<Byte>())
        var bb1: ByteBuffer = ByteBuffer("#".toArray())
        @Expect(bb.readByte(), Option<Byte>.None)
        bb.writeByte(255)
        bb.writeByte(128)
        bb.writeByte(0)
        @Expect(bb.readByte(), Option<Byte>.Some(255))
        @Expect(bb.readByte(), Option<Byte>.Some(128))
        @Expect(bb.readByte(), Option<Byte>.Some(0))

        @Expect(bb1.readByte(), Option<Byte>.Some(35))
        bb1.writeByte(0)
        bb1.writeByte(1)
        bb1.writeByte(255)
        @Expect(bb1.readByte(), Option<Byte>.Some(0))
        @Expect(bb1.readByte(), Option<Byte>.Some(1))
        @Expect(bb1.readByte(), Option<Byte>.Some(255))
    }
}
