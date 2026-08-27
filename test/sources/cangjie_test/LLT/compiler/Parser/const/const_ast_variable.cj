// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan const a = 1

internal import std.ast.*

main() {
    let tk = quote(const a = 1)
    let a = parseDecl(tk)
    println(a.dump())
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
