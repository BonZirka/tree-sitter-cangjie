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
// ASSERT:scan 10

class SimpleEA {
    public var x: Int32

    public init(a: Int32) {
        x = a
    }
}

main(): Int64 {
    let obj: SimpleEA = SimpleEA(10)
    print(obj.x.toString())

    return 0
}
