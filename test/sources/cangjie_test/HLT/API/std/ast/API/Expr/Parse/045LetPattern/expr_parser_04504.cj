/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.ast.*

main() {
    var a = quote(let _ <- 1)
    var b = parseExpr(a)
    if (!(b is LetPatternExpr)) {
        return 1
    }
    var res = match (b as LetPatternExpr) {
        case Some(v) => v
        case None => throw Exception("Not LetPatternExpr")
    }
    if (!(res is LetPatternExpr)) {
        return 2
    }
    return 0
}
