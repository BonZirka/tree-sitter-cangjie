/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan result > 300

import std.collection.*
import std.sync.*

let result = AtomicInt64(0)
let futureBuf = ArrayList<Future<Unit>>()

func test(): Unit {
    result.fetchAdd(1)
    if (result.load() <= 300) {
        test()
    }
}

func WaitAllCoroutinesExit(buf: ArrayList<Future<Unit>>) {
    var i: Int64 = 0
    while (i < buf.size) {
        buf.get(i).getOrThrow().get()
        i++
    }
}

main(): Int64 {
    var count: Int64 = 0
    while (count < 300) {
        count = count + 1
        let fut: Future<Unit> = spawn {
            test()
        }
        futureBuf.add(fut)
    }

    while (result.load() <= 300) {
        sleep(Duration.Zero)
    }

    if (result.load() >= 300) {
        print("result > 300\n")
    }

    WaitAllCoroutinesExit(futureBuf)
    return 0
}
