// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args | compare %f

internal import std.ast.*

main(): Int64 {
    var cnt = 0
    let tokens1 = quote( 
        f { -> i * i }
    )
    try {
        let trailingClosureExpr1 = TrailingClosureExpr(tokens1)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    let tokens2 = quote(
        func f(){ 100 }
    )
    try {
        let trailingClosureExpr2 = TrailingClosureExpr(tokens2)
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let trailingClosureExpr3 = TrailingClosureExpr()
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let trailingClosureExpr4 = TrailingClosureExpr(quote())
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let trailingClosureExpr5 = TrailingClosureExpr(quote(foo(1){a: Int64 => a}))
        trailingClosureExpr5.lambdaExpr = LambdaExpr(quote({=>1}))
        trailingClosureExpr5.lambdaExpr.dump()
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    try {
        let trailingClosureExpr6 = TrailingClosureExpr(quote(foo(1){a: Int64 => a}))
        let trailingClosureExpr66 = TrailingClosureExpr(quote(bar(2){=>2}))
        trailingClosureExpr6.expr = trailingClosureExpr66.expr
        trailingClosureExpr6.expr.dump()
    } catch (e: ASTException) {
        println(e)
        cnt++
    }

    println("cnt = ${cnt}")
    return 0
}

/* SCAN-IN
ASTException: 
[31merror[0m: expected expression or declaration, found '->'
  [36m| [0m
  [36m| [0mf { -> i * i }[0m
  [36m| [0m    [31m^^ expected expression or declaration here[0m
  [36m| [0m

parsing expr error.
ASTException: 
[31merror[0m: expected expression after '', found keyword 'func'
  [36m| [0m
  [36m| [0mfunc f() { 100 }[0m
  [36m| [0m[31m^^^^ expected expression here[0m
  [36m| [0m

parsing expr error.
ASTException: 
[31merror[0m: expected expression after '', found '<EOF>'
 [36m==>[0m :1:1:

parsing expr error.
LambdaExpr {
  -doubleArrow: Token {
    value: "=>"
    kind: DOUBLE_ARROW
    pos: 44: 61
  }
  -nodes: 0, LitConstExpr {
    -literal: Token {
      value: "1"
      kind: INTEGER_LITERAL
      pos: 44: 63
    }
  }
}
CallExpr {
  -callFunc: RefExpr {
    -identifier: Token {
      value: "bar"
      kind: IDENTIFIER
      pos: 53: 63
    }
  }
  -arguments: 0, Argument {
    -expr: LitConstExpr {
      -literal: Token {
        value: "2"
        kind: INTEGER_LITERAL
        pos: 53: 67
      }
    }
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
