// EXEC:%frontendCompiler %cmp_opt %n.cj -o %output 2>&1 | compare %f
// ASSERT: regex-not core dumped
// ASSERT: regex-not Internal Compiler Error

internal import std.ast.*

main(): Int64 {
    quote($)
    quote(@)
    quote($@)
    quote(@$)
    quote($$)
    quote(@@)
    quote($/**/)
    quote(@/**/)

    0
}

// ASSERT: scan-6 expected identifier or '(' after '$'
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
