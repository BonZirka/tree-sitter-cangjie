/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.sync.{ReentrantReadWriteMutex, ReadWriteMutexMode}

let r2 = false
let r3 = false

main(): Int64 {
    let x: Int64 = 0
    let rwm = ReentrantReadWriteMutex(mode: Fair)

    let res1 = spawn {
        rwm.writeMutex.lock()
    }.get()

    let res2 = spawn {
        rwm.writeMutex.tryLock()
    }
    if (r2) {
        return 1
    }

    let res3 = spawn {
        rwm.readMutex.tryLock()
    }
    if (r3) {
        return 1
    }
    return 0
}
