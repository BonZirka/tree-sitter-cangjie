// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

macro package cangjie_try

internal import std.ast.*

public macro Callback(input: Tokens): Tokens {
    var n = quote(

        var a = 1

        var b = 1
        var c = 1
        func u(): Unit {
                   let a  = try {
		            1
                    }
    )
    return n.toTokens()
}
