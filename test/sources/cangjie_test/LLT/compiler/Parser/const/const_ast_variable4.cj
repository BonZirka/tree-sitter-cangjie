// EXEC: %compiler %cmp_opt %f -o %output
// ERRCHECK: %run %run_opt %output
// ASSERT: scan unexpected modifier 'const' on var or let variable

internal import std.ast.*

main() {
    let tk = quote(const let a = 1)
    let a = parseDecl(tk)
    println(a.toTokens())
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
