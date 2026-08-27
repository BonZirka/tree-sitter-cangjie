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

// FuncDecl不支持互操作函数
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_08() {
    let _quote_1 = quote(unsafe func foo(): Unit {})
    let res_1 = parseTokens(_quote_1)
    var funcdecl_1 = (res_1.node.getOrThrow() as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString(), ##"unsafe func foo(): Unit { }"##)
    @Assert(funcdecl_1.body.getOrThrow().toString(), "{ }")
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "foo")
    @Assert(funcdecl_1.params.params.size, 0)
    @Assert(funcdecl_1.retTyAnnotation.getOrThrow().toString(), "Unit")
    @Assert(funcdecl_1.modifiers.toString(), "[unsafe]")
    @Assert(funcdecl_1.annotations.toString(), ##"[]"##)
}
}