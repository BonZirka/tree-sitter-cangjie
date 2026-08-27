// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan public const(a, b) =(1, 2)

internal import std.ast.*

main() {
    let tk = quote(public const (a, b) = (1, 2))
    let a = parseDecl(tk)
    if (a.keyword.value == "const") {
        println(a.toTokens())
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
