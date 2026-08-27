/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: ParenType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ParenType_01() {
    let res = parseFile("./ParenType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a: ((Int64, Int8)) = foo
var a: (()-> Unit) = foo"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as ParenType).getOrThrow()
    @Assert(type_1.toString(), "((Int64, Int8))")
    @Assert(type_1.subType.toString(), "(Int64, Int8)")
    var Pos_1 = type_1.getLParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 8i32, 9i32, 9i32])
    Pos_1 = type_1.getRParenPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 22i32, 9i32, 23i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as ParenType).getOrThrow()
    @Assert(type_2.toString(), "(()-> Unit)")
    @Assert(type_2.subType.toString(), "()-> Unit")
    var Pos_2 = type_2.getLParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 8i32, 10i32, 9i32])
    Pos_2 = type_2.getRParenPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 18i32, 10i32, 19i32])
}
}