 /*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let str = ##"@Deprecated["aaa"]
enum E1 {
    A1 | B1 | C1(Int64) | D1(Int64, String) | ...
    prop p1: Int64 {
        get() {0}
    }
    func foo() {}
}"##

@Test
class test_01{
    @TestCase
func test_EnumDecl_01() {
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var enumDecl: EnumDecl = (sourceNode as EnumDecl).getOrThrow()

    @Expect(enumDecl.toString().replace("\r",""), ##"@Deprecated["aaa"]
enum E1 {
    A1 | B1 | C1(Int64) | D1(Int64, String) | ...
    prop p1: Int64 {
        get() {0}
    }
    func foo() {}
}"##)
    @Assert(enumDecl.body.memberDecls.size, 6)
    @Assert(enumDecl.body.memberDecls[0] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[0].toString(), ##"A1"##)
    @Assert(enumDecl.body.memberDecls[1] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[1].toString(), ##"B1"##)
    @Assert(enumDecl.body.memberDecls[2] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[2].toString(), ##"C1(Int64)"##)
    @Assert(enumDecl.body.memberDecls[3] is EnumConstructor)
    @Assert(enumDecl.body.memberDecls[3].toString(), ##"D1(Int64, String)"##)

    @Assert(enumDecl.body.memberDecls[4] is PropDecl)
    @Assert(enumDecl.body.memberDecls[4].toString().replace("\r",""), ##"prop p1: Int64 {
        get() {0}
    }"##)
    @Assert(enumDecl.body.memberDecls[5] is FuncDecl)
    @Assert(enumDecl.body.memberDecls[5].toString().replace("\r",""), ##"func foo() {}"##)

    @Assert(enumDecl.name, "E1")
    @Assert(enumDecl.isNonExhaustive, true)
    @Assert(enumDecl.genericConstraints.isNone())
    @Assert(enumDecl.genericParams.size, 0)
    @Assert(enumDecl.superTyAnnotations.size, 0)
    @Assert(enumDecl.annotations.size, 1)
    @Assert(enumDecl.annotations[0].toString(), ##"@Deprecated["aaa"]"##)

    var posList: Array<CodePositionRange> = enumDecl.getCaseSeparatorsPos()
    @Assert(posList.size, 4)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [3i32, 8i32, 3i32, 9i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [3i32, 13i32, 3i32, 14i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [3i32, 25i32, 3i32, 26i32])
    @Assert([posList[3].beginLine, posList[3].beginColumn, posList[3].endLine, posList[3].endColumn], [3i32, 45i32, 3i32, 46i32])
    var pos = enumDecl.getEnumKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 1i32, 2i32, 5i32])
    @Assert(enumDecl.getGenericParamsCommasPos().size, 0)
    @Assert(enumDecl.getGenericParamsLAnglePos().isNone(), true)
    @Assert(enumDecl.getGenericParamsRAnglePos().isNone(), true)
    pos = enumDecl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 6i32, 2i32, 8i32])
    pos = enumDecl.getNonExhaustiveTripleDotPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [3i32, 47i32, 3i32, 50i32])
    @Assert(enumDecl.getSuperTyAnnotationsBitAndsPos().size == 0, true)
    @Assert(enumDecl.getUpperBoundPos().isNone(), true)
}
}