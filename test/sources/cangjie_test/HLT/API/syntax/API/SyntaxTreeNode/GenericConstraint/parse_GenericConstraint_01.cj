/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: GenericConstraint_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_GenericConstraint_01() {
    let res = parseFile("./GenericConstraint_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Assert(sourcefile.toString().contains(##"func foo<T, U, R>(a: T, b: U): R where T <: ToString & C1, U <: I1<T, U> & I2 {}"##))

    var funcdecl_1 = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    let genericConstraints = funcdecl_1.genericConstraints.getOrThrow()
    @Assert(genericConstraints.constraints.size, 2)
    let gc_1 = genericConstraints.constraints[0]
    let gc_2 = genericConstraints.constraints[1]
    @Assert(gc_1.typeArgument is CompositeType)
    @Assert(gc_1.typeArgument.toString(), "T")
    @Assert(gc_1.upperBounds.toString(), "[ToString, C1]")
    @Assert(gc_2.typeArgument is CompositeType)
    @Assert(gc_2.typeArgument.toString(), "U")
    @Assert(gc_2.upperBounds.toString(), "[I1<T, U>, I2]")

    var posList = genericConstraints.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 58i32, 9i32, 59i32])
    var pos = genericConstraints.getWhereKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 34i32, 9i32, 39i32])

    posList = gc_1.getBitAndsPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 54i32, 9i32, 55i32])
    pos = gc_1.getUpperBoundPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 42i32, 9i32, 44i32])
}
}