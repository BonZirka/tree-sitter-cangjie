/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: EnumConstructor_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_EnumConstructor_01() {
    let res = parseFile("./EnumConstructor_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"enum EE<T> {
    | A0
    | B_C_D
    | A1(Int64)
    | A2(T)
    | A3(Int64, R1, String)
    | Day(Int32, Float32, Float32)
    | @Deprecated["dddd"] DDDD
}"##))

    var enumDecl: EnumDecl = (sourcefile.topLevelDecls[0] as EnumDecl).getOrThrow()

    @Assert(enumDecl.body.memberDecls.size, 7)
    let c_1 = (enumDecl.body.memberDecls[0] as EnumConstructor).getOrThrow()
    @Assert(c_1.toString(), "A0")
    @Assert(c_1.name, "A0")
    @Assert(c_1.paramTyAnnotations.size, 0)

    let c_2 = (enumDecl.body.memberDecls[1] as EnumConstructor).getOrThrow()
    @Assert(c_2.toString(), "B_C_D")
    @Assert(c_2.name, "B_C_D")
    @Assert(c_2.paramTyAnnotations.size, 0)

    let c_3 = (enumDecl.body.memberDecls[2] as EnumConstructor).getOrThrow()
    @Assert(c_3.toString(), "A1(Int64)")
    @Assert(c_3.name, "A1")
    @Assert(c_3.paramTyAnnotations.size, 1)
    @Assert(c_3.paramTyAnnotations[0] is AtomicType)

    let c_4 = (enumDecl.body.memberDecls[3] as EnumConstructor).getOrThrow()
    @Assert(c_4.toString(), "A2(T)")
    @Assert(c_4.name, "A2")
    @Assert(c_4.paramTyAnnotations.size, 1)
    @Assert(c_4.paramTyAnnotations[0] is CompositeType)

    let c_5 = (enumDecl.body.memberDecls[4] as EnumConstructor).getOrThrow()
    @Assert(c_5.toString(), "A3(Int64, R1, String)")
    @Assert(c_5.name, "A3")
    @Assert(c_5.paramTyAnnotations.size, 3)
    @Assert(c_5.paramTyAnnotations[0].toString(), "Int64")
    @Assert(c_5.paramTyAnnotations[1].toString(), "R1")
    @Assert(c_5.paramTyAnnotations[2].toString(), "String")

    let c_6 = (enumDecl.body.memberDecls[5] as EnumConstructor).getOrThrow()
    @Assert(c_6.toString(), "Day(Int32, Float32, Float32)")
    @Assert(c_6.toTokens().toString(), "Day(Int32, Float32, Float32)")
    @Assert(c_6.name, "Day")
    @Assert(c_6.paramTyAnnotations.size, 3)
    @Assert(c_6.paramTyAnnotations[0].toString(), "Int32")
    @Assert(c_6.paramTyAnnotations[1].toString(), "Float32")
    @Assert(c_6.paramTyAnnotations[2].toString(), "Float32")

    let c_7 = (enumDecl.body.memberDecls[6] as EnumConstructor).getOrThrow()
    @Assert(c_7.toString(), ##"@Deprecated["dddd"] DDDD"##)
    @Assert(c_7.name, "DDDD")
    @Assert(c_7.paramTyAnnotations.size, 0)
    @Assert(c_7.annotations.toString(), ##"[@Deprecated["dddd"]]"##)
    @Assert(c_7.modifiers.toString(), "[]")

    var posList: Array<CodePositionRange> = enumDecl.getCaseSeparatorsPos()
    @Assert(posList.size, 7)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [10i32, 5i32, 10i32, 6i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [11i32, 5i32, 11i32, 6i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [12i32, 5i32, 12i32, 6i32])
    @Assert([posList[3].beginLine, posList[3].beginColumn, posList[3].endLine, posList[3].endColumn], [13i32, 5i32, 13i32, 6i32])
    @Assert([posList[4].beginLine, posList[4].beginColumn, posList[4].endLine, posList[4].endColumn], [14i32, 5i32, 14i32, 6i32])
    @Assert([posList[5].beginLine, posList[5].beginColumn, posList[5].endLine, posList[5].endColumn], [15i32, 5i32, 15i32, 6i32])
    @Assert([posList[6].beginLine, posList[6].beginColumn, posList[6].endLine, posList[6].endColumn], [16i32, 5i32, 16i32, 6i32])
    var pos = enumDecl.getEnumKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 1i32, 9i32, 5i32])
    @Assert(enumDecl.getGenericParamsCommasPos().size, 0)
    pos = enumDecl.getGenericParamsLAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 8i32, 9i32, 9i32])
    pos = enumDecl.getGenericParamsRAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 10i32, 9i32, 11i32])
    pos = enumDecl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 6i32, 9i32, 8i32])
    @Assert(enumDecl.getNonExhaustiveTripleDotPos().isNone(), true)
    @Assert(enumDecl.getSuperTyAnnotationsBitAndsPos().size == 0, true)
    @Assert(enumDecl.getUpperBoundPos().isNone(), true)

    pos = c_6.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [15i32, 7i32, 15i32, 10i32])
    posList = c_6.getParamsCommasPos()
    @Assert(posList.size == 2, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [15i32, 16i32, 15i32, 17i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [15i32, 25i32, 15i32, 26i32])
    pos = c_6.getParamsLParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [15i32, 10i32, 15i32, 11i32])
    pos = c_6.getParamsRParenPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [15i32, 34i32, 15i32, 35i32])
}
}