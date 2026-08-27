/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

main() {
    let arr = ["1", "2", "3", "4", "5"]
    let idx = 6
    if (idx >= 0 && idx < arr.size) {
        println("${arr.get(idx).getOrThrow()}")
    } 
}
