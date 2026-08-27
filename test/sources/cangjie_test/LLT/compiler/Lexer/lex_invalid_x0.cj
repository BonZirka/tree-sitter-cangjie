// EXEC: %compiler %f -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan IllegalArgumentException: 
// ASSERT: scan unknown suffix 'x' for number literal

import std.ast.*

main() {
    var i = "-0_x0"
    var a: Tokens = cangjieLex(i)
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
