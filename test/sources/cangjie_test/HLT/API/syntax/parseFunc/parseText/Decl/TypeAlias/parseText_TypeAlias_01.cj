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
func test_TypeAlias_01() {
    let str_1 = ##"type XX = Int64"##
    let res_1 = parseText(str_1)

    let str_2 = ##"public type Point2D = (X1, X2)"##
    let res_2 = parseText(str_2)

    let str_3 = ##"@Deprecated["aaa"]
protected type YY = Float64"##
    let res_3 = parseText(str_3)

    var typeAlias_1: TypeAlias = (res_1.node.getOrThrow() as TypeAlias).getOrThrow()
    var typeAlias_2: TypeAlias = (res_2.node.getOrThrow() as TypeAlias).getOrThrow()
    var typeAlias_3: TypeAlias = (res_3.node.getOrThrow() as TypeAlias).getOrThrow()

    @Assert(typeAlias_1.toString(), ##"type XX = Int64"##)
    @Assert(typeAlias_1.aliasName, "XX")
    @Assert(typeAlias_1.originalTyAnnotation.toString(), "Int64")
    @Assert(typeAlias_1.typeParameters.toString(), "[]")
    @Assert(typeAlias_1.modifiers.toString(), "[]")
    @Assert(typeAlias_1.annotations.toString(), "[]")

    @Assert(typeAlias_2.toString(), ##"public type Point2D = (X1, X2)"##)
    @Assert(typeAlias_2.aliasName, "Point2D")
    @Assert(typeAlias_2.originalTyAnnotation.toString(), "(X1, X2)")
    @Assert(typeAlias_2.typeParameters.toString(), "[]")
    @Assert(typeAlias_2.modifiers.toString(), "[public]")
    @Assert(typeAlias_2.annotations.toString(), "[]")

    @Assert(typeAlias_3.toString().replace("\r",""), ##"@Deprecated["aaa"]
protected type YY = Float64"##)
    @Assert(typeAlias_3.aliasName, "YY")
    @Assert(typeAlias_3.originalTyAnnotation.toString(), "Float64")
    @Assert(typeAlias_3.typeParameters.toString(), "[]")
    @Assert(typeAlias_3.modifiers.toString(), "[protected]")
    @Assert(typeAlias_3.annotations.toString(), ##"[@Deprecated["aaa"]]"##)

    var pos = typeAlias_2.getAssignPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 21i32, 1i32, 22i32])
    pos = typeAlias_2.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 13i32, 1i32, 20i32])
    pos = typeAlias_2.getTypeAliasKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 8i32, 1i32, 12i32])
}
}