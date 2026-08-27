// DEPENDENCE: %n.expect
// EXEC: %compiler %cmp_opt_chir2hlir %coverage_opt %f -o %output
// EXEC: %run %run_opt %output > %n.txt
// EXEC: %diff %n.expect %n.txt

internal import std.ast.*
internal import std.collection.*

class MyVisitor <: Visitor {
    var ident: ArrayList<String> = ArrayList<String>()
    public override func visit(curNode: VarDecl) {
        ident.add(curNode.identifier.value)
        breakTraverse()
    }
}

let myVisitor = MyVisitor()

main(): Int64 {
    let input = quote(
        func test() {
            let a = 10
            var count =  0
            var res = ""
            let arr1 = [1,2,3,4,5]
            let arr2 = [a,a,a,10]
            if (a < 10) {
                a = a + 1
            }
       }
    )
    let fd = match (parseDecl(input) as FuncDecl) {
        case Some(v) => v
        case None => throw Exception()
    }
    var block = fd.block

    var b = VarDecl(quote(var b = 2))
    block.nodes.add(b, at: 1)
    block.traverse(myVisitor)
    if (myVisitor.ident.size != 6) {
        return 2
    }
    block.dump()

    return 0
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
