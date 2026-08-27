/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: PrefixType_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PrefixType_01() {
    let res = parseFile("./PrefixType_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"var a: ?A = A()
var a: ???A = A()
var a: ?(A, B) = A()
var a: ?(A) = A()"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    let type_1 = (decl_1.tyAnnotation.getOrThrow() as PrefixType).getOrThrow()
    @Assert(type_1.toString(), "?A")
    @Assert(type_1.base.toString(), "A")
    match (type_1.prefixTypeOpKind) {
        case Quest => ()
        case _ => @Assert(false)
    }
    var Pos_1 = type_1.getOperatorPos()
    @Assert([Pos_1.beginLine, Pos_1.beginColumn, Pos_1.endLine, Pos_1.endColumn], [9i32, 8i32, 9i32, 9i32])

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    let type_2 = (decl_2.tyAnnotation.getOrThrow() as PrefixType).getOrThrow()
    @Assert(type_2.toString(), "???A")
    @Assert(type_2.base.toString(), "??A")
    var Pos_2 = type_2.getOperatorPos()
    @Assert([Pos_2.beginLine, Pos_2.beginColumn, Pos_2.endLine, Pos_2.endColumn], [10i32, 8i32, 10i32, 9i32])

    var decl_3: VarDecl = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    let type_3 = (decl_3.tyAnnotation.getOrThrow() as PrefixType).getOrThrow()
    @Assert(type_3.toString(), "?(A, B)")
    @Assert(type_3.base.toString(), "(A, B)")
    var Pos_3 = type_3.getOperatorPos()
    @Assert([Pos_3.beginLine, Pos_3.beginColumn, Pos_3.endLine, Pos_3.endColumn], [11i32, 8i32, 11i32, 9i32])

    var decl_4: VarDecl = (sourcefile.topLevelDecls[3] as VarDecl).getOrThrow()
    let type_4 = (decl_4.tyAnnotation.getOrThrow() as PrefixType).getOrThrow()
    @Assert(type_4.toString(), "?(A)")
    @Assert(type_4.base.toString(), "(A)")
    var Pos_4 = type_4.getOperatorPos()
    @Assert([Pos_4.beginLine, Pos_4.beginColumn, Pos_4.endLine, Pos_4.endColumn], [12i32, 8i32, 12i32, 9i32])
}
}