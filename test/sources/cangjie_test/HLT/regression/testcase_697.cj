/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f


main() : Int64 {
    var numOther = 18446744073709551615
    println(numOther is Int64)
    println(numOther)
    return 0
}
// ASSERT: scan sema_exceed_num_value_range
