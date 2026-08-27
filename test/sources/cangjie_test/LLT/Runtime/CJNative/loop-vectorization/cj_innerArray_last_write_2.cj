// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.collection.*

class Test {
    var a = 3
    var b = 4
}

func test0(): Int16 {
    var a: Array<Int16> = Array<Int16>(10000) {i => Int16(2 * i)}
    var b: Array<Int16> = Array<Int16>(10000) {i => Int16(3 * i)}
    var c: Array<Int16> = Array<Int16>(10000) {i => Int16(2 * i + 3)}
    var d = Test()
    var outterLoopCnt = 10
    var sum: Array<Int16> = Array<Int16>(outterLoopCnt) {i => Int16(0)}
    while (outterLoopCnt > 0) {
        outterLoopCnt--
        for (i in 0..a.size) {
            d.a = 3
            a[i] = b[i] + c[i]
            d.a = 4
            a[i] *= 2
            d.a = i
        }

        for (i in 0..a.size) {
            sum[Int64(outterLoopCnt)] += a[i] / 5 + Int16(outterLoopCnt)
        }
        println(sum[Int64(outterLoopCnt)])
        println(d.a)
    }
    if (sum[9] != -21415 || sum[8] != -31415 || sum[7] != 24121 || sum[6] != 14121 || sum[5] != 4121 || sum[4] != -5879 ||
        sum[3] != -15879 || sum[2] != -25879 || sum[1] != 29657 || sum[0] != 19657) {
        return 1
    }
    return 0
}

main() {
    var result0 = test0()
    if (result0 != 0) {
        return 1
    }
    return 0
}
