/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: PropDecl_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PropDecl_03() {
    let res = parseFile("./PropDecl_03.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"public class CCC{
    @Deprecated["a"]
    private static prop p1: ?Int64 {
        get() { Some(0) }
    }
    @Deprecated["a"]
    @Frozen
    internal static mut prop p2: ?T {
        get() { none }
        set(value) {1 + 1}
    }
}"##))

    var classDecl: ClassDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    @Assert(classDecl.body.memberDecls.size, 2)
    let prop_1 = (classDecl.body.memberDecls[0] as PropDecl).getOrThrow()
    let prop_2 = (classDecl.body.memberDecls[1] as PropDecl).getOrThrow()
    @Assert(prop_1.toString().replace("\r",""), ##"@Deprecated["a"]
    private static prop p1: ?Int64 {
        get() { Some(0) }
    }"##)
    @Assert(prop_1.name, "p1")
    @Assert(prop_1.getter.getOrThrow().toString(), "get() { Some(0) }")
    @Assert(prop_1.setter.isNone())
    @Assert(prop_1.tyAnnotation.toString(), "?Int64")
    @Assert(prop_1.tyAnnotation is PrefixType)
    @Expect(prop_1.isMut, false)
    @Assert(prop_1.modifiers.toString(), "[private, static]")
    @Assert(prop_1.annotations.toString(), ##"[@Deprecated["a"]]"##)

    @Expect(prop_2.toString().replace("\r",""), ##"@Deprecated["a"]
    @Frozen
    internal static mut prop p2: ?T {
        get() { none }
        set(value) {1 + 1}
    }"##)
    @Assert(prop_2.name, "p2")
    @Assert(prop_2.getter.getOrThrow().toString(), "get() { none }")
    @Assert(prop_2.setter.isSome())
    @Assert(prop_2.setter.getOrThrow().toString(), "set(value) {1 + 1}")
    @Assert(prop_2.tyAnnotation.toString(), "?T")
    @Assert(prop_2.tyAnnotation is PrefixType)
    @Assert(prop_2.isMut)
    @Assert(prop_2.modifiers.toString(), "[internal, static, mut]")
    @Assert(prop_2.annotations.toString(), ##"[@Deprecated["a"], @Frozen]"##)
}
}