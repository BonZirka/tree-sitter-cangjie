// EXEC: %compiler %cmp_opt_chir2hlir %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

import std.ast.*
import std.collection.*

main() {
    let decl = ClassDecl(quote(class testClass {}))
    decl.upperBound = Token(TokenKind.UPPERBOUND)
    let refType1 = RefType(quote(fatherClass1))
    let refType2 = RefType(quote(fatherClass2))
    decl.superTypes = ArrayList<TypeNode>([refType1, refType2])
    decl.superTypeBitAnds = quote(&)
    decl.body = Body()
    println(decl.toTokens())
}

/* SCAN-IN
class testClass <: fatherClass1 & fatherClass2 {
 */
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
