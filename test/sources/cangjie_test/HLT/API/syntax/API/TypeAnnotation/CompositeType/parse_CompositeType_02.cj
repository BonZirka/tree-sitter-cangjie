/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: CompositeType_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_CompositeType_02() {
    let res = parseFile("./CompositeType_02.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a1: CFunc<() -> Unit> = A()
var a2: CFunc<(CPointer<Int8>) -> Unit> = A()"##))

    @Assert(sourcefile.nodePos.beginLine, 1)
    @Assert(sourcefile.nodePos.beginColumn, 1)
    @Assert(sourcefile.nodePos.endLine, 10)
    @Assert(sourcefile.nodePos.endColumn, 46)
    @Assert(sourcefile.nodePos.fileName, "CompositeType_02.cj")
    @Assert(sourcefile.nodePos.filePath.contains("CompositeType_02.cj"))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_1.name, "CFunc")
    @Assert(type_1.prefixes.size, 0)
    @Assert(type_1.typeArguments.toString(), "[() -> Unit]")
    var Pos_1 = type_1.getLAnglePos().getOrThrow()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 14i32, 9i32, 15i32])
    Pos_1 = type_1.getRAnglePos().getOrThrow()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 25i32, 9i32, 26i32])
    @Assert(type_1.getCommasPos().size, 0)

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as CompositeType).getOrThrow()
    @Assert(type_2.name, "CFunc")
    @Assert(type_2.prefixes.size, 0)
    @Assert(type_2.typeArguments.toString(), "[(CPointer<Int8>) -> Unit]")
    var Pos_2 = type_2.getLAnglePos().getOrThrow()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 14i32, 10i32, 15i32])
    Pos_2 = type_2.getRAnglePos().getOrThrow()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 39i32, 10i32, 40i32])
    @Assert(type_2.getCommasPos().size, 0)
}
}