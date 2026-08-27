/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: VarDecl_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VarDecl_01() {
    let res = parseFile("./VarDecl_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    println(sourcefile.toString())
    @Assert(sourcefile.toString().replace("\r","").contains(##"var a = 1
public let b = 1
protected const c: Int64 = 1"##))

    var vardecl_1 = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    @Assert(vardecl_1.toString(), "var a = 1")
    @Assert(vardecl_1.initializer.isSome())
    @Assert(vardecl_1.initializer.getOrThrow().toString(), "1")
    match (vardecl_1.kind) {
        case VarKind.Var => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_1.tyAnnotation.isNone())
    @Assert(vardecl_1.pattern is VarPattern)

    var vardecl_2 = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    @Assert(vardecl_2.toString(), "public let b = 1")
    @Assert(vardecl_2.initializer.isSome())
    @Assert(vardecl_2.initializer.getOrThrow().toString(), "1")
    match (vardecl_2.kind) {
        case VarKind.Let => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_2.tyAnnotation.isNone())
    @Assert(vardecl_2.pattern is VarPattern)

    var vardecl_3 = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    @Assert(vardecl_3.toString(), "protected const c: Int64 = 1")
    @Assert(vardecl_3.toTokens().toString(), "protected const c: Int64 = 1")
    @Assert(vardecl_3.initializer.isSome())
    @Assert(vardecl_3.initializer.getOrThrow().toString(), "1")
    match (vardecl_3.kind) {
        case VarKind.Const => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_3.tyAnnotation.isSome())
    @Assert(vardecl_3.tyAnnotation.getOrThrow() is AtomicType)
    @Assert(vardecl_3.pattern is VarPattern)

    var pos = vardecl_3.getAssignPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 26i32, 11i32, 27i32])
    pos = vardecl_3.getIdentifierPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 17i32, 11i32, 18i32])
    pos = vardecl_3.getTyAnnotationColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 18i32, 11i32, 19i32])
    pos = vardecl_3.getVarKindKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 11i32, 11i32, 16i32])
}
}