/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan ParseASTException
// ASSERT: scan parsing decl error

import std.ast.*

main() {
    var input: Tokens = quote(var a)
    let expr = parseDecl(input)
    if (expr is VarDecl) {
        var b = match (expr as VarDecl) {
            case Some(v) => v
            case None => throw Exception("Not VarDecl")
        }
    }
    return 0
}
