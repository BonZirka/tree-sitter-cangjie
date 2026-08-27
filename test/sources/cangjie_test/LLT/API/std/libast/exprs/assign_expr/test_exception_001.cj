// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args | compare %f

internal import std.ast.*

main(): Int64 {
    var cnt = 0
    let tokens1 = quote( 
        a != b
    )
    try {
        let assignExpr1 = AssignExpr(tokens1)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    let tokens2 = quote(
        a++
    )
    try {
        let assignExpr2 = AssignExpr(tokens2)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let assignExpr3 = AssignExpr()
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let assignExpr4 = AssignExpr(quote())
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let assignExpr5 = AssignExpr(quote(a=b))
        assignExpr5.assign.dump()
        assignExpr5.rightExpr = AssignExpr(quote(b=c)).rightExpr
        assignExpr5.rightExpr.dump()
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    println("cnt = ${cnt}")
    return 0
}

/* SCAN-IN
ASTException: Cannot construct the 'AssignExpr' node.
ASTException: Cannot construct the 'AssignExpr' node.
ASTException: 
[31merror[0m: expected expression after '', found '<EOF>'
 [36m==>[0m :1:1:

parsing expr error.
description: assign, token_id: 30, token_literal_value: =, fileID: 1, line: 43, column: 45
RefExpr {
  -identifier: Token {
    value: "c"
    kind: IDENTIFIER
    pos: 45: 52
  }
}
cnt = 3
 */
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
