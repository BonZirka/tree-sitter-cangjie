/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// (not O2) EXEC: %compiler %cmp_opt %f -o %output
// (not O2) RUN-ERRCHECK: %run %run_opt %output %run_args

main(): Int64 {
    let temp = 2
    let a = temp / {=> 0}()
    return 0
}

// ASSERT: scan An exception has occurred:
// ASSERT: scan ArithmeticException: Divided by zero!
