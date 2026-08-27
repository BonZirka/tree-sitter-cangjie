/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: scan finally!success

class A <: Exception {}

class B <: Exception {}

func test() {
    var i = 0
    while (i != 10) {
        i++
        try {
            break
        } finally {
            print("finally!")
        }
    }
    return 10
}

main() {
    var res = test()
    print("success, ${res}\n")
    return res - 10
}
