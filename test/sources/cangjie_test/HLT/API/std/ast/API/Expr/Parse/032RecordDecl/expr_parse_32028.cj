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
             A( b!: String = "hi",
                public let d!: Int64 = 2){
                    super()
                    a = b
                    var c =d
                    func foo() {}
                }
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
        let ctorDeclOfRecord = match (bodyExpr0 as PrimaryCtorDecl) {
            case Some(v) => v
            case None => throw Exception("Not PrimaryCtorDecl")
        }
        if (ctorDeclOfRecord.identifier.value != "A") {
            return 2
        }
        let params0 = match (ctorDeclOfRecord.funcParams[0] as FuncParam) {
            case Some(v) => v
            case None => throw Exception("Not FuncParam")
        }
        if (params0.not.value != "!") {
            return 3
        }
        if (params0.identifier.value != "b") {
            return 4
        }
        let params0Type = match (params0.paramType as RefType) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefType")
        }
        if (params0Type != "String") {
            return 5
        }
        let params0expr = match (params0.expr as LitConstExpr) {
            case Some(v) => v.literal.value
            case None => throw Exception("Not LitConstExpr")
        }
        if (params0expr != "hi") {
            return 6
        }
        let params1 = match (ctorDeclOfRecord.funcParams[1] as FuncParam) {
            case Some(v) => v
            case None => throw Exception("Not FuncParam")
        }
        if (params1.not.value != "!") {
            return 7
        }
        if (params1.identifier.value != "d") {
            return 8
        }
        let params1Type = match (params1.expr as LitConstExpr) {
            case Some(v) => v.literal.value
            case None => throw Exception("Not LitConstExpr")
        }
        if (params1Type != "2") {
            return 9
        }

        var blockExpr = match (ctorDeclOfRecord.block as Block) {
            case Some(v) => v.nodes
            case None => throw Exception("Not Block")
        }
        var blockExpr0 = match (blockExpr[0] as CallExpr) {
            case Some(v) => v.callFunc
            case None => throw Exception("Not CallExpr")
        }
        var blockExpr0Value = match (blockExpr0 as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }
        if (blockExpr0Value != "super") {
            return 12
        }
        var blockExpr1 = match (blockExpr[1] as AssignExpr) {
            case Some(v) => v.leftExpr
            case None => throw Exception("Not AssignExpr")
        }
        var blockExpr1Value = match (blockExpr1 as RefExpr) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not RefExpr")
        }
        if (blockExpr1Value != "a") {
            return 13
        }
        var blockExpr2 = match (blockExpr[2] as Decl) {
            case Some(v) => v
            case None => throw Exception("Not Decl")
        }
        var blockExpr2Value = match (blockExpr2 as VarDecl) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not VarDecl")
        }
        if (blockExpr2Value != "c") {
            return 14
        }
        var blockExpr3 = match (blockExpr[3] as Decl) {
            case Some(v) => v
            case None => throw Exception("Not Decl")
        }
        var blockExpr3Value = match (blockExpr3 as FuncDecl) {
            case Some(v) => v.identifier.value
            case None => throw Exception("Not FuncDecl")
        }
        if (blockExpr3Value != "foo") {
            return 15
        }
        return 0
    }
    return 1
}
