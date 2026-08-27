/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// (!(target_mac | target_ohos)) ASSERT: regex OverflowException: mul
// (target_mac | target_ohos) ASSERT: regex StackOverflowError

// The actual result could either be OverflowException or StackOverflowError,
// depends on the stack size, so it's better to fix stack size and make the
// output stable in all aspects

func factorial(n: Int64): Int64 {
    if (n == 1) {
        return 1;
    } else {
        return n * factorial(n - 1)
    }
}

main() {
    var a: Array<Int64> = [65535]
    for (i in a) {
        var varname = factorial(i)
        print("letname + ${i}\n")
    }
    return 0
}
