// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args

internal import std.ast.*

func compareResult(inputs: Array<Tokens>): Bool {
    for (input in inputs) {
        var expr = (parseExpr(input) as ReturnExpr).getOrThrow()
        var output = expr.toTokens()
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
    var inputs: Array<Tokens> = [quote(return)]

    let flag1 = compareResult(inputs)
    if (!flag1) {
        return 1
    }
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
