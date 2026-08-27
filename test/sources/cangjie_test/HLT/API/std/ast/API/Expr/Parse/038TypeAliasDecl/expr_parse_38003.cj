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
import std.unicode.*

main() {
    var input: Tokens = quote(
         type A = B
    )
    let expr = parseDecl(input)
    if (expr is TypeAliasDecl) {
        var aDec = match (expr as TypeAliasDecl) {
            case Some(v) => v
            case None => throw Exception("Not TypeAliasDecl")
        }
        var mod = aDec.modifiers.size
        var typeExpr = aDec.keyword.value
        var identExpr = aDec.identifier.value
        var tp = aDec.aliasType
        var tpExpr = match (tp as RefType) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefType")
        }
        if (mod != 0 || typeExpr != "type" || identExpr != "A" || tpExpr != "B") {
            return 1
        }
        return 0
    }
    return 1
}
