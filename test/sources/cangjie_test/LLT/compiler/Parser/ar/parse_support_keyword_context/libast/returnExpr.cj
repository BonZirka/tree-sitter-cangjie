// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main(): Int64 {
    let code = "return public"
    let returnExprTokens = cangjieLex(code)
    let returnExpr = (parseExpr(returnExprTokens) as ReturnExpr).getOrThrow()
    let refExpr = (returnExpr.expr as RefExpr).getOrThrow()
    let literalToken = refExpr.identifier
    if (literalToken.value != "public") {
        return -1
    }

    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
