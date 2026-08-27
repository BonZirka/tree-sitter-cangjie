/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: Annotation_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_Annotation_01() {
    let res = parseFile("./Annotation_01.cj")

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"@Deprecated ["abc"] var a = 1
@Deprecated ["abccangjie", strict : false] var a = 2"##))

    var decl_1: VarDecl = (sourcefile.topLevelDecls[0] as VarDecl).getOrThrow()
    @Assert(decl_1.toString(), ##"@Deprecated ["abc"] var a = 1"##)
    let anno_1: Annotation = decl_1.annotations[0]
    @Assert(anno_1.toString(), ##"@Deprecated ["abc"]"##)
    @Assert(anno_1.arguments.toString(), ##"["abc"]"##)
    @Assert(anno_1.identifier.toString(), ##"Deprecated"##)

    var decl_2: VarDecl = (sourcefile.topLevelDecls[1] as VarDecl).getOrThrow()
    @Assert(decl_2.toString(), ##"@Deprecated ["abccangjie", strict : false] var a = 2"##)
    let anno_2: Annotation = decl_2.annotations[0]
    @Assert(anno_2.toString(), ##"@Deprecated ["abccangjie", strict : false]"##)
    @Assert(anno_2.arguments.toString(), ##"["abccangjie", strict : false]"##)
    @Assert(anno_2.identifier.toString(), ##"Deprecated"##)

    var pos = anno_2.getAtOpPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 1i32, 10i32, 2i32])
    var posList = anno_2.getCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [10i32, 26i32, 10i32, 27i32])
    pos = anno_2.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 2i32, 10i32, 12i32])
    pos = anno_2.getLSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 13i32, 10i32, 14i32])
    pos = anno_2.getRSquarePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [10i32, 42i32, 10i32, 43i32])
}
}