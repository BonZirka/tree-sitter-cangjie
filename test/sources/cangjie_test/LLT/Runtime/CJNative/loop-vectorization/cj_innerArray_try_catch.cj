// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 

import std.collection.*

func test0(): Int32 {
    var a: Array<Int32> = Array<Int32>(10000) {i => Int32(2 * i)}
    var b: Array<Int32> = Array<Int32>(10000) {i => Int32(3 * i)}
    var c: Array<Int32> = Array<Int32>(10000) {i => Int32(2 * i + 3)}
    var outterLoopCnt = 10
    var sum: Array<Int32> = Array<Int32>(outterLoopCnt) {i => Int32(0)}
    while (outterLoopCnt > 0) {
        outterLoopCnt--
        try {
            for (i in 0..a.size) {
                a[i] = b[i] + c[i]
            }
        } catch (_) {
            println("catch")
        }
        try {
            for (i in 0..a.size) {
                sum[Int64(outterLoopCnt)] += a[i] / 5 + Int32(outterLoopCnt)
            }
        } catch (_) {
            println("catch-2")
        }

        println(sum[Int64(outterLoopCnt)])
    }
    if (sum[9] != 50085000 || sum[8] != 50075000 || sum[7] != 50065000 || sum[6] != 50055000 || sum[5] != 50045000 ||
        sum[4] != 50035000 || sum[3] != 50025000 || sum[2] != 50015000 || sum[1] != 50005000 || sum[0] != 49995000) {
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
