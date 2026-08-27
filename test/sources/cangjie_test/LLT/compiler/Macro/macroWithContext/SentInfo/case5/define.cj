// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

macro package M

internal import std.ast.*

public macro outter(input: Tokens) {
    let messages = getChildMessages("inner")
    return Tokens() + Token(TokenKind.INTEGER_LITERAL, messages.size.toString())
}

public macro inner(attr: Tokens, input: Tokens) {
    setItem("v1", attr.toString())
    setItem("v2", input.toString())
    return Tokens()
}
