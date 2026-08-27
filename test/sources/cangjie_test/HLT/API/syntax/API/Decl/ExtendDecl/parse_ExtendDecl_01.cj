/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ExtendDecl_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_ExtendDecl_01() {
    let res = parseFile("./ExtendDecl_01.cj")
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"extend<T, U> C1<T, U> <: I1 & I2<T> & I3 where U <: I1 & I3, T <: I1{
    @Deprecated["a"]
    static func foo() {}
    @Deprecated["b"]
    static prop p1: Int64 {
        get() {0}
    }
}"##))

    var extendDecl: ExtendDecl = (sourcefile.topLevelDecls[0] as ExtendDecl).getOrThrow()
    @Assert(extendDecl.toString().replace("\r",""), ##"extend<T, U> C1<T, U> <: I1 & I2<T> & I3 where U <: I1 & I3, T <: I1{
    @Deprecated["a"]
    static func foo() {}
    @Deprecated["b"]
    static prop p1: Int64 {
        get() {0}
    }
}"##)
    @Assert(extendDecl.toTokens().toString().replace("\r",""), ##"extend < T, U > C1 < T, U > <: I1 & I2 < T > & I3 where U <: I1 & I3, T <: I1 {
    @Deprecated["a"]
    static func foo() { }
    @Deprecated["b"]
    static prop p1: Int64 {
        get() { 0 }
    }
}"##)
    @Assert(extendDecl.body.memberDecls.size, 2)
    @Assert(extendDecl.body.memberDecls[0] is FuncDecl)
    @Assert(extendDecl.body.memberDecls[0].toString().replace("\r",""), ##"@Deprecated["a"]
    static func foo() {}"##)
    @Assert(extendDecl.body.memberDecls[1] is PropDecl)
    @Assert(extendDecl.body.memberDecls[1].toString().replace("\r",""), ##"@Deprecated["b"]
    static prop p1: Int64 {
        get() {0}
    }"##)

    @Assert(extendDecl.extendedTyAnnotation is CompositeType)
    @Assert(extendDecl.extendedTyAnnotation.toString(), "C1<T, U>")
    @Assert(extendDecl.genericConstraints.isSome())
    @Assert(extendDecl.genericConstraints.getOrThrow().toString(), "where U <: I1 & I3, T <: I1")
    @Assert(extendDecl.genericParams.size, 2)
    @Assert(extendDecl.genericParams[0].toString(), "T")
    @Assert(extendDecl.genericParams[1].toString(), "U")
    @Assert(extendDecl.superTyAnnotations.size, 3)
    @Assert(extendDecl.superTyAnnotations[0].toString(), "I1")
    @Assert(extendDecl.superTyAnnotations[1].toString(), "I2<T>")
    @Assert(extendDecl.superTyAnnotations[2].toString(), "I3")
    @Assert(extendDecl.annotations.size, 0)
    @Assert(extendDecl.modifiers.size, 0)

    var pos = extendDecl.getExtendKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 1i32, 9i32, 7i32])
    var posList = extendDecl.getGenericParamsCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 9i32, 9i32, 10i32])
    pos = extendDecl.getGenericParamsLAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 7i32, 9i32, 8i32])
    pos = extendDecl.getGenericParamsRAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 12i32, 9i32, 13i32])
    posList = extendDecl.getSuperTyAnnotationsBitAndsPos()
    @Assert(posList.size == 2, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 29i32, 9i32, 30i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [9i32, 37i32, 9i32, 38i32])
    pos = extendDecl.getUpperBoundPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 23i32, 9i32, 25i32])
}
}