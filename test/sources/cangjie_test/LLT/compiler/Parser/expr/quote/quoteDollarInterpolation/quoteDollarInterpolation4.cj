// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC:%compiler %n.cj -o %output
// EXEC:%run %run_opt %output %run_args

internal import std.ast.*

func call1() {
    var toks = cangjieLex("1 + 2")
    var binaryExpr: BinaryExpr = (parseExpr(toks) as BinaryExpr).getOrThrow()
    quote($(binaryExpr))
    0
}

func call2() {
    var toks = cangjieLex("!a")
    var unaryExpr: UnaryExpr = (parseExpr(toks) as UnaryExpr).getOrThrow()
    quote($(unaryExpr))
    0
}

func call3() {
    var toks = cangjieLex("\"aaaaa\"")
    var litConstExprExpr: LitConstExpr = (parseExpr(toks) as LitConstExpr).getOrThrow()
    quote($(litConstExprExpr))
    0
}

func call4() {
    var toks = cangjieLex("(a + b)")
    var parenExpr: ParenExpr = (parseExpr(toks) as ParenExpr).getOrThrow()
    quote($(parenExpr))
    0
}

func call5() {
    var toks = cangjieLex("call()")
    var callExpr: CallExpr = (parseExpr(toks) as CallExpr).getOrThrow()
    quote($(callExpr))
    0
}

func call6() {
    var toks = cangjieLex("a")
    var refExpr: RefExpr = (parseExpr(toks) as RefExpr).getOrThrow()
    quote($(refExpr))
    0
}

func call7() {
    var toks = cangjieLex("func test(a: Int32, b: Int32) {var c = a + b}")
    var funcDecl: FuncDecl = (parseDecl(toks) as FuncDecl).getOrThrow()
    quote($(funcDecl))
    0
}


func call8() {
    var toks = cangjieLex("var a = 1")
    var varDecl: VarDecl = (parseDecl(toks) as VarDecl).getOrThrow()
    quote($(varDecl))
    0
}
main(): Int64 {
    call1()
    call2()
    call3()
    call4()
    call5()
    call6()
    call7()
    call8()
    0
}
