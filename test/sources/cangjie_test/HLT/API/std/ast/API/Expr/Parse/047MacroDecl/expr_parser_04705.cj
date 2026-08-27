/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.ast.*

main() {
    var input = quote(public macro X (input:Tokens) : Tokens { return input })
    let decl = parseDecl(input)
    var macroDecl = match (decl as MacroDecl) {
        case Some(v) => v
        case None => throw Exception("Not MacroDecl")
    }
    var output = quote($macroDecl)
    if (!compareTokens(input, output)) {
        return 1
    }
    return 0
}
