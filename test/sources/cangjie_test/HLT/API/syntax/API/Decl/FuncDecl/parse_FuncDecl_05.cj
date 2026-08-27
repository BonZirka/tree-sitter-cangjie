/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: FuncDecl_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_05() {
    let res = parseFile("./FuncDecl_05.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"func foo<T>(a: T) {
    func goo() {
        return 1
    }
    goo()
}"##))

    var funcdecl_1 = (sourcefile.topLevelDecls[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString().replace("\r",""), ##"func foo<T>(a: T) {
    func goo() {
        return 1
    }
    goo()
}"##)
    @Assert(funcdecl_1.body.isSome())
    @Assert(funcdecl_1.body.getOrThrow().toString().replace("\r",""), ##"{
    func goo() {
        return 1
    }
    goo()
}"##)
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 1)
    match (funcdecl_1.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "foo")
    @Assert(funcdecl_1.params.params.size, 1)
    @Assert(funcdecl_1.params.params[0].toString(), "a: T")
    @Assert(funcdecl_1.retTyAnnotation.isNone())
    @Assert(funcdecl_1.modifiers.toString(), "[]")
    @Assert(funcdecl_1.annotations.toString(), "[]")

    var funcdecl_2 = (funcdecl_1.body.getOrThrow().nodes[0] as FuncDecl).getOrThrow()
    @Expect(funcdecl_2.toString().replace("\r",""), ##"func goo() {
        return 1
    }"##)
    @Assert(funcdecl_2.body.isSome())
    @Assert(funcdecl_2.body.getOrThrow().toString().replace("\r",""), ##"{
        return 1
    }"##)
    @Assert(funcdecl_2.genericConstraints.isNone())
    @Assert(funcdecl_2.genericParams.size, 0)
    match (funcdecl_2.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_2.name, "goo")
    @Assert(funcdecl_2.params.params.size, 0)
    @Assert(funcdecl_2.retTyAnnotation.isNone())
    @Assert(funcdecl_2.modifiers.toString(), "[]")
    @Assert(funcdecl_2.annotations.toString(), "[]")
}
}