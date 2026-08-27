/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./../../asan
// EXEC: %compiler %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC-PIPE-0: %compiler %cmp_opt %f asan.%middle -o %output
// EXEC-PIPE: %run %run_opt %n.%suffix %run_args | compare %f
// ASSERT: scan OK

/*
 * Test description: Test that ticker1.cancel will not cancel ticker2 created after first ticker1.cancel
 * Test API:
 *          public static func after(delay: Duration, task: () -> Option<Duration>): Timer
 */

internal import std.sync.*
internal import std.time.*
internal import std.runtime.*
internal import asan.*

var flag = false

func test() {
    let timer = Timer.after(
        Duration.second * -1,
        {
            =>
            flag = true
            Option<Duration>.None
        }
    )
    sleep(Duration.millisecond * 10)
    timer.cancel()
    if (!flag) {
        return 1
    }
    println("OK")
    0
}

main(): Int64 {
    let ret = test()
    asanGC()
    ret
}
