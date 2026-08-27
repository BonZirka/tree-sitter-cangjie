// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

macro package define

internal import std.ast.*

public macro VAR_A(input: Tokens) {
    return quote(var a : Int64 = 1)
}

public macro VAR_B(attr: Tokens, input: Tokens) {
    return quote(var b : Int64 = 1)
}

public macro SAME(input: Tokens) {
    return input
}

public macro SAME(attr: Tokens, input: Tokens) {
    return input
}

public macro B(attr: Tokens, input: Tokens) {
    return quote(b(T))
}

public macro B2(input: Tokens) {
    return quote(b)
}

public macro B3(attr: Tokens, input: Tokens) {
    return quote(b(T)|b(T,T))
}

public macro F(attr: Tokens, input: Tokens) {
    return quote(func test(){})
}
