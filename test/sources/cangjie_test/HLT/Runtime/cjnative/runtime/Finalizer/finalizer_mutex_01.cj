/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_arg

import std.runtime.*
import std.sync.*

let gMutex = Mutex()
let gCond = synchronized(gMutex) { gMutex.condition() }
var gReady: Bool = false

class FinalizerDemo {
    init() {}

    ~init() {
        synchronized(gMutex) {
            while (!gReady) {
                gCond.wait()
            }
        }
    }
}

func createFinalizerDemo(): Unit {
    let demo = FinalizerDemo()
    blackBox(demo)
}

main() {
    let notifier = spawn {
        sleep(500 * Duration.millisecond)
        synchronized(gMutex) {
            gReady = true
            gCond.notifyAll()
        }
    }

    createFinalizerDemo()
    gc(heavy: true)
    notifier.get()
    sleep(200 * Duration.millisecond)
}

