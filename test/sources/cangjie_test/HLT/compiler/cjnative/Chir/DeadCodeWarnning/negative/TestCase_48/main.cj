/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Level: 1
// Description:
// range variable not unused.

// DEPENDENCE: main.cj
// EXEC-PIPE: %compiler main.cj %cmp_opt 2>&1 | compare %f
// ASSERT: scan-not chir_dce_unused_variable

package package_a

main(): Unit {
    let variable: Int64 = 2i64
    for (_ in variable + 1i64..variable : variable + 1i64) {
        break
    }
}
