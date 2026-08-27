/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan `is` and `as` operators cannot be chained

import std.ast.*

main(): Int64 {
    var input: Tokens = quote(a is A as Bool)
    let expr = parseExpr(input)
    if (expr is AsExpr) {
        var b = match (expr as AsExpr) {
            case Some(v) => v
            case None => throw Exception("Not AsExpr")
        }
        var aExpr = match (b.expr as IsExpr) {
            case Some(v) => v.expr
            case None => throw Exception("Not IsExpr")
        }
        var aValue = match (aExpr as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }

        var typeExpr = b.shiftType
        var typeValue = match (typeExpr as PrimitiveTypeExpr) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveTypeExpr")
        }

        if (aValue != "a" || typeValue != "Bool") {
            return 5
        }
        return 0
    }
    return 3
}
