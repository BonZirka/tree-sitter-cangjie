/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt  -o %output %f %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.collection.concurrent.*
import std.collection.*
import std.time.*

var sum = 0

@Test
class Test_arrayblockqueue_tryenqueue_05 {
    public override func beforeEach(): Unit {
        sum = 0
    }

    @TestCase
    func test_int_tryenqueue_different_elements_01(): Unit {
        var arrayqueue = ArrayBlockingQueue<Int64>(10000)
        @Expect(arrayqueue.size, 0)

        for (i in 0..20000) {
            if (i <= 9999) {
                @Expect(arrayqueue.tryEnqueue(i + 1), true)
            } else {
                @Expect(arrayqueue.tryEnqueue(i), false)
            }
        }
        @Expect(arrayqueue.size, 10000)
    }

    @TestCase
    func test_int_tryenqueue_same_elements_02(): Unit {
        var arrayqueue = ArrayBlockingQueue<Int64>(10000)
        @Expect(arrayqueue.size, 0)

        for (i in 0..20000) {
            if (i <= 9999) {
                @Expect(arrayqueue.tryEnqueue(1), true)
            } else {
                @Expect(arrayqueue.tryEnqueue(1), false)
            }
        }
        @Expect(arrayqueue.size, 10000)
    }

    @TestCase
    func test_string_dequeue_different_elements_03(): Unit {
        var arrayqueue = ArrayBlockingQueue<String>(10000)
        @Expect(arrayqueue.size, 0)

        for (i in 0..20000) {
            if (i <= 9999) {
                @Expect(arrayqueue.tryEnqueue("${i + 1}"), true)
            } else {
                @Expect(arrayqueue.tryEnqueue("${i + 1}"), false)
            }
        }
        @Expect(arrayqueue.size, 10000)
    }

    @TestCase
    func test_string_dequeue_same_elements_04(): Unit {
        var arrayqueue = ArrayBlockingQueue<String>(10000)
        @Expect(arrayqueue.size, 0)
        for (i in 0..20000) {
            if (i <= 9999) {
                @Expect(arrayqueue.tryEnqueue("1"), true)
            } else {
                @Expect(arrayqueue.tryEnqueue("1"), false)
            }
        }
        @Expect(arrayqueue.size, 10000)
    }
}
