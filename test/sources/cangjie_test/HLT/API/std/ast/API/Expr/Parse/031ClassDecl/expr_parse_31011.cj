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

main(): Int64 {
    var input: Tokens = quote(
        abstract open class A<T, V> <: C & I where T<:Int32, V<:C & A {
            operator func foo +(a:Int64):Int64 {}
        }
    )
    let expr = parseDecl(input)
    if (expr is ClassDecl) {
        var b = match (expr as ClassDecl) {
            case Some(v) => v
            case None => throw Exception("Not ClassDecl")
        }
        let bodyExpr = match (b.body as Body) {
            case Some(v) => v.decls
            case None => throw Exception("Not Body")
        }
        let funcDeclOfClass = match (bodyExpr[0] as FuncDecl) {
            case Some(v) => v
            case None => throw Exception("Not FuncDecl")
        }
        if (funcDeclOfClass.identifier.value != "+") {
            return 2
        }
        let typeExpr = match (funcDeclOfClass.declType as PrimitiveType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveType")
        }
        if (typeExpr != "Int64") {
            return 3
        }
        let blockExpr = match (funcDeclOfClass.block as Block) {
            case Some(v) => v.nodes.size
            case None => throw Exception("Not Block")
        }
        if (blockExpr != 0) {
            return 4
        }
        return 0
    }
    return 1
}
