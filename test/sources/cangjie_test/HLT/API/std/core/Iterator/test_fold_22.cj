/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt -o %output %f %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.collection.*
import std.math.*

@Test
class Test_fold_22 {
    /*
     * Test description:
     *     test the func of fold set the Int and String
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_01(): Unit {
        var emptyArr1: Array<Int64> = Array<Int64>()
        var normalArr1: Array<Int64> = Array<Int64>(10, repeat: 1)
        var foldFunc = {
            val: String, item: Int64 => if (val == "reduce") {
                "${item}"
            } else {
                "${val},${item}"
            }
        }
        @Expect(emptyArr1.iterator().fold<String>("reduce", foldFunc), "reduce")
        @Expect(normalArr1.iterator().fold<String>("reduce1", foldFunc), "reduce1,1,1,1,1,1,1,1,1,1,1")
    }

    /*
     * Test description:
     *     test the func of fold set the Int
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_02(): Unit {
        var emptyArr1: Array<Int64> = Array<Int64>()
        var normalArr1: Array<Int64> = Array<Int64>(10, repeat: 2)
        var foldFunc = {
            val: Int64, item: Int64 => if (val == 0) {
                return val
            } else {
                return item
            }
        }
        @Expect(emptyArr1.iterator().fold<Int64>(0, foldFunc), 0)
        @Expect(normalArr1.iterator().fold<Int64>(1, foldFunc), 2)
    }

    /*
     * Test description:
     *     test the func of fold set the String
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_03(): Unit {
        var emptyArr1: Array<String> = Array<String>()
        var normalArr1: Array<String> = Array<String>(10, repeat: "10")
        var foldFunc = {
            val: String, item: String => if (val == "1") {
                return "${val}"
            } else {
                return "${item}"
            }
        }
        @Expect(emptyArr1.iterator().fold<String>("1", foldFunc), "1")
        @Expect(normalArr1.iterator().fold<String>("2", foldFunc), "10")
    }

    /*
     * Test description:
     *     test the func of fold set the Float
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_04(): Unit {
        var emptyArr1: Array<Float64> = Array<Float64>()
        var normalArr1: Array<Float64> = Array<Float64>(10, repeat: Float64(1.11111))
        var foldFunc = {
            val: Float64, item: Float64 => if (val == Float64(1.1)) {
                return val
            } else {
                return item
            }
        }
        @Expect(emptyArr1.iterator().fold<Float64>(Float64(1.1), foldFunc), Float64(1.1))
        @Expect(normalArr1.iterator().fold<Float64>(Float64(2.1), foldFunc), Float64(1.11111))
    }

    /*
     * Test description:
     *     test the func of fold set the Int boundary value
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_05(): Unit {
        var emptyArr1: Array<Int64> = Array<Int64>()
        var normalArr1: Array<Int64> = Array<Int64>(10, repeat: 2)
        var foldFunc = {
            val: Int64, item: Int64 => if (val == 0) {
                return val
            } else {
                return item
            }
        }
        @Expect(emptyArr1.iterator().fold<Int64>(Int64.Max, foldFunc), Int64.Max)
        @Expect(normalArr1.iterator().fold<Int64>(Int64.Min, foldFunc), 2)
    }

    /*
     * Test description:
     *     test the func of fold set the String special value
     * Test API:
     *     public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
     */
    @TestCase
    func test_fold_06(): Unit {
        let str_long = StringBuilder(r'a', 100000).toString()
        var emptyArr1: Array<String> = Array<String>()
        var normalArr1: Array<String> = Array<String>(10, repeat: "10")
        var foldFunc = {
            val: String, item: String => if (val == "1") {
                return "${val}"
            } else {
                return "${item}"
            }
        }
        @Expect(emptyArr1.iterator().fold<String>("", foldFunc), "")
        @Expect(emptyArr1.iterator().fold<String>("\0", foldFunc), "\0")
        @Expect(emptyArr1.iterator().fold<String>(str_long, foldFunc), str_long)
        @Expect(normalArr1.iterator().fold<String>("", foldFunc), "10")
        @Expect(normalArr1.iterator().fold<String>("\0", foldFunc), "10")
        @Expect(normalArr1.iterator().fold<String>(str_long, foldFunc), "10")
    }
}
