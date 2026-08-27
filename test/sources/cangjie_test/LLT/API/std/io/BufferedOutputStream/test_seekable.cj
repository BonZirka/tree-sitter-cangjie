/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC:  %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC: %run %run_opt %output %run_utest_opt
import std.io.*

@Test
public class SeekAbleTest {
    let buffer = Array<Byte>(32, repeat: 50)
    @TestCase
    func seekTest(): Unit {
        let bs = ByteBuffer()
        let bos = BufferedOutputStream<ByteBuffer>(bs)
        bos.write("hello,".toArray())
        @Expect(bos.length, 0)
        @Expect(bos.remainLength, 0)
        @Expect(bos.position, 0)

        var index = bos.seek(Current(0))
        @Expect(index, 0)
        @Expect(bos.length, 6)
        @Expect(bos.remainLength, 6)
        @Expect(bos.position, 0)

        bos.write("world!".toArray())
        bos.flush()
        @Expect(bos.length, 12)
        @Expect(bos.remainLength, 12)
        @Expect(bos.position, 0)

        var arr = readToEnd(bs)
        @Expect(String.fromUtf8(arr), "hello,world!")

        index = bos.seek(Begin(0))
        @Expect(index, 0)
        @Expect(bos.length, 12)
        @Expect(bos.remainLength, 12)
        @Expect(bos.position, 0)
        arr = readToEnd(bs)
        @Expect(String.fromUtf8(arr), "hello,world!")
    }

    @TestCase
    func seekTest_reusebuffer(): Unit {
        let bs = ByteBuffer()
        let bos = BufferedOutputStream<ByteBuffer>(bs, buffer)
        bos.write("hello,".toArray())
        @Expect(bos.length, 0)
        @Expect(bos.remainLength, 0)
        @Expect(bos.position, 0)

        var index = bos.seek(Current(0))
        @Expect(index, 0)
        @Expect(bos.length, 6)
        @Expect(bos.remainLength, 6)
        @Expect(bos.position, 0)

        bos.write("world!".toArray())
        bos.flush()
        @Expect(bos.length, 12)
        @Expect(bos.remainLength, 12)
        @Expect(bos.position, 0)

        var arr = readToEnd(bs)
        @Expect(String.fromUtf8(arr), "hello,world!")

        index = bos.seek(Begin(0))
        @Expect(index, 0)
        @Expect(bos.length, 12)
        @Expect(bos.remainLength, 12)
        @Expect(bos.position, 0)
        arr = readToEnd(bs)
        @Expect(String.fromUtf8(arr), "hello,world!")
    }
}
