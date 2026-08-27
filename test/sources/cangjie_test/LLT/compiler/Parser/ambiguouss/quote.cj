// EXEC: %compiler %f -o %output
// EXEC-PIPE-0: %run %run_opt %output 2>&1 | compare %f
// ASSERT: regex rshift_assign.*column: 24
// ASSERT: regex greater_equal.*column: 28
// ASSERT: regex rshift.*column: 31
// ASSERT: regex coalescing.*column: 34
// ASSERT: scan-not description: greater,
// ASSERT: scan-not description: assign,
// ASSERT: scan-not description: quest,

internal import std.ast.*

main() {
    let tokens = quote(>>= >= >> ??)
    tokens.dump()
    return
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
