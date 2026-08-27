/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

public class MyVisitor <: ASTVisitor {
    public override func preAction(node: SyntaxTreeNode): PreActionMode {
        if (let decl : PropDecl <- node) {
            println("preAction PropDecl: ${decl.toString()}")
            return PreActionMode.Stop
        } else if (let decl : VarDecl <- node) {
            println("preAction VarDecl: ${decl.toString()}")
        } else if (let decl : FuncDecl <- node) {
            println("preAction FuncDecl: ${decl.toString()}")
        } else if (let decl : Annotation <- node) {
            println("preAction Annotation: ${decl.toString()}")
        } else if (let decl : Modifier <- node) {
            println("preAction Modifier: ${decl.toString()}")
        } else if (let decl : SymbolRef <- node) {
            println("preAction SymbolRef: ${decl.toString()}")
        } else if (let decl : LitConstExpr <- node) {
            println("preAction LitConstExpr: ${decl.toString()}")
        } else if (let decl : GenericParam <- node) {
            println("preAction GenericParam: ${decl.toString()}")
        } else if (let decl : Pattern <- node) {
            println("preAction Pattern: ${decl.toString()}")
        } 
        return PreActionMode.Continue
    }

    override public func postAction(node: SyntaxTreeNode): PostActionMode {
        if (let decl : PropDecl <- node) {
            println("postAction PropDecl: ${decl.toString()}")
            return PostActionMode.Stop
        } else if (let decl : VarDecl <- node) {
            println("postAction VarDecl: ${decl.toString()}")
        } else if (let decl : FuncDecl <- node) {
            println("postAction FuncDecl: ${decl.toString()}")
        } else if (let decl : Annotation <- node) {
            println("postAction Annotation: ${decl.toString()}")
        } else if (let decl : Modifier <- node) {
            println("postAction Modifier: ${decl.toString()}")
        } else if (let decl : SymbolRef <- node) {
            println("postAction SymbolRef: ${decl.toString()}")
        } else if (let decl : LitConstExpr <- node) {
            println("postAction LitConstExpr: ${decl.toString()}")
        } else if (let decl : GenericParam <- node) {
            println("postAction GenericParam: ${decl.toString()}")
        } else if (let decl : Pattern <- node) {
            println("postAction Pattern: ${decl.toString()}")
        } 
        return PostActionMode.Continue
    }
}

@Test
class test_01{
    @TestCase
func test_ASTVistor_01() {
    let classdecl = parseText(##"@Deprecated["仓颉"]
public class S1<T> <: I1<T> where T <: ToString{
    public let s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo(a: T): T {
        return a
    }
}"##).node.getOrThrow()

    let _visitor = MyVisitor()
    _visitor.walk(classdecl)



}
}