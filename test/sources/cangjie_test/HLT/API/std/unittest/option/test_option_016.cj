/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC-PIPE: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// RUN-EXEC-1: %run %run_opt %output %run_utest_opt %run_args

import std.argopt.*
import std.unittest.*
import std.unittest.testmacro.*

func getArr(a: Int16, b: Int16, c: Int16): Array<Int16> {
    var arr: Array<Int16> = [a, b, c]
    return arr
}

@Test
class TestA {
    @TestCase
    func caseA01(): Unit {
        var args1: Array<Int16> = [1i16, 2i16, 3i16]
        @Expect(getArr(1, 2, 3), args1)
    }
}

@Test
class TestB {
    @TestCase
    func caseB01(): Unit {
        var args1: Array<Int16> = [1i16, 2i16, 3i16]
        @Expect(getArr(4, 5, 6), args1)
    }
}

func case03(): Unit {
    var args1: Array<Int16> = [1i16, 2i16, 3i16]
    @Expect(getArr(4, 5, 6), args1)
}

func case04(): Unit {
    var args1: Array<Int16> = [1i16, 2i16, 3i16]
    @Expect(getArr(4, 5, 6), args1)
}
