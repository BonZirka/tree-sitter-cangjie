/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %overflow_wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

main(): Int64 {
    var myArray: Array<Int64> = [10]
    myArray = [10, 11, 12, 13, 14, 15]
    if (myArray[5] == 15) {
        return 0
    }
    return 1
}
