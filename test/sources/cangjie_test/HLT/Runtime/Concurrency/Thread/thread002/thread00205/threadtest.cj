/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f

// ASSERT: scan result = Unit\n
// ASSERT: scan-not Exception

main(): Int64 {
    var result: Unit = ()

    let fut: Future<Unit> = spawn {
        var a: Unit = ()
        return a
    }

    result = fut.get()

    if (result != ()) {
        return 1
    }

    match (fut.tryGet()) {
        case None => return 1
        case _ => ()
    }

    print("result = Unit\n")
    return 0
}
