/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %use_ast %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.ast.*

func compareResult(inputs: Array<Tokens>): Bool {
    for (input in inputs) {
        var expr = parseExpr(input)
        var b = match (expr as LitConstExpr) {
            case Some(v) => v
            case None => throw Exception("Not LitConstExpr")
        }
        var output = b.toTokens()
        var flag = compareTokens(input, output)
        if (!flag) {
            print("input tokens:\n")
            input.dump()
            print("output tokens:\n")
            output.dump()
            return false
        }
    }
    return true
}

main() {
    var inputs: Array<Tokens> = [
        quote(1),
        quote(1.0),
        quote(true),
        quote('a'),
        quote(0x1),
        quote(0B1),
        quote(0o0),
        quote(0XaF),
        quote(0X1.1p1),
        quote(#""#),
        quote("""
123""")
    ]
    let flag1 = compareResult(inputs)
    if (!flag1) {
        return 1
    }
    return 0
}
