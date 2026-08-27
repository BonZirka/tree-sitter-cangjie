// EXEC:%frontendCompiler %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

func call():Unit{
}

main(): Int64 {
    quote($(call()))    // no matching function declaration for function call
    0
}

// ASSERT: regex-not core dumped
// ASSERT: regex-not Internal Compiler Error
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
