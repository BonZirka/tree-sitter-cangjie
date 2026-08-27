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
    var input: Tokens = quote(
        try {
            ();(1,2,3);[4,5,6];[a,b]
        } catch(e: RunTime) {
            ();(1,2,3);[4,5,6];[a,b]
        } finally {
            ();(1,2,3);[4,5,6];[a,b]
        }
    )
    let expr = parseExpr(input)
    if (expr is TryExpr) {
        var b = match (expr as TryExpr) {
            case Some(v) => v
            case None => throw Exception("Not TryExpr")
        }

        var tryBlock = match (b.tryBlock as Block) {
            case Some(v) => v.nodes
            case None => throw Exception("Not Block")
        }
        if (!(tryBlock[0] is LitConstExpr)) {
            return 2
        }

        var tb0 = match (tryBlock[0] as LitConstExpr) {
            case Some(v) => v.literal.kind
            case None => throw Exception("Not LitConstExpr")
        }
        if (tb0 != UNIT_LITERAL) {
            return 3
        }

        if (!(b.catchPatterns[0] is ExceptTypePattern)) {
            return 4
        }

        var catchPattern = match (b.catchPatterns[0] as ExceptTypePattern) {
            case Some(v) => v.types
            case None => throw Exception("Not ExceptTypePattern")
        }
        var runValue = match (catchPattern[0] as RefType) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefType")
        }
        if (runValue != "RunTime") {
            return 5
        }

        var catchBlock0 = match (b.catchBlocks[0] as Block) {
            case Some(v) => v.nodes
            case None => throw Exception("Not Block")
        }
        var catchBlock01 = match (catchBlock0[1] as TupleLiteral) {
            case Some(v) => v.elements
            case None => throw Exception("Not TupleLiteral")
        }
        var bValue = match (catchBlock01[0] as LitConstExpr) {
            case Some(v) => v.literal.value
            case None => throw Exception("Not LitConstExpr")
        }
        if (bValue != "1") {
            return 6
        }

        var finalBlock = match (b.finallyBlock as Block) {
            case Some(v) => v.nodes
            case None => throw Exception("Not Block")
        }
        var eExpr = match (finalBlock[3] as ArrayLiteral) {
            case Some(v) => v.elements
            case None => throw Exception("Not ArrayLiteral")
        }
        var bValue1 = match (eExpr[1] as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }
        if (bValue1 != "b") {
            return 7
        }
        return 0
    }
    return 1
}
