/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan 0

import std.sync.*
import std.runtime.*
import std.argopt.*
import std.process

class EndTry {
    public func test(i: Int32): Unit {
        var mtx: ReentrantMutex = ReentrantMutex()
        synchronized(mtx) {
            try {
                var j: Int32 = 10 / i
            } catch (e: Exception) {
            }
        }
    }

    public static func TestMain(c: Int32): Int32 {
        var hello: EndTry = EndTry()
        hello.test(0)
        return 0
    }
}

main(): Int64 {
    print(EndTry.TestMain(0))
    let ao = ArgOpt(process.Process.current.arguments, "", ["asan"])
    let map = ao.getArgumentsMap()
    if (map.contains("--asan")) {
        GC()
        sleep(Duration.second * 2)
    }
    return 0
}
