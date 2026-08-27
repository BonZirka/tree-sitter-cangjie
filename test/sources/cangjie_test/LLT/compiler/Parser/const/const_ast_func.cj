// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan const public func test(a: Int64): Int64 {
// ASSERT: scan return a
// ASSERT: scan }
internal import std.ast.*

main() {
    let tk = quote(
    const public func test(a: Int64): Int64 {
        return a
    })
    let a = parseDecl(tk)
    if (a.modifiers[0].keyword.value == "const") {
        println(a.toTokens())
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
