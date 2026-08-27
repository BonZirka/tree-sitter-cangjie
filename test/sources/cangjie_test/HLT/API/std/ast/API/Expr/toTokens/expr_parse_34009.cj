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
        var b = match (expr as MemberAccess) {
            case Some(v) => v
            case None => throw Exception("Not MemberAccess")
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
        quote(a.b<T,Int64>),
        quote(a.b),
        quote(a.b.c.d),
        quote(a().b),
        quote(if(true){a}else{b}.b),
        quote(foo(1){=>a}.b),
        quote(Int64(a).b),
        quote(a[0].b),
        quote(super.b)
    ]

    let flag1 = compareResult(inputs)
    if (!flag1) {
        return 1
    }
    return 0
}
