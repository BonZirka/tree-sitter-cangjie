// EXEC:%compiler %n.cj -o %output | compare %f
// ASSERT: scan-not error

internal import std.ast.*

func test():Tokens {
    let tokens = cangjieLex("1 + 2 + 3")
    var expr = parseExpr(tokens)

    // VarDecl InitExpr
    let a = quote(4 + 5 + 6)

    // assignment
    var b : Tokens = cangjieLex("1 + 2 + 3")
    b = quote(7 + 8 + 9)

    // assignment
    var c : Tokens
    c = quote(7 + 8 + 9)

    // ForInExpr   IfExpr   ArraySizedLit
    var ts = Array<Tokens>(1, quote(7 + 8 + 9))
    for (t in ts){
        if (true) {
            t.dump()
        }
    } 

    let f = a + quote(7 + 8 + 9)
    f.dump()

    // Func Body
    quote(7 + 8 + 9)

    // BinaryExpr
    return a + quote($expr)
}

func foo(input: Tokens): Tokens {
    var expr = parseExpr(input)
    let a = quote(4 + 5 + 6)

    // LambdaExpr ClonedReturnExpr
    let sum = { => quote(a + b) }
    sum()
    // LambdaExpr
    let sum1 = { => return quote(a + b) }
    sum1()

    // ParenExpr
    let b = (quote(4 + 5 + 6))

    // TernaryExpr UnaryExpr
    var c = if (!false) {quote(4 + 5 + 6)} else {quote(4 + 5 + 6)}

    // WhileExpr
    while (true) {
        let b = (quote(4 + 5 + 6))
        break;
    }

    // MatchExpr SelectorExpr MatchCase GuardExpr
    let ff: Tokens = match (quote(4 + 5 + 6)) {
        case a => quote(1 + 2 + 3)
        case b => quote(4 + 5 + 6)
        case c where (true)  => quote(4 + 4 + 6)
        case _ => quote(5 + 6 + 7)
    }
    ff.dump()

    // DoWhileExpr
    do {
        let b = (quote(4 + 5 + 6))
        break;
    } while (true)

    // ReturnExpr
    return quote($expr)
}

func bar(input: Tokens): Tokens {
    return input
}

main(): Int64 {
    var retTokens = test()

    // FuncArgExpr
    var otherTokens = bar(foo(quote( 1 + 2 + 3)))

    return 0
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
