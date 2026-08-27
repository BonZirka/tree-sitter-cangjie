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
    let bs = ByteBuffer()
    let sr = StringReader<ByteBuffer>(bs)

    @TestCase
    func seekTest(): Unit {
        @Expect(sr.length, 0)
        @Expect(sr.remainLength, 0)
        @Expect(sr.position, 0)

        bs.write("hello,world!".toArray())
        @Expect(sr.length, 12)
        @Expect(sr.remainLength, 12)
        @Expect(sr.position, 0)

        var str = sr.readToEnd()
        @Expect(str, "hello,world!")
        @Expect(sr.length, 12)
        @Expect(sr.remainLength, 0)
        @Expect(sr.position, 12)

        sr.seek(Current(-6))
        str = sr.readln().getOrThrow()
        @Expect(str, "world!")
        @Expect(sr.length, 12)
        @Expect(sr.remainLength, 0)
        @Expect(sr.position, 12)
    }
}
