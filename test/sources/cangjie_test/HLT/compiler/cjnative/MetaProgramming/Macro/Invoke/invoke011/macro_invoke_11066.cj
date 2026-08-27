/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE:  define.cj
// EXEC: %compiler %cmp_macro define.cj
// EXEC: %run_macro %compiler %cmp_opt  %f -o %output 2>&1 | compare %f

import define.*

main() {
    3 - @X[0](@X[0](0) + @D[0]var z = 0 + @B var y = 0 + @A(0))
}
// ASSERT: scan parse_expected_expression
