/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan ArithmeticException: Overshift

func cond() {
    var temp = true
    return temp
}

func temp() {
    var res: Int8 = 1
    return res
}

func test() {
    var a: Int8 = 1
    if (cond()) {
        a = temp() + 10
    } else {
        a = temp() + 10
    }
    var b: Int8 = 1 >> a
    return b
}

main() {
    test()
    1
}
