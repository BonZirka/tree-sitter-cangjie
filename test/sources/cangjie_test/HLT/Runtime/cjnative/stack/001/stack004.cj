/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// (not MAC and not O2) EXEC: %compiler %cmp_opt %f -o %output
// (not MAC and not O2) RUN-EXEC-PIPE: %export cjStackSize=1GB && %export CJ_SOF_SIZE=-5 && %run %run_opt %output %run_args 2>&1 | compare %f

// ASSERT: scan-begin An exception has occurred
// ASSERT: scan-after StackOverflowError
// ASSERT: scan-after ... Some frames are not displayed ...
// ASSERT: scan-after at default.my_test_func
// ASSERT: scan-after at default.my_test_func
// ASSERT: scan-after at default.my_test_func
// ASSERT: scan-after at default.my_test_func
// ASSERT: scan-after at default.main

func my_test_func(x: Int64): Unit {
    my_test_func(x + 1)
}

main() {
    try {
        my_test_func(0)
    } catch (e: StackOverflowError) {
        e.printStackTrace()
    }
    return
}
