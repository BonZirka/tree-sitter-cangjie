/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VarDecl_01() {
    let _quote_1 = quote(var a = 1)
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(public let b = 1)
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(protected const c: Int64 = 1)
    let res_3 = parseTokens(_quote_3)

    var vardecl_1 = (res_1.node.getOrThrow() as VarDecl).getOrThrow()
    @Assert(vardecl_1.toString(), "var a = 1")
    @Assert(vardecl_1.initializer.isSome())
    @Assert(vardecl_1.initializer.getOrThrow().toString(), "1")
    match (vardecl_1.kind) {
        case VarKind.Var => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_1.tyAnnotation.isNone())
    @Assert(vardecl_1.pattern is VarPattern)

    var vardecl_2 = (res_2.node.getOrThrow() as VarDecl).getOrThrow()
    @Assert(vardecl_2.toString(), "public let b = 1")
    @Assert(vardecl_2.initializer.isSome())
    @Assert(vardecl_2.initializer.getOrThrow().toString(), "1")
    match (vardecl_2.kind) {
        case VarKind.Let => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_2.tyAnnotation.isNone())
    @Assert(vardecl_2.pattern is VarPattern)

    var vardecl_3 = (res_3.node.getOrThrow() as VarDecl).getOrThrow()
    @Assert(vardecl_3.toString(), "protected const c: Int64 = 1")
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
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 26i32, 1i32, 27i32])
    pos = vardecl_3.getIdentifierPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 17i32, 1i32, 18i32])
    pos = vardecl_3.getTyAnnotationColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 18i32, 1i32, 19i32])
    pos = vardecl_3.getVarKindKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 11i32, 1i32, 16i32])
}
}