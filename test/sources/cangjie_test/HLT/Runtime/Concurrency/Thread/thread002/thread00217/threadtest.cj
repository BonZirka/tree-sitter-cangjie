/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f

// ASSERT: scan result = 0\n
// ASSERT: scan-not Exception

@OverflowWrapping
main(): Int64 {
    var result: UInt16 = 65535

    let fut: Future<UInt16> = spawn {
        var a: UInt16 = 65535
        return a + 1
    }

    let opt: Option<UInt16> = fut.get(9223372036854775807 * Duration.nanosecond)

    match (opt) {
        case Some(res) => result = res
        case None => print("error\n")
    }

    if (result != 0) {
        return 1
    }

    match (fut.tryGet()) {
        case None => return 1
        case _ => ()
    }

    print("result = ${result}\n")
    return 0
}
