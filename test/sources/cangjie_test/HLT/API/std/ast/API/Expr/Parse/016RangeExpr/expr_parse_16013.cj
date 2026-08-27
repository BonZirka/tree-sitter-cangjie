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
    var input: Tokens = quote(a(){=>1}..b(){=>d}:c(){=>3})
    let expr = parseExpr(input)
    if (expr is RangeExpr) {
        var b = match (expr as RangeExpr) {
            case Some(v) => v
            case None => throw Exception("Not RangeExpr")
        }
        var startExpr = match (b.start as TrailingClosureExpr) {
            case Some(v) => v.expr
            case None => throw Exception("Not TrailingClosureExpr")
        }

        var startExpr1 = match (startExpr as CallExpr) {
            case Some(v) => v.callFunc
            case None => throw Exception("Not CallExpr")
        }

        var aValue = match (startExpr1 as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }

        var endExpr = match (b.end as TrailingClosureExpr) {
            case Some(v) => v.lambdaExpr
            case None => throw Exception("Not TrailingClosureExpr")
        }

        var endExpr1 = match (endExpr as LambdaExpr) {
            case Some(v) => v
            case None => throw Exception("Not LambdaExpr")
        }

        var nodesArray1 = endExpr1.nodes
        var bValue1 = ""
        for (i in nodesArray1) {
            var value = match (i as RefExpr) {
                case Some(v) => v.identifier.value
                case None => throw Exception("Not RefExpr")
            }
            bValue1 = bValue1 + value
        }

        var stepExpr = match (b.step as TrailingClosureExpr) {
            case Some(v) => v.expr
            case None => throw Exception("Not TrailingClosureExpr")
        }

        var stepExpr1 = match (stepExpr as CallExpr) {
            case Some(v) => v.callFunc
            case None => throw Exception("Not CallExpr")
        }

        var cValue = match (stepExpr1 as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }

        if (aValue != "a" || bValue1 != "d" || cValue != "c") {
            return 1
        }
        return 0
    }
    return 5
}
