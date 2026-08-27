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
import std.unicode.*

main() {
    var input: Tokens = quote(
        var (a,b): (Int32,Rune) = if (a) {b} else {c}
    )
    let expr = parseDecl(input)
    if (expr is VarDecl) {
        var b = match (expr as VarDecl) {
            case Some(v) => v
            case None => throw Exception("Not VarDecl")
        }
        var modifierSize = b.modifiers.size
        var typeExpr = b.keyword.value
        var tp = b.pattern
        var tp0 = match (tp as TuplePattern) {
            case Some(v) => v.patterns[0]
            case None => throw Exception("Not TuplePattern")
        }
        var tp0Expr = match (tp0 as VarPattern) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not VarPattern")
        }
        var tp1 = match (tp as TuplePattern) {
            case Some(v) => v.patterns[1]
            case None => throw Exception("Not TuplePattern")
        }
        var tp1Expr = match (tp1 as VarPattern) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not VarPattern")
        }
        var dt = b.declType
        var dt0 = match (dt as TupleType) {
            case Some(v) => v.types[0]
            case None => throw Exception("Not TupleType")
        }
        var dt0Expr = match (dt0 as PrimitiveType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveType")
        }
        var dt1 = match (dt as TupleType) {
            case Some(v) => v.types[1]
            case None => throw Exception("Not TupleType")
        }
        var dt1Expr = match (dt1 as PrimitiveType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveType")
        }
        var e = b.expr
        var eIf = match (e as IfExpr) {
            case Some(v) => v.condition
            case None => throw Exception("Not IfExpr")
        }
        var eIfExpr = match (eIf as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }
        var eIfBody = match (e as IfExpr) {
            case Some(v) => v.ifBlock
            case None => throw Exception("Not IfExpr")
        }
        var eIfBodyExpr = match (eIfBody as Block) {
            case Some(v) => v.nodes[0]
            case None => throw Exception("Not Block")
        }
        var eIfBodyExprValue = match (eIfBodyExpr as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }
        if (modifierSize != 0 || typeExpr != "var" || tp0Expr != "a" || tp1Expr != "b" || dt0Expr != "Int32" ||
            dt1Expr != "Rune" || eIfExpr != "a" || eIfBodyExprValue != "b") {
            return 1
        }
        return 0
    }
    return 1
}
