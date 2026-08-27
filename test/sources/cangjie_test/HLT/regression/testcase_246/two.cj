/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
main() {
    let num = 0

    let newNum = if (num == 0) {
        "let x = 1"
    } else {
        "\"仓颉\""
    }
    println(newNum is ToString)
    if (newNum is ToString) {
        return 0
    }
    return 1
}
