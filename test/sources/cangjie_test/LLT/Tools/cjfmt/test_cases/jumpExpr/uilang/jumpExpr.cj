// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

internal import std.ast.*

main(): Int64 {
    var input: Tokens = quote(break)
    let expr = ParseExpr(input)
    if (expr.isJumpExpr()) {
        var b = expr.asJumpExpr()
        if (!b.isBreak()) {
            return 1
        }
        return 0
    }
    return 3
}