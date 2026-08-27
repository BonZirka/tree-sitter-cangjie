// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main(): Int64 {
    let input = quote(
        derive1 as Base1
    )
    let expr = parseExpr(input)
    if (!(expr is AsExpr)) {
        return 1
    }
    let input1 = quote(
        1 is Int64
    )
    let expr1 = parseExpr(input1)
    if (expr1 is AsExpr) {
        return 2
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
