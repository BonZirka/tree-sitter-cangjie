/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Annotation_04.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Annotation_04() {
    let res = parseFile("./Annotation_04.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Expect(sourcefile.toString().replace("\r","").contains(##"@When[os == "Linux"] var a = 1
@When [backend == "cjnative"] var a = 1"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    @Assert(decl_1.toString(), ##"@When[os == "Linux"] var a = 1"##)
    let anno_1: Annotation = decl_1.annotations[0]
    @Assert(anno_1.toString(), ##"@When[os == "Linux"]"##)
    @Assert(anno_1.arguments.toString(), ##"[os == "Linux"]"##)
    @Assert(anno_1.identifier.toString(), ##"When"##)

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    @Assert(decl_2.toString(), ##"@When [backend == "cjnative"] var a = 1"##)
    let anno_2: Annotation = decl_2.annotations[0]
    @Assert(anno_2.toString(), ##"@When [backend == "cjnative"]"##)
    @Assert(anno_2.arguments.toString(), ##"[backend == "cjnative"]"##)
    @Assert(anno_2.identifier.toString(), ##"When"##)
}
}