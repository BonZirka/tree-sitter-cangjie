/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan expected operator or end of expression, found ':'

import std.ast.*

main() {
    var input: Tokens = quote(return 0..return 1:return 2)
    let expr = parseExpr(input)
    if (expr is RangeExpr) {
        return 0
    }
    return 1
    return 0
}
