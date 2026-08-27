/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

let _quote = quote(@When[os == "Linux"]
internal class C1<T, U> <: I1<U> & I2<T, U> & I3<T> where T <: I1<T> & I3<T> , U<: I2<T, T> {
    static let s1: Int64
    static init() {
        s1 = 1
    }
    public init(a!: UInt64, b!: Int64 = 0) {}
    public C1(a: Int64) {

    }
    prop p1: Int64 {
        get() { 0 }
    }
    public init() {}
    func foo<S>(a: T, b: S): T {
        return a
    }
    ~init() {}
})

@Test
class test_01{
    @TestCase
func test_ClassDecl_03() {
    let res = parseTokens(_quote)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()
    var classDecl: ClassDecl = (sourceNode as ClassDecl).getOrThrow()
    @Assert(classDecl.toString().replace("\r",""), ##"@When[os == "Linux"]
internal class C1 < T, U > <: I1 < U > & I2 < T, U > & I3 < T > where T <: I1 < T > & I3 < T >, U <: I2 < T, T > {
    static let s1: Int64
    static init() {
        s1 = 1
    }
    public init(a!: UInt64, b!: Int64 = 0) { }
    public C1(a: Int64) {

    }
    prop p1: Int64 {
        get() { 0 }
    }
    public init() { }
    func foo < S >(a: T, b: S): T {
        return a
    }
    ~init() { }
}"##)
    @Assert(classDecl.body.memberDecls.size, 8)
    @Assert(classDecl.body.memberDecls[0] is VarDecl)
    @Assert(classDecl.body.memberDecls[0].toString(), ##"static let s1: Int64"##)
    @Assert(classDecl.body.memberDecls[1] is StaticInit)
    @Assert(classDecl.body.memberDecls[1].toString().replace("\r",""), ##"static init() {
        s1 = 1
    }"##)
    @Assert(classDecl.body.memberDecls[2] is FuncDecl)
    @Assert(classDecl.body.memberDecls[2].toString(), ##"public init(a!: UInt64, b!: Int64 = 0) { }"##)
    @Assert(classDecl.body.memberDecls[3] is FuncDecl)
    @Assert(classDecl.body.memberDecls[3].toString().replace("\r",""), ##"public C1(a: Int64) {

    }"##)
    @Assert(classDecl.body.memberDecls[4] is PropDecl)
    @Assert(classDecl.body.memberDecls[4].toString().replace("\r",""), ##"prop p1: Int64 {
        get() { 0 }
    }"##)
    @Assert(classDecl.body.memberDecls[5] is FuncDecl)
    @Assert(classDecl.body.memberDecls[5].toString(), ##"public init() { }"##)
    @Assert(classDecl.body.memberDecls[6] is FuncDecl)
    @Assert(classDecl.body.memberDecls[6].toString().replace("\r",""), ##"func foo < S >(a: T, b: S): T {
        return a
    }"##)
    @Assert(classDecl.body.memberDecls[7] is FuncDecl)
    @Assert(classDecl.body.memberDecls[7].toString(), ##"~init() { }"##)

    @Assert(classDecl.name, "C1")
    @Assert(classDecl.genericConstraints.isSome())
    @Assert(classDecl.genericConstraints.getOrThrow().toString(), "where T <: I1 < T > & I3 < T >, U <: I2 < T, T >")
    @Assert(classDecl.genericParams.size, 2)
    @Assert(classDecl.genericParams[0].toString(), "T")
    @Assert(classDecl.genericParams[1].toString(), "U")
    @Assert(classDecl.superTyAnnotations.size, 3)
    @Assert(classDecl.superTyAnnotations[0].toString(), "I1 < U >")
    @Assert(classDecl.superTyAnnotations[1].toString(), "I2 < T, U >")
    @Assert(classDecl.superTyAnnotations[2].toString(), "I3 < T >")
    @Assert(classDecl.annotations.size, 1)
    @Assert(classDecl.annotations[0].toString(), ##"@When[os == "Linux"]"##)

    var pos = classDecl.getClassKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 10i32, 2i32, 15i32])
    @Assert(classDecl.getGenericParamsCommasPos().size, 1)
    pos = classDecl.getGenericParamsCommasPos()[0]
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 22i32, 2i32, 23i32])
    pos = classDecl.getGenericParamsLAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 19i32, 2i32, 20i32])
    pos = classDecl.getGenericParamsRAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 26i32, 2i32, 27i32])
    pos = classDecl.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 16i32, 2i32, 18i32])
    @Assert(classDecl.getSuperTyAnnotationsBitAndsPos().size, 2)
    pos = classDecl.getSuperTyAnnotationsBitAndsPos()[0]
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 40i32, 2i32, 41i32])
    pos = classDecl.getSuperTyAnnotationsBitAndsPos()[1]
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 54i32, 2i32, 55i32])
    pos = classDecl.getUpperBoundPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [2i32, 28i32, 2i32, 30i32])
}
}