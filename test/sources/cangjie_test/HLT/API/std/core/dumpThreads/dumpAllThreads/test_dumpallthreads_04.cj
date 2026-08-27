/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.unittest.*
import std.unittest.testmacro.*

main(): Unit {
    let beforeThreadCreation = ThreadSnapshot.dumpAllThreads().size
    let _thread = spawn {
        while (true) {
            if (Thread.currentThread.hasPendingCancellation) {
                println("Thread.currentThread.hasPendingCancellation")
                return 0
            }
        }
        return 1
    }
    sleep(Duration.second)
    _thread.cancel()
    sleep(Duration.second)
    // 这里线程被回收无法获取
    let afterThreadCancellation = ThreadSnapshot.dumpAllThreads().size
    @Assert(beforeThreadCreation, afterThreadCancellation)
    @Assert(_thread.thread.state.toString(), "Terminated")
    @Assert(_thread.get(), 0)
}
