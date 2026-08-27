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
    var input: Tokens = quote([a,b,c] is A)
    let expr = parseExpr(input)
    if (expr is IsExpr) {
        var b = match (expr as IsExpr) {
            case Some(v) => v
            case None => throw Exception("Not IsExpr")
        }
        var aExpr = match (b.expr as ArrayLiteral) {
            case Some(v) => v.elements
            case None => throw Exception("Not ArrayLiteral")
        }
        var aValue = match (aExpr[0] as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }

        var typeExpr = b.shiftType
        var typeValue = match (typeExpr as RefType) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefType")
        }

        if (aValue != "a" || typeValue != "A") {
            return 5
        }
        return 0
    }
    return 3
}
