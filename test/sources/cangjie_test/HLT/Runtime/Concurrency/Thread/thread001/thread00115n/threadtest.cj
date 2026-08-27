/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

var sum: Int32 = 0

func add(): Unit {
    sum = sum + 1
}

main(): Int64 {
    print("This is main\n")
    let fut1: Future<Unit> = spawn {
        let time1: Int32 = 1000000000
        sleep(Duration.nanosecond * time1)
        add()
    }
    let time2: UInt64 = 2000000000
    sleep(Duration.nanosecond * time2)
    if (sum != 1) {
        return 1
    }
    return 0
}
// ASSERT: scan sema_invalid_binary_expr
