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
    var x: Int64 = 2
    var y: Int64 = 3
    var flag: Bool = true
    var a: Int64 = match (i) {
        case _ where (x - y) => i
    }
    return (a - 1)
}
// ASSERT: scan sema_mismatched_types
