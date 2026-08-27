// DEPENDENCE: %n.expect
// EXEC: %compiler %cmp_opt_chir2hlir %coverage_opt %f -o %output
// EXEC: %run %run_opt %output > %n.txt
// EXEC: %diff %n.expect %n.txt

internal import std.ast.*
internal import std.collection.*

class MyVisitor <: Visitor {
    var ident: ArrayList<String> = ArrayList<String>()
    public override func visit(curNode: RefExpr) {
        ident.add(curNode.identifier.value)
        breakTraverse()
    }
}

let myVisitor = MyVisitor()

main(): Int64 {
    let input = quote(
        a.b<Int64,Int32>
    )
    let expr = match (parseExpr(input) as MemberAccess) {
        case Some(v) => v
        case None => throw Exception()
    }
    let flag = compareTokens(input, expr.toTokens())
    if (!flag) {
        return 1
    }
    if (expr.typeArguments.size != 2) {
        return 2
    }
    if (!(expr.typeArguments[0] is PrimitiveType)) {
        return 3
    }
    if (!(expr.typeArguments[1] is PrimitiveType)) {
        return 4
    }
    expr.traverse(myVisitor)
    if (myVisitor.ident.size != 1) {
        return 5
    }
    expr.dump()
    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
