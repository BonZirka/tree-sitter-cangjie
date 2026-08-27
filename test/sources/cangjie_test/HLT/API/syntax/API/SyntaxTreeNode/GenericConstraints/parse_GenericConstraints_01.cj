/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: GenericConstraints_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_GenericConstraints_01() {
    let res = parseFile("./GenericConstraints_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains(##"func foo<T, U, V, W>() where T <: ToString, U <: C1 & C2, V <: C1<T> & C2<T, U>, W <: C2<X, Y> {}"##))

    var funcdecl_1 = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    let genericConstraints = funcdecl_1.genericConstraints.getOrThrow()
    @Assert(genericConstraints.toString(), "where T <: ToString, U <: C1 & C2, V <: C1<T> & C2<T, U>, W <: C2<X, Y>")
    @Assert(genericConstraints.constraints.size, 4)

    var posList = genericConstraints.getCommasPos()
    @Assert(posList.size == 3, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 43i32, 9i32, 44i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [9i32, 57i32, 9i32, 58i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [9i32, 80i32, 9i32, 81i32])
    var pos = genericConstraints.getWhereKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 24i32, 9i32, 29i32])
}
}