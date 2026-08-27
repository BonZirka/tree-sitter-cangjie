// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args | compare %f

internal import std.ast.*
internal import std.collection.*

main(): Int64 {
    var cnt = 0
    let tokens1 = quote( 
        (1 23 a)
    )
    try {
        let tupleLiteral1 = TupleLiteral(tokens1)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    let tokens2 = quote(
        call(1,2,3)
    )
    try {
        let tupleLiteral2 = TupleLiteral(tokens2)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let tupleLiteral3 = TupleLiteral()
        println(tupleLiteral3.toTokens().size)
        tupleLiteral3.elements = ArrayList<Expr>([RefExpr(quote(a)), RefExpr(quote(b))])
        println(tupleLiteral3.toTokens())
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let tupleLiteral4 = TupleLiteral(quote())
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let tupleLiteral5 = TupleLiteral(quote((1,2,3)))
        let tupleLiteral55 = TupleLiteral(quote((1,2)))
        tupleLiteral5.elements = tupleLiteral55.elements
        println(tupleLiteral5.elements.size)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let tupleLiteral6 = TupleLiteral(quote((1,2,3)))
        tupleLiteral6.lParen.dump()
        tupleLiteral6.lParen = Token(AND)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let tupleLiteral7 = TupleLiteral(quote((1,2,3)))
        tupleLiteral7.rParen.dump()
        tupleLiteral7.rParen = Token(AND)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    println("cnt = ${cnt}")
    return 0
}

/* SCAN-IN
ASTException: 
[31merror[0m: unclosed delimiter: '('
  [36m| [0m
  [36m| [0m(1 23 a)[0m
  [36m| [0m[36m~[0m [31m^ expected ')' here[0m
  [36m| [0m[36m|[0m
  [36m| [0m[36mto match this opening '('[0m
  [36m| [0m

parsing expr error.
ASTException: Cannot construct the 'TupleLiteral' node.
2
(a, b)
ASTException: 
[31merror[0m: expected expression after '', found '<EOF>'
 [36m==>[0m :1:1:

parsing expr error.
2
description: l_paren, token_id: 2, token_literal_value: (, fileID: 1, line: 57, column: 48
ASTException: Illegal TokenKind, TokenKind should be LPAREN
description: r_paren, token_id: 3, token_literal_value: ), fileID: 1, line: 66, column: 54
ASTException: Illegal TokenKind, TokenKind should be RPAREN
cnt = 5
 */
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
