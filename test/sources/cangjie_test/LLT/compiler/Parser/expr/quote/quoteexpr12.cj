// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*
// ASSERT: scan error: unterminated single-line string
// ASSERT: regex-not core dumped
// ASSERT: regex-not Internal Compiler Error
main(): Int64 {
    let b: Tokens = quote(#")
    return 0
}
