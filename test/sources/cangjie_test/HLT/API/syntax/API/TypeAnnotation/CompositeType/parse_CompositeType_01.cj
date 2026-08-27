/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: CompositeType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_CompositeType_01() {
    let res = parseFile("./CompositeType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a1: p1.p0.A<Int64, B> = A()
var a2: A = A()
var a3: A<Int64> = A()
var a4: p1.A = A()"##))

    @Assert(sourcefile.nodePos.beginLine, 1)
    @Assert(sourcefile.nodePos.beginColumn, 1)
    @Assert(sourcefile.nodePos.endLine, 12)
    @Assert(sourcefile.nodePos.endColumn, 19)
    @Assert(sourcefile.nodePos.fileName, "CompositeType_01.cj")
    @Assert(sourcefile.nodePos.filePath.contains("CompositeType_01.cj"))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_1.name, "A")
    @Assert(type_1.prefixes, ["p1", "p0"])
    @Assert(type_1.typeArguments.toString(), "[Int64, B]")
    var Pos_1 = type_1.getLAnglePos().getOrThrow()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 16i32, 9i32, 17i32])
    Pos_1 = type_1.getRAnglePos().getOrThrow()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 25i32, 9i32, 26i32])
    @Assert(type_1.getCommasPos().size, 1)
    Pos_1 = type_1.getCommasPos()[0]
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 22i32, 9i32, 23i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_2.name, "A")
    @Assert(type_2.prefixes.size, 0)
    @Assert(type_2.typeArguments.toString(), "[]")
    @Assert(type_2.getLAnglePos().isNone(), true)
    @Assert(type_2.getRAnglePos().isNone(), true)
    @Assert(type_2.getCommasPos().size, 0)

    var decl_3: VarDecl = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    let type_3 = (decl_3.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_3.name, "A")
    @Assert(type_3.prefixes.size, 0)
    @Assert(type_3.typeArguments.toString(), "[Int64]")
    var Pos_3 = type_3.getLAnglePos().getOrThrow()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 10i32, 11i32, 11i32])
    Pos_3 = type_3.getRAnglePos().getOrThrow()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 16i32, 11i32, 17i32])
    @Assert(type_3.getCommasPos().size, 0)

    var decl_4: VarDecl = (sourcefile.topLevelDecls[3] as VarDecl).getOrThrow()
    let type_4 = (decl_4.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_4.name, "A")
    @Assert(type_4.prefixes, ["p1"])
    @Assert(type_4.typeArguments.toString(), "[]")
    @Assert(type_4.getLAnglePos().isNone(), true)
    @Assert(type_4.getRAnglePos().isNone(), true)
    @Assert(type_4.getCommasPos().size, 0)
}
}