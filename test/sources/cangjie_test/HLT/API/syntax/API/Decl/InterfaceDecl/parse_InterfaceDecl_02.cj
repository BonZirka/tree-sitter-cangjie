/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: InterfaceDecl_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_InterfaceDecl_02() {
    let res = parseFile("./InterfaceDecl_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"@Deprecated["aaa"]
public interface I1 <: S1 {
    static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }
    static func foo(): Int64 { 0 }
}"##))

    var interfaceDecl: InterfaceDecl = (sourcefile.topLevelDecls[0] as InterfaceDecl).getOrThrow()
    @Expect(interfaceDecl.toString().replace("\r",""), ##"@Deprecated["aaa"]
public interface I1 <: S1 {
    static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }
    static func foo(): Int64 { 0 }
}"##)
    @Assert(interfaceDecl.body.memberDecls.size, 2)
    @Assert(interfaceDecl.body.memberDecls[0] is PropDecl)
    @Assert(interfaceDecl.body.memberDecls[0].toString().replace("\r",""), ##"static mut prop p1: Int64 {
        get() {0}
        set(v) {}
    }"##)
    @Assert(interfaceDecl.body.memberDecls[1] is FuncDecl)
    @Assert(interfaceDecl.body.memberDecls[1].toString(), ##"static func foo(): Int64 { 0 }"##)

    @Assert(interfaceDecl.name, "I1")
    @Assert(interfaceDecl.genericConstraints.isNone())
    @Assert(interfaceDecl.genericParams.size, 0)
    @Assert(interfaceDecl.superTyAnnotations.size, 1)
    @Assert(interfaceDecl.superTyAnnotations[0].toString(), "S1")
    @Assert(interfaceDecl.annotations.size, 1)
    @Assert(interfaceDecl.annotations[0].toString(), ##"@Deprecated["aaa"]"##)
}
}