/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: PropGetterOrSetter_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PropGetterOrSetter_01() {
    let res = parseFile("./PropGetterOrSetter_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"public interface I1 <: S1 {
    public static mut prop p_1: Int64 {
        get() {0}
        @Deprecated["bbbb"]
        set(v) {}
    }
}"##))

    var interfaceDecl: InterfaceDecl = (sourcefile.topLevelDecls[0] as InterfaceDecl).getOrThrow()
    @Assert(interfaceDecl.body.memberDecls.size, 1)
    let prop_1 = (interfaceDecl.body.memberDecls[0] as PropDecl).getOrThrow()
    let prop_1_getter = prop_1.getter.getOrThrow()
    let prop_1_setter = prop_1.setter.getOrThrow()
    @Assert(prop_1_getter.toTokens().toString(), "get() { 0 }")
    @Assert(prop_1_getter.block.toString(), "{0}")
    @Assert(prop_1_getter.identifier.isNone())
    @Assert(prop_1_getter.isGetter)
    @Assert(prop_1_getter.annotations.size, 0)

    @Assert(prop_1_setter.block.toString(), "{}")
    @Assert(prop_1_setter.identifier.getOrThrow(), "v")
    @Assert(prop_1_setter.isGetter, false)
    @Assert(prop_1_setter.annotations.toString(), ##"[@Deprecated["bbbb"]]"##)

    var pos = prop_1_getter.getGetKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 9i32, 11i32, 12i32])
    @Assert(prop_1_getter.getIdentifierPos().isNone(), true)
    pos = prop_1_getter.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 12i32, 11i32, 13i32])
    pos = prop_1_getter.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [11i32, 13i32, 11i32, 14i32])
    pos = prop_1_setter.getSetKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [13i32, 9i32, 13i32, 12i32])
}
}