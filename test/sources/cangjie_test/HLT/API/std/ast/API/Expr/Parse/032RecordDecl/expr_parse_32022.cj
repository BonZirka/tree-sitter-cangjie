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

main(): Int64 {
    var input: Tokens = quote(
        public struct A<T, V> <: C & I where T<:Int32, V<:C & A {
             init(a:Int64, b!: String, c!:()->Int64={=>1}){}
        }
    )
    let expr = parseDecl(input)
    if (expr is StructDecl) {
        var b = match (expr as StructDecl) {
            case Some(v) => v
            case None => throw Exception("Not StructDecl")
        }
        var bodyExpr0 = match (b.body as Body) {
            case Some(v) => v.decls[0]
            case None => throw Exception("Not Body")
        }
        let funcDeclOfRecord = match (bodyExpr0 as FuncDecl) {
            case Some(v) => v
            case None => throw Exception("Not FuncDecl")
        }
        if (funcDeclOfRecord.identifier.value != "init") {
            return 2
        }
        let params0 = match (funcDeclOfRecord.funcParams[0] as FuncParam) {
            case Some(v) => v
            case None => throw Exception("Not FuncParam")
        }
        let p0type = match (params0.paramType as PrimitiveType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveType")
        }
        if (p0type != "Int64") {
            return 3
        }
        let params1 = match (funcDeclOfRecord.funcParams[1] as FuncParam) {
            case Some(v) => v
            case None => throw Exception("Not FuncParam")
        }
        let p1type = match (params1.paramType as RefType) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefType")
        }
        if (p1type != "String") {
            return 4
        }
        if (params1.not.value != "!") {
            return 4
        }
        let params2 = match (funcDeclOfRecord.funcParams[2] as FuncParam) {
            case Some(v) => v
            case None => throw Exception("Not FuncParam")
        }
        let p2type = match (params2.paramType as FuncType) {
            case Some(v) => v.returnType
            case None => throw Exception("Not FuncType")
        }
        let p2typeExpr = match (p2type as PrimitiveType) {
            case Some(v) => v.keyword.value
            case None => throw Exception("Not PrimitiveType")
        }
        if (p2typeExpr != "Int64") {
            return 5
        }
        let p2Lam = match (params2.expr as LambdaExpr) {
            case Some(v) => v.nodes[0]
            case None => throw Exception("Not LambdaExpr")
        }
        let p2LamExpr = match (p2Lam as LitConstExpr) {
            case Some(v) => v.literal.value
            case None => throw Exception("Not LitConstExpr")
        }
        if (p2LamExpr != "1") {
            return 6
        }
        let blockExpr = match (funcDeclOfRecord.block as Block) {
            case Some(v) => v.nodes.size
            case None => throw Exception("Not Block")
        }
        if (blockExpr != 0) {
            return 7
        }
        return 0
    }
    return 1
}
