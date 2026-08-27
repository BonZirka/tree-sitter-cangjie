/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1 EXCLUDE
// DEPENDENCE: Annotation_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Annotation_03() {
    let res = parseFile("./Annotation_03.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Expect(sourcefile.toString().replace("\r","").contains(##"@Attribute[State] var cnt = 0
@Attribute["Binding"] var bcnt = 0"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    @Assert(decl_1.toString(), ##"@Attribute[State] var cnt = 0"##)
    let anno_1: Annotation = decl_1.annotations[0]
    @Assert(anno_1.toString(), ##"@Attribute[State]"##)
    @Assert(anno_1.arguments.toString(), ##"[State]"##)
    @Assert(anno_1.identifier.toString(), ##"Attribute"##)

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    @Assert(decl_2.toString(), ##"@Attribute["Binding"] var bcnt = 0"##)
    let anno_2: Annotation = decl_2.annotations[0]
    @Assert(anno_2.toString(), ##"@Attribute["Binding"]"##)
    @Assert(anno_2.arguments.toString(), ##"["Binding"]"##)
    @Assert(anno_2.identifier.toString(), ##"Attribute"##)
}
}