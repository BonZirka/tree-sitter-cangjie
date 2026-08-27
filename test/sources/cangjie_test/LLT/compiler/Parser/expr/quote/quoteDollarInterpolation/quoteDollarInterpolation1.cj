// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC:%compiler %n.cj -o %output
// EXEC:%run %run_opt %output %run_args

internal import std.ast.*

class Data {
    public var a: Expr

    public init() {
        let tokens = cangjieLex("1 + 2 + 3")
        this.a = parseExpr(tokens)
    }
}

main(): Int64 {
    let tokens = cangjieLex("1 + 2 + 3")
    var expr = (parseExpr(tokens) as BinaryExpr).getOrThrow()
    var `func` = (parseExpr(tokens) as BinaryExpr).getOrThrow()
    var a_b = (parseExpr(tokens) as BinaryExpr).getOrThrow()

    // RefExpr
    let a = quote($(expr))
    let a66 = quote($(`func`))
    let a67 = quote($`func`)
    let a68 = quote($a_b)

    // IfExpr
    let aa = quote($( if (true) {expr} else {expr} ))

    let aa1 = quote($( expr ))

    // QuoteExpr
    let aa2 = quote($( quote( $(expr) ) ))

    // QuoteExpr enhance
    let aa22 = quote($( quote( $( quote( $(expr) ) ) ) ))

    // MatchExpr
    var t = true
    let aa3 = quote($(
        match (t) {
          case true => expr
          case _ => expr
        }
    ))

    // CallExpr
    let aa4 = quote($( expr.leftExpr ))

    // ArrayAccess
    var array: Array<BinaryExpr> = [expr, expr, expr]
    let aa5 = quote($( array[0] ))

    // ParenExpr
    let aa7 = quote($( (expr) ))

    // TernaryExpr UnaryExpr
    let aa8 = quote($( if (!false) {expr} else {expr} ))

    let a1 = quote($(parseExpr(tokens)))
    let a2 = quote($(expr)$(expr)$(expr)$(expr)$(expr))
    let a3 = quote($(parseExpr(tokens)) $(expr))
    let b = quote(\$(expr))
    let c2 = quote(\$)
    // The same with quote(\(\))
    let d = quote(())
    let d1 = quote(\(\))
    let d2 = quote(\))
    let d3 = quote(\()

    quote(\$\@) // SUCCESS
    quote(\$\$) // SUCCESS
    quote(\$()) // SUCCESS
    quote(\$/**/) // SUCCESS
    return 0
}
