// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC:%frontendCompiler %cmp_opt %diag_json %n.cj -o %output 2>&1 | compare %f

internal import std.ast.*

main(): Int64 {
    let a: Tokens = quote(\)

    return 0
}

// ASSERT: scan parse_expected_right_delimiter
