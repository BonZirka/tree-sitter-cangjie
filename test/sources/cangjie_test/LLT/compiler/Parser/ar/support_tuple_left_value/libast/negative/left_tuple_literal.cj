// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-1: %run %run_opt %output %run_args

// ASSERT:scan invalid left-hand expression of assignment '='

internal import std.ast.*

main():Unit{
    let tokens = quote((a, _ = b) = (2, 1))
    let expr = parseExpr(tokens)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
