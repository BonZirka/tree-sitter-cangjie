/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: FuncDecl_07.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

// FuncDecl不支持互操作函数
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_07() {
    let res = parseFile("./FuncDecl_07.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().contains(##"foreign func foo(): Unit"##))

    var funcdecl_1 = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString(), ##"foreign func foo(): Unit"##)
    @Assert(funcdecl_1.body.isNone())
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case Foreign => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "foo")
    @Assert(funcdecl_1.params.params.size, 0)
    @Assert(funcdecl_1.retTyAnnotation.getOrThrow().toString(), "Unit")
    @Assert(funcdecl_1.modifiers.toString(), "[]")
    @Assert(funcdecl_1.annotations.toString(), ##"[]"##)
}
}