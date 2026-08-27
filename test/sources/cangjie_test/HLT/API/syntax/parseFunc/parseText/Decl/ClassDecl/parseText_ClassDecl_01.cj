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

let str = ##"@Deprecated["cangjie"]
public class S1<T> <: I1<T> where T <: ToString{
    public let s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo(a: T): T {
        return a
    }
}"##

@Test
class test_01{
    @TestCase
func test_ClassDecl_01() {
    let res = parseText(str)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var classDecl: ClassDecl = (sourceNode as ClassDecl).getOrThrow()
    
    @Assert(classDecl.toString().replace("\r",""), ##"@Deprecated["cangjie"]
public class S1<T> <: I1<T> where T <: ToString{
    public let s1: Int64 = 0
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo(a: T): T {
        return a
    }
}"##)
    @Assert(classDecl.body.memberDecls.size, 4)
    @Assert(classDecl.body.memberDecls[0] is VarDecl)
    @Assert(classDecl.body.memberDecls[0].toString(), ##"public let s1: Int64 = 0"##)
    @Assert(classDecl.body.memberDecls[1] is PropDecl)
    @Assert(classDecl.body.memberDecls[1].toString().replace("\r",""), ##"prop p1: Int64 {
        get() { 0 }
    }"##)
    @Assert(classDecl.body.memberDecls[2] is FuncDecl)
    @Assert(classDecl.body.memberDecls[2].toString(), ##"public init() {}"##)
    @Assert(classDecl.body.memberDecls[3] is FuncDecl)
    @Assert(classDecl.body.memberDecls[3].toString().replace("\r",""), ##"func foo(a: T): T {
        return a
    }"##)

    @Assert(classDecl.name, "S1")
    @Assert(classDecl.genericConstraints.isSome())
    @Assert(classDecl.genericConstraints.getOrThrow().toString(), "where T <: ToString")
    @Assert(classDecl.genericParams.size, 1)
    @Assert(classDecl.genericParams[0].toString(), "T")
    @Assert(classDecl.superTyAnnotations.size, 1)
    @Assert(classDecl.superTyAnnotations[0].toString(), "I1<T>")
    @Assert(classDecl.annotations.size, 1)
    @Assert(classDecl.annotations[0].toString(), ##"@Deprecated["cangjie"]"##)

    @Assert(classDecl.nodePos.beginLine, 1)
    @Assert(classDecl.nodePos.beginColumn, 1)
    @Assert(classDecl.nodePos.endLine, 11)
    @Assert(classDecl.nodePos.endColumn, 2)
    @Assert(classDecl.nodePos.fileName, "")
    @Assert(classDecl.nodePos.filePath, "")

    var pos = classDecl.getClassKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 8i32, 2i32, 13i32])
    @Assert(classDecl.getGenericParamsCommasPos().size, 0)
    pos = classDecl.getGenericParamsLAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 16i32, 2i32, 17i32])
    pos = classDecl.getGenericParamsRAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 18i32, 2i32, 19i32])
    pos = classDecl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 14i32, 2i32, 16i32])
    @Assert(classDecl.getSuperTyAnnotationsBitAndsPos().size, 0)
    pos = classDecl.getUpperBoundPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 20i32, 2i32, 22i32])
}
}