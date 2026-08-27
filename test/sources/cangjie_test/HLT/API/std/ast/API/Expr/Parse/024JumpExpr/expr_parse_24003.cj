/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.ast.*

main(): Int64 {
    var input: Tokens = quote(break)
    let expr = parseExpr(input)
    var jumpExpr = match (expr as JumpExpr) {
        case Some(v) => v.keyword.value
        case None => throw Exception("Not JumpExpr")
    }
    if (jumpExpr == "break") {
        return 0
    }
    return 1
}
