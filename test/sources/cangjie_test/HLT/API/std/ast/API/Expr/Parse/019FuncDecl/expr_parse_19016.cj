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
    var input: Tokens = quote(func bar(b!:A=(a,b)){})
    let b = parseDecl(input)
    var expr = match (b as FuncDecl) {
        case Some(v) => v
        case None => throw Exception("Not FuncDecl")
    }
    if (expr.identifier.value != "bar") {
        return 1
    }

    var blockExpr = match (expr.block as Block) {
        case Some(v) => v.nodes
        case None => throw Exception("Not Block")
    }
    if (blockExpr.size != 0) {
        return 2
    }

    var expr0 = match (expr.funcParams[0] as FuncParam) {
        case Some(v) => v
        case None => throw Exception("Not FuncParam")
    }
    if (expr0.identifier.value != "b") {
        return 3
    }

    var value2 = match (expr0.paramType as RefType) {
        case Some(v) => v.identifier.value
        case None => throw Exception("Not RefType")
    }
    if (value2 != "A") {
        return 4
    }

    var expr1 = match (expr0.expr as TupleLiteral) {
        case Some(v) => v.elements
        case None => throw Exception("Not TupleLiteral ")
    }
    var value3 = match (expr1[0] as RefExpr) {
        case Some(v) => v.identifier.value
        case None => throw Exception("Not RefExpr")
    }

    if (value3 != "a") {
        return 5
    }
    return 0
}
