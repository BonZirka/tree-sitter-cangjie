/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: TupleType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_TupleType_01() {
    let res = parseFile("./TupleType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a: (Int64, Int32) = (1, 2)
var a: (a0: Int64, b0: Int32) = (1, 2)
var a: (a0: Int64, b0: Unit) = (1, ())
var a: (Int64, Int64, Int64, Int64, Int64, Int64, Int64) = (1, 2, 3, 4, 5, 6, 7)"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as TupleType).getOrThrow()
    @Assert(type_1.toString(), "(Int64, Int32)")
    @Assert(type_1.labels, Array<String>())
    @Assert(type_1.elements.toString(), "[Int64, Int32]")
    @Assert(type_1.getColonsPos().size, 0)
    @Assert(type_1.getCommasPos().size, 1)
    var Pos_1 = type_1.getCommasPos()[0]
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 14i32, 9i32, 15i32])
    @Assert(type_1.getLabelsPos().size, 0)
    Pos_1 = type_1.getLParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 8i32, 9i32, 9i32])
    Pos_1 = type_1.getRParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 21i32, 9i32, 22i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as TupleType).getOrThrow()
    @Assert(type_2.toString(), "(a0: Int64, b0: Int32)")
    @Assert(type_2.labels, ["a0", "b0"])
    @Assert(type_2.elements.toString(), "[Int64, Int32]")
    @Assert(type_2.getColonsPos().size, 2)
    var Pos_2 = type_2.getColonsPos()[0]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 11i32, 10i32, 12i32])
    Pos_2 = type_2.getColonsPos()[1]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 22i32, 10i32, 23i32])
    @Assert(type_2.getCommasPos().size, 1)
    Pos_2 = type_2.getCommasPos()[0]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 18i32, 10i32, 19i32])
    @Assert(type_2.getLabelsPos().size, 2)
    Pos_2 = type_2.getLabelsPos()[0]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 9i32, 10i32, 11i32])
    Pos_2 = type_2.getLabelsPos()[1]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 20i32, 10i32, 22i32])
    Pos_2 = type_2.getLParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 8i32, 10i32, 9i32])
    Pos_2 = type_2.getRParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 29i32, 10i32, 30i32])

    var decl_3: VarDecl = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    let type_3 = (decl_3.tyAnnotation.getOrThrow() as TupleType).getOrThrow()
    @Assert(type_3.toString(), "(a0: Int64, b0: Unit)")
    @Assert(type_3.labels, ["a0", "b0"])
    @Assert(type_3.elements.toString(), "[Int64, Unit]")
    @Assert(type_3.getColonsPos().size, 2)
    var Pos_3 = type_3.getColonsPos()[0]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 11i32, 11i32, 12i32])
    Pos_3 = type_3.getColonsPos()[1]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 22i32, 11i32, 23i32])
    @Assert(type_3.getCommasPos().size, 1)
    Pos_3 = type_3.getCommasPos()[0]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 18i32, 11i32, 19i32])
    @Assert(type_3.getLabelsPos().size, 2)
    Pos_3 = type_3.getLabelsPos()[0]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 9i32, 11i32, 11i32])
    Pos_3 = type_3.getLabelsPos()[1]
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 20i32, 11i32, 22i32])
    Pos_3 = type_3.getLParenPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 8i32, 11i32, 9i32])
    Pos_3 = type_3.getRParenPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 28i32, 11i32, 29i32])

    var decl_4: VarDecl = (sourcefile.topLevelDecls[3] as VarDecl).getOrThrow()
    let type_4 = (decl_4.tyAnnotation.getOrThrow() as TupleType).getOrThrow()
    @Assert(type_4.toString(), "(Int64, Int64, Int64, Int64, Int64, Int64, Int64)")
    @Assert(type_4.labels, Array<String>())
    @Assert(type_4.elements.toString(), "[Int64, Int64, Int64, Int64, Int64, Int64, Int64]")
    @Assert(type_4.getColonsPos().size, 0)
    @Assert(type_4.getCommasPos().size, 6)
    var Pos_4 = type_4.getCommasPos()[0]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 14i32, 12i32, 15i32])
    Pos_4 = type_4.getCommasPos()[1]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 21i32, 12i32, 22i32])
    Pos_4 = type_4.getCommasPos()[2]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 28i32, 12i32, 29i32])
    Pos_4 = type_4.getCommasPos()[3]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 35i32, 12i32, 36i32])
    Pos_4 = type_4.getCommasPos()[4]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 42i32, 12i32, 43i32])
    Pos_4 = type_4.getCommasPos()[5]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 49i32, 12i32, 50i32])
    @Assert(type_4.getLabelsPos().size, 0)
    Pos_4 = type_4.getLParenPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 8i32, 12i32, 9i32])
    Pos_4 = type_4.getRParenPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 56i32, 12i32, 57i32])
}
}