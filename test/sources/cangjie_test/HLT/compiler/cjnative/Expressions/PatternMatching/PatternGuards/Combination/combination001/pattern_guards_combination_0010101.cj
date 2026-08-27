/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main() {
    var i: Int64 = 1
    let j: Int64 = 1
    var a: Int64 = match (i) {
        case j where (1) => i + 1
        case j where (true) => i
        case _ => 0
    }
    return (a - 1)
}
// ASSERT: scan sema_cannot_convert_literal
