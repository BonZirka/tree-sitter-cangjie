/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


main(): Int64 {
    var i: Int32 = 5
    i++  // i = 6
    i--  // i = 5
    i--++
    let j = 0
    j = i--  
    return 0
     
}
// ASSERT: scan parse_invalid_incre_expr
