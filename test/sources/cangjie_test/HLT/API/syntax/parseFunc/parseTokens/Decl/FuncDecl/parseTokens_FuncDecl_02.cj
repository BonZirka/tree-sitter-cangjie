/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_02() {
    let _quote_1 = quote(func func_1(): Unit)
    let res_1 = parseTokens(_quote_1)

    let _quote_2 = quote(static func func_2(a: Int64): ?Int64 {
        Some(0)
    })
    let res_2 = parseTokens(_quote_2)

    let _quote_3 = quote(mut func func_3(): Unit)
    let res_3 = parseTokens(_quote_3)

    var funcdecl_1 = (res_1.node.getOrThrow() as FuncDecl).getOrThrow()
    @Assert(funcdecl_1.toString(), ##"func func_1(): Unit"##)
    @Assert(funcdecl_1.body.isNone())
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "func_1")
    @Assert(funcdecl_1.params.params.size, 0)
    @Assert(funcdecl_1.retTyAnnotation.isSome())
    @Assert(funcdecl_1.retTyAnnotation.getOrThrow() is AtomicType)
    @Assert(funcdecl_1.modifiers.toString(), "[]")
    @Assert(funcdecl_1.annotations.toString(), "[]")

    var funcdecl_2 = (res_2.node.getOrThrow() as FuncDecl).getOrThrow()
    funcdecl_2.toString() |> println
    @Assert(funcdecl_2.toString().replace("\r",""), ##"static func func_2(a: Int64):?Int64 {
    Some(0)
}"##)
    @Assert(funcdecl_2.body.isSome())
    @Assert(funcdecl_2.body.getOrThrow().toString().replace("\r",""), ##"{
    Some(0)
}"##)
    @Assert(funcdecl_2.genericConstraints.isNone())
    @Assert(funcdecl_2.genericParams.size, 0)
    match (funcdecl_2.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_2.name, "func_2")
    @Assert(funcdecl_2.params.params.size, 1)
    @Assert(funcdecl_2.params.params[0].toString(), "a: Int64")
    @Assert(funcdecl_2.retTyAnnotation.isSome())
    @Assert(funcdecl_2.retTyAnnotation.getOrThrow() is PrefixType)
    @Assert(funcdecl_2.modifiers.toString(), "[static]")
    @Assert(funcdecl_2.annotations.toString(), "[]")

    var funcdecl_3 = (res_3.node.getOrThrow() as FuncDecl).getOrThrow()
    @Assert(funcdecl_3.toString(), ##"mut func func_3(): Unit"##)
    @Assert(funcdecl_3.body.isNone())
    @Assert(funcdecl_3.genericConstraints.isNone())
    @Assert(funcdecl_3.genericParams.size, 0)
    match (funcdecl_3.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_3.name, "func_3")
    @Assert(funcdecl_3.params.params.size, 0)
    @Assert(funcdecl_3.retTyAnnotation.isSome())
    @Assert(funcdecl_3.retTyAnnotation.getOrThrow() is AtomicType)
    @Assert(funcdecl_3.modifiers.toString(), "[mut]")
    @Assert(funcdecl_3.annotations.toString(), "[]")
}
}