/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: VArrayType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VArrayType_01() {
    let res = parseFile("./VArrayType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a: VArray<Int64, $0> = VArray<Int64, $0>({ i => i })
var a: VArray<UInt64, $5> = [1,2,3,4,5]"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()
    @Assert(type_1.toString(), "VArray<Int64, $0>")
    @Assert(type_1.toTokens().toString(), "VArray < Int64, $0 >")
    @Assert(type_1.elementType.toString(), "Int64")
    @Assert(type_1.size, 0)
    var Pos_1 = type_1.getCommaPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 20i32, 9i32, 21i32])
    Pos_1 = type_1.getDollarPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 22i32, 9i32, 23i32])
    Pos_1 = type_1.getLAnglePos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 14i32, 9i32, 15i32])
    Pos_1 = type_1.getRAnglePos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 24i32, 9i32, 25i32])
    Pos_1 = type_1.getVArrayPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 8i32, 9i32, 14i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()
    @Assert(type_2.toString(), "VArray<UInt64, $5>")
    @Assert(type_2.elementType.toString(), "UInt64")
    @Assert(type_2.size, 5)
    var Pos_2 = type_2.getCommaPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 21i32, 10i32, 22i32])
    Pos_2 = type_2.getDollarPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 23i32, 10i32, 24i32])
    Pos_2 = type_2.getLAnglePos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 14i32, 10i32, 15i32])
    Pos_2 = type_2.getRAnglePos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 25i32, 10i32, 26i32])
    Pos_2 = type_2.getVArrayPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 8i32, 10i32, 14i32])
}
}