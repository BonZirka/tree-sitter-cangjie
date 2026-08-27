/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

func test(a!: Int8 = 100 + 100): Int8 {
    return a
}

main() {
    var res = Int64(test() - 127)
    print("success")
    return res
}
// ASSERT: scan chir_arithmetic_operator_overflow
