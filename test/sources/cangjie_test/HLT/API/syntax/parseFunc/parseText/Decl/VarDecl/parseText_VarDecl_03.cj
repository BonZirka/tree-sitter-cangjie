/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_VarDecl_03() {
    let str_1 = ##"@Deprecated["a"] var a = 1"##
    let res_1 = parseText(str_1)

    var vardecl_1 = (res_1.node.getOrThrow() as VarDecl).getOrThrow()
    @Assert(vardecl_1.toString(), ##"@Deprecated["a"] var a = 1"##)
    @Assert(vardecl_1.initializer.isSome())
    @Assert(vardecl_1.initializer.getOrThrow().toString(), "1")
    match (vardecl_1.kind) {
        case VarKind.Var => ()
        case _ => @Assert(false)
    }
    @Assert(vardecl_1.tyAnnotation.isNone())
    @Assert(vardecl_1.pattern is VarPattern)
    @Assert(vardecl_1.annotations.toString(), ##"[@Deprecated["a"]]"##)
}
}