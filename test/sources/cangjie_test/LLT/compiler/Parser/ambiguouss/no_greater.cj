// EXEC: %compiler %f -o %output
// EXEC-PIPE-0: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan-not greater
// ASSERT: scan rshift

internal import std.ast.*

main() {
    let tokens = cangjieLex("let b = 10 >> 1")
    tokens.dump()
    let d = parseDecl(tokens)
    d.toTokens().dump()
    return
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
