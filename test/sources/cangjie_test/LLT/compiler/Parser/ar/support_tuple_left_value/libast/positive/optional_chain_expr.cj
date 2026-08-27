// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

internal import std.ast.*

main():Unit{
    var a = Some([0, 0])
    let tokens = quote((a?[0], a?[1]) = (1, 2))
    let expr = parseExpr(tokens)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
