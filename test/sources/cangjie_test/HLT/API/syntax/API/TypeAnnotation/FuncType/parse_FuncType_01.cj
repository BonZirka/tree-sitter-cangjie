/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: FuncType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncType_01() {
    let res = parseFile("./FuncType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a1: (a: Int64) -> Unit = foo1
var a2: (Int64, Int64) -> B = foo2
var a3: () -> (A, B) = foo3
var a4: (a: A, b: B) -> () -> Unit = foo4
var a5: (A, B) -> (A, () -> Unit) = foo5
var a6: (a: (A) -> Unit, b: (Int64) -> Unit) -> (A, () -> Unit) = foo6"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_1.toString(), "(a: Int64) -> Unit")
    @Assert(type_1.labels, ["a"])
    @Assert(type_1.paramTypes.toString(), "[Int64]")
    @Assert(type_1.retType.toString(), "Unit")
    var Pos_1 = type_1.getArrowPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 20i32, 9i32, 22i32])
    @Assert(type_1.getColonsPos().size, 1)
    Pos_1 = type_1.getColonsPos()[0]
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 11i32, 9i32, 12i32])
    @Assert(type_1.getCommasPos().size, 0)
    @Assert(type_1.getLabelsPos().size, 1)
    Pos_1 = type_1.getLabelsPos()[0]
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 10i32, 9i32, 11i32])
    Pos_1 = type_1.getLParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 9i32, 9i32, 10i32])
    Pos_1 = type_1.getRParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 18i32, 9i32, 19i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_2.toString(), "(Int64, Int64) -> B")
    @Assert(type_2.labels, Array<String>())
    @Assert(type_2.paramTypes.toString(), "[Int64, Int64]")
    @Assert(type_2.retType.toString(), "B")
    var Pos_2 = type_2.getArrowPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 24i32, 10i32, 26i32])
    @Assert(type_2.getColonsPos().size, 0)
    @Assert(type_2.getCommasPos().size, 1)
    Pos_2 = type_2.getCommasPos()[0]
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 15i32, 10i32, 16i32])
    @Assert(type_2.getLabelsPos().size, 0)
    Pos_2 = type_2.getLParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 9i32, 10i32, 10i32])
    Pos_2 = type_2.getRParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 22i32, 10i32, 23i32])

    var decl_3: VarDecl = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    let type_3 = (decl_3.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_3.toString(), "() -> (A, B)")
    @Assert(type_3.labels, Array<String>())
    @Assert(type_3.paramTypes.toString(), "[]")
    @Assert(type_3.retType.toString(), "(A, B)")
    var Pos_3 = type_3.getArrowPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 12i32, 11i32, 14i32])
    @Assert(type_3.getColonsPos().size, 0)
    @Assert(type_3.getCommasPos().size, 0)
    @Assert(type_3.getLabelsPos().size, 0)
    Pos_3 = type_3.getLParenPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 9i32, 11i32, 10i32])
    Pos_3 = type_3.getRParenPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 10i32, 11i32, 11i32])

    var decl_4: VarDecl = (sourcefile.topLevelDecls[3] as VarDecl).getOrThrow()
    let type_4 = (decl_4.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_4.toString(), "(a: A, b: B) -> () -> Unit")
    @Assert(type_4.labels, ["a", "b"])
    @Assert(type_4.paramTypes.toString(), "[A, B]")
    @Assert(type_4.retType.toString(), "() -> Unit")
    var Pos_4 = type_4.getArrowPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 22i32, 12i32, 24i32])
    @Assert(type_4.getColonsPos().size, 2)
    Pos_4 = type_4.getColonsPos()[0]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 11i32, 12i32, 12i32])
    Pos_4 = type_4.getColonsPos()[1]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 17i32, 12i32, 18i32])
    @Assert(type_4.getCommasPos().size, 1)
    Pos_4 = type_4.getCommasPos()[0]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 14i32, 12i32, 15i32])
    @Assert(type_4.getLabelsPos().size, 2)
    Pos_4 = type_4.getLabelsPos()[0]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 10i32, 12i32, 11i32])
    Pos_4 = type_4.getLabelsPos()[1]
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 16i32, 12i32, 17i32])
    Pos_4 = type_4.getLParenPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 9i32, 12i32, 10i32])
    Pos_4 = type_4.getRParenPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 20i32, 12i32, 21i32])

    var decl_5: VarDecl = (sourcefile.topLevelDecls[4] as VarDecl).getOrThrow()
    let type_5 = (decl_5.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_5.toString(), "(A, B) -> (A, () -> Unit)")
    @Assert(type_5.labels, Array<String>())
    @Assert(type_5.paramTypes.toString(), "[A, B]")
    @Assert(type_5.retType.toString(), "(A, () -> Unit)")
    var Pos_5 = type_5.getArrowPos()
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [13i32, 16i32, 13i32, 18i32])
    @Assert(type_5.getCommasPos().size, 1)
    Pos_5 = type_5.getCommasPos()[0]
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [13i32, 11i32, 13i32, 12i32])
    @Assert(type_5.getLabelsPos().size, 0)
    Pos_5 = type_5.getLParenPos()
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [13i32, 9i32, 13i32, 10i32])
    Pos_5 = type_5.getRParenPos()
    @Assert([Pos_5.beginLine, Pos_5.beginColumn, Pos_5.endLine, Pos_5.endColumn], [13i32, 14i32, 13i32, 15i32])

    var decl_6: VarDecl = (sourcefile.topLevelDecls[5] as VarDecl).getOrThrow()
    let type_6 = (decl_6.tyAnnotation.getOrThrow() as FuncType).getOrThrow()
    @Assert(type_6.toString(), "(a: (A) -> Unit, b: (Int64) -> Unit) -> (A, () -> Unit)")
    @Assert(type_6.labels, ["a", "b"])
    @Assert(type_6.paramTypes.toString(), "[(A) -> Unit, (Int64) -> Unit]")
    @Assert(type_6.retType.toString(), "(A, () -> Unit)")
    var Pos_6 = type_6.getArrowPos()
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 46i32, 14i32, 48i32])
    @Assert(type_6.getColonsPos().size, 2)
    Pos_6 = type_6.getColonsPos()[0]
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 11i32, 14i32, 12i32])
    Pos_6 = type_6.getColonsPos()[1]
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 27i32, 14i32, 28i32])
    @Assert(type_6.getCommasPos().size, 1)
    Pos_6 = type_6.getCommasPos()[0]
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 24i32, 14i32, 25i32])
    @Assert(type_6.getLabelsPos().size, 2)
    Pos_6 = type_6.getLabelsPos()[0]
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 10i32, 14i32, 11i32])
    Pos_6 = type_6.getLabelsPos()[1]
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 26i32, 14i32, 27i32])
    Pos_6 = type_6.getLParenPos()
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 9i32, 14i32, 10i32])
    Pos_6 = type_6.getRParenPos()
    @Assert([Pos_6.beginLine, Pos_6.beginColumn, Pos_6.endLine, Pos_6.endColumn], [14i32, 44i32, 14i32, 45i32])
}
}