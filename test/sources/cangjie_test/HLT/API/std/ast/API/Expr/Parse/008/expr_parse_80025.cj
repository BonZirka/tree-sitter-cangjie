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

main() {
    var input: Tokens = quote(a?().2=1)
    let expr = parseExpr(input)
    let expr2 = match (expr as CallExpr) {
        case Some(v) => v.callFunc
        case None => throw Exception("Not CallExpr")
    }
    if (!(expr is AssignExpr) || !(expr2 is OptionalExpr)) {
        return 0
    }
    return 3
}
