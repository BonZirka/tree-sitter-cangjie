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
public class readByteTest {
    @TestCase
    func readByteTest(): Unit {
        let bs = ByteBuffer()
        let bis = BufferedInputStream<ByteBuffer>(bs)
        @Expect(bis.readByte(), None)
        bs.write("hello,world!".toArray())
        @Expect(bis.length, 12)
        @Expect(bis.remainLength, 12)
        @Expect(bis.position, 0)
        bis.seek(Begin(0))
        @Expect(bis.readByte(), b'h')
    }
}
