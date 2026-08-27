/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Annotation_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Annotation_05() {
    let res = parseFile("./Annotation_05.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    sourcefile.toString() |> println
    @Expect(sourcefile.toString().replace("\r","").contains(##"@!Anno1 var a = 1
@!Anno1[aaaaa] var a = 1
@!Anno1[a: "abcd", b: 1] var a = 1"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    @Assert(decl_1.toString(), ##"@!Anno1 var a = 1"##)
    let anno_1: Annotation = decl_1.annotations[0]
    @Assert(anno_1.toString(), ##"@!Anno1"##)
    @Assert(anno_1.arguments.toString(), ##"[]"##)
    @Assert(anno_1.identifier.toString(), ##"Anno1"##)

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    @Assert(decl_2.toString(), ##"@!Anno1[aaaaa] var a = 1"##)
    let anno_2: Annotation = decl_2.annotations[0]
    @Assert(anno_2.toString(), ##"@!Anno1[aaaaa]"##)
    @Assert(anno_2.arguments.toString(), ##"[aaaaa]"##)
    @Assert(anno_2.identifier.toString(), ##"Anno1"##)

    var decl_3: VarDecl = (sourcefile.topLevelDecls[2] as VarDecl).getOrThrow()
    @Assert(decl_3.toString(), ##"@!Anno1[a: "abcd", b: 1] var a = 1"##)
    let anno_3: Annotation = decl_3.annotations[0]
    @Assert(anno_3.toString(), ##"@!Anno1[a: "abcd", b: 1]"##)
    @Assert(anno_3.arguments.toString(), ##"[a: "abcd", b: 1]"##)
    @Assert(anno_3.identifier.toString(), ##"Anno1"##)

    var posList = anno_3.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [11i32, 18i32, 11i32, 19i32])
}
}