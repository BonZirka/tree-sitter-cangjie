// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

// ASSERT:scan description: identifier, token_id: 137, token_literal_value: p1, fileID: 1, line: 10, column: 28
// ASSERT:scan description: identifier, token_id: 137, token_literal_value: p2, fileID: 1, line: 10, column: 40

internal import std.ast.*

main():Unit{
    let tks = quote(let a:(p1:(Int64), p2:Int64))
    let ast = parseDecl(tks)
    ast.toTokens().dump()
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
