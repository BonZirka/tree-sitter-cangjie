/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Inner_Comment_09.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Inner_Comment_09() {
    let res = parseFile("./Inner_Comment_09.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Assert(sourcefile.toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import pkga.aaaa as ff

main(/* block comment1 */ args: Array<String>) // line comment1
{
    match(ff()) { // line comment2
        case (x, /* block comment1 */y) where x < 10 => println("x") // line comment3
        // line comment4
        case y => () /* 
            block comment2 
        */
        case _ => throw Exception() // line comment5
    }

    try { // line comment6
        SeverBuilder() // line comment7
        .url("") /* 
            block comment2 
        */
        .get() /** document comment1 */
        .build()
    } /** document comment1 */ catch(e: Exception1 | /** document comment3 */ Exception2) {
        // line comment8
    } finally {
        /* 
            block comment3 
        */
    }

    let lamb1 = { /* block comment2 */ => }
    let lamb2 = { /* block comment2 */ a =>
        a + 1 // line comment9
    }
    let lamb3 = { /* block comment3 */ a: Int64, /* block comment4 */ b: Int64 => // line comment10
        a + b + 1 /** 
            document comment1 
        */
    }

    foo(a) // line comment11
    { => // line comment12
        return 0
    }

    if (let a <- b && /* block comment5 */ c < 0 || // line comment13
    !d) {

    } else if (/* block comment6 */ d) {

    } else /* block comment7 */ {

    }
}"##)

    var _decl: MainDecl = (sourcefile.topLevelDecls[0] as MainDecl).getOrThrow()
    @Assert(_decl.toString().replace("\r",""), ##"main(/* block comment1 */ args: Array<String>) // line comment1
{
    match(ff()) { // line comment2
        case (x, /* block comment1 */y) where x < 10 => println("x") // line comment3
        // line comment4
        case y => () /* 
            block comment2 
        */
        case _ => throw Exception() // line comment5
    }

    try { // line comment6
        SeverBuilder() // line comment7
        .url("") /* 
            block comment2 
        */
        .get() /** document comment1 */
        .build()
    } /** document comment1 */ catch(e: Exception1 | /** document comment3 */ Exception2) {
        // line comment8
    } finally {
        /* 
            block comment3 
        */
    }

    let lamb1 = { /* block comment2 */ => }
    let lamb2 = { /* block comment2 */ a =>
        a + 1 // line comment9
    }
    let lamb3 = { /* block comment3 */ a: Int64, /* block comment4 */ b: Int64 => // line comment10
        a + b + 1 /** 
            document comment1 
        */
    }

    foo(a) // line comment11
    { => // line comment12
        return 0
    }

    if (let a <- b && /* block comment5 */ c < 0 || // line comment13
    !d) {

    } else if (/* block comment6 */ d) {

    } else /* block comment7 */ {

    }
}"##)

}
}