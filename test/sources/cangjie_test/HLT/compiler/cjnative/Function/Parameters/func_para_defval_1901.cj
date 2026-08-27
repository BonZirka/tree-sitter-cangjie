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

main(): Int64 {
    return run()
}

func run(): Int64 {
    var res = Foo(1, B: "ab", b: "x", A: 4)
    if (res == "5xab") {
        return 0
    }
    return 1
}

func Foo(a: Int64, b!: String, A!: Int64 = 2, B!: String = "yz"): String {
    return (a + A).toString() + b + B
}
