/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

main() {
    var order01 = Ordering.LT
    var order02 = Ordering.EQ
    var order03 = Ordering.GT
    var order04 = Ordering.LT
    var order05 = Ordering.EQ
    var order06 = Ordering.GT
    var resultActual: Array<Bool> = [order01 <= order05, order02 <= order06, order01 <= order06]
    var resultExpect: Array<Bool> = [true, true, true]
    if (resultActual != resultExpect) {
        return 1
    }
    return 0
}
