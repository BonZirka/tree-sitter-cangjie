// DEPENDENCE: %n.expect
// EXEC: %compiler %cmp_opt_chir2hlir %coverage_opt %f -o %output
// EXEC: %run %run_opt %output > %n.txt
// EXEC: %diff %n.expect %n.txt

internal import std.ast.*

main(): Int64 {
    let input = quote(
        match (a) {
            case 1 => 1
            case (a,b) => 1
            case a : Int64 => 1
            case X => 1
            case X | Y => 1
            case Year(y, 0) => y * 365 * 24
            case b => 2
            case _ => 1
            case _ where (a) => 1
        }
    )

    let expr = match (parseExpr(input) as MatchExpr) {
        case Some(v) => v
        case None => throw Exception()
    }
    let flag = compareTokens(input, expr.toTokens())
    if (!flag) {
        return 1
    }
    expr.dump()

    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
