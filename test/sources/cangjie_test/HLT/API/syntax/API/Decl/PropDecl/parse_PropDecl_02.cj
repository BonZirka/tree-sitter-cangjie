/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: PropDecl_02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PropDecl_02() {
    let res = parseFile("./PropDecl_02.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"public interface I1 {
    public mut prop p1: Int64
    public prop p2: R
}"##))

    var interfaceDecl: InterfaceDecl = (sourcefile.topLevelDecls[0] as InterfaceDecl).getOrThrow()

    @Expect(interfaceDecl.body.memberDecls.size, 2)
    let prop_1 = (interfaceDecl.body.memberDecls[0] as PropDecl).getOrThrow()
    let prop_2 = (interfaceDecl.body.memberDecls[1] as PropDecl).getOrThrow()
    @Expect(prop_1.toString(), ##"public mut prop p1: Int64"##)
    @Assert(prop_1.name, "p1")
    @Expect(prop_1.getter.isNone())
    @Assert(prop_1.setter.isNone())
    @Assert(prop_1.tyAnnotation.toString(), "Int64")
    @Assert(prop_1.tyAnnotation is AtomicType)
    @Assert(prop_1.isMut)

    @Expect(prop_2.toString(), ##"public prop p2: R"##)
    @Assert(prop_2.name, "p2")
    @Expect(prop_2.getter.isNone())
    @Assert(prop_2.setter.isNone())
    @Assert(prop_2.tyAnnotation.toString(), "R")
    @Assert(prop_2.tyAnnotation is CompositeType)
    @Assert(prop_2.isMut, false)
}
}