// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// ERRCHECK: %run %run_opt %output %run_args
// ASSERT:scan cannot '+=' a tuple

internal import std.ast.*

main():Unit{
    let tokens = quote((a, b) += (2, 3))
    let expr = parseExpr(tokens)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
