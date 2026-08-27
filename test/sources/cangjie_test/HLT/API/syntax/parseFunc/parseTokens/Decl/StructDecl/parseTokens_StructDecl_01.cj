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
func test_StructDecl_01() {
    let _quote = quote(struct S1 {})
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Assert(structDecl.toString(), ##"struct S1 { }"##)

    @Assert(structDecl.getGenericParamsCommasPos().size == 0, true)
    @Assert(structDecl.getGenericParamsLAnglePos().isNone(), true)
    @Assert(structDecl.getGenericParamsRAnglePos().isNone(), true)
    var pos = structDecl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 8i32, 1i32, 10i32])
    pos = structDecl.getStructKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 7i32])
    @Assert(structDecl.getSuperTyAnnotationsBitAndsPos().size == 0, true)
    @Assert(structDecl.getUpperBoundPos().isNone(), true)
}
}