// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan public const A() {
// ASSERT: scan a = 0
// ASSERT: scan }
internal import std.ast.*

main() {
    let tk = quote(
    public const A() {
        a = 0
    })
    let a = (parseDecl(tk, astKind: "PrimaryCtorDecl") as PrimaryCtorDecl).getOrThrow()
    if (a.isConst()) {
        println(a.toTokens())
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
