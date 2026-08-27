// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args | compare %f
// ASSERT: scan-2 parsing expr error.

internal import std.ast.*

main(): Int64 {
    var cnt = 0

    let tokens1 = quote(
        match {
            case 1 => 1
            case Year(a,b) => 1
            case a : Int64 => 1
            case a == b => 1
            case _ => 1
        }
    )
    try {
        let matchExpr1 = MatchExpr(tokens1)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    let tokens2 = quote(
        match {
            case 1 where a == b => 1
            case a == b => 1
            case _ => 1
        }
    )
    try {
        let matchExpr2 = MatchExpr(tokens2)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    if (cnt != 2) {
        return 1
    }
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
