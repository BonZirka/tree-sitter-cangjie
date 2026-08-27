/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

/*
 * Test description: Test that ticker1.cancel will not cancel ticker2 created after first ticker1.cancel
 * Test API:
 *          public func cancel(): Unit
 */

internal import std.sync.*
internal import std.time.*
internal import std.runtime.*

var counter = 0

main(): Int64 {
    let ticker1 = Timer.repeat(Duration.second * 2, Duration.second * 2, {=> counter += 1})
    ticker1.cancel()
    let ticker2 = Timer.repeat(Duration.second * 2, Duration.second * 2, {=> counter += 2})
    ticker1.cancel()
    sleep(Duration.second * 3)
    if (counter != 2) {
        return 1
    }
    GC()
    sleep(Duration.second)
    return 0
}
