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
    var input: Tokens = quote(
         type A = This
    )
    let expr = parseDecl(input)
    if (expr is TypeAliasDecl) {
        var tp = match (expr as TypeAliasDecl) {
            case Some(v) => v.aliasType
            case None => throw Exception("Not TypeAliasDecl")
        }

        if (!(tp is ThisType)) {
            return 2
        }

        var aValue = match (tp as ThisType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not ThisType")
        }
        if (aValue != "This") {
            return 3
        }

        return 0
    }
    return 1
}
