
// EXEC: %compiler %f -o %output
// EXEC: %run %run_opt %output 2>&1 | compare %f
// ASSERT: scan const func f1(i: Int64): Int64

internal import std.ast.*

class MyVisitor <: Visitor {
    override public func visit(fd: FuncDecl) { 
        if (fd.modifiers[0].keyword.value == "const") {
            println(fd.toTokens())
        }
        return 
    }
}
main() {
    let tk = quote(
    interface I {
        const func f1(i: Int64): Int64
    })
    let a = parseDecl(tk)
    let myVisitor = MyVisitor()
    a.traverse(myVisitor)
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
