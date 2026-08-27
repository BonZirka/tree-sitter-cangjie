/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: FuncDecl_03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_03() {
    let res = parseFile("./FuncDecl_03.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"class Point {
    public init (a: Int64, b!: Int64) {
        x = a
        y = b
    }
    public operator func -(): Point {
        Point(-x, -y)
    }
    public operator func +(right: Point): Point {
        Point(this.x + right.x, this.y + right.y)
    }
    ~init() {}
}"##))

    var _decl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()

    var funcdecl_1 = (_decl.body.memberDecls[0] as FuncDecl).getOrThrow()
    @Assert(funcdecl_1.toString().replace("\r",""), ##"public init (a: Int64, b!: Int64) {
        x = a
        y = b
    }"##)
    @Assert(funcdecl_1.body.isSome())
    @Assert(funcdecl_1.body.getOrThrow().toString().replace("\r",""), ##"{
        x = a
        y = b
    }"##)
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case Constructor => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "init")
    @Assert(funcdecl_1.params.params.size, 2)
    @Assert(funcdecl_1.params.params[0].toString(), "a: Int64")
    @Assert(funcdecl_1.params.params[1].toString(), "b!: Int64")
    @Assert(funcdecl_1.retTyAnnotation.isNone())
    @Assert(funcdecl_1.modifiers.toString(), "[public]")
    @Assert(funcdecl_1.annotations.toString(), "[]")

    var funcdecl_2 = (_decl.body.memberDecls[1] as FuncDecl).getOrThrow()
    @Assert(funcdecl_2.toString().replace("\r",""), ##"public operator func -(): Point {
        Point(-x, -y)
    }"##)
    @Assert(funcdecl_2.body.isSome())
    @Assert(funcdecl_2.body.getOrThrow().toString().replace("\r",""), ##"{
        Point(-x, -y)
    }"##)
    @Assert(funcdecl_2.genericConstraints.isNone())
    @Assert(funcdecl_2.genericParams.size, 0)
    match (funcdecl_2.kind) {
        case Operator => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_2.name, "-")
    @Assert(funcdecl_2.params.params.size, 0)
    @Assert(funcdecl_2.retTyAnnotation.isSome())
    @Assert(funcdecl_2.retTyAnnotation.getOrThrow() is CompositeType)
    @Assert(funcdecl_2.modifiers.toString(), "[public, operator]")
    @Assert(funcdecl_2.annotations.toString(), "[]")

    var funcdecl_3 = (_decl.body.memberDecls[2] as FuncDecl).getOrThrow()
    @Assert(funcdecl_3.toString().replace("\r",""), ##"public operator func +(right: Point): Point {
        Point(this.x + right.x, this.y + right.y)
    }"##)
    @Assert(funcdecl_3.body.isSome())
    @Assert(funcdecl_3.body.getOrThrow().toString().replace("\r",""), ##"{
        Point(this.x + right.x, this.y + right.y)
    }"##)
    @Assert(funcdecl_3.genericConstraints.isNone())
    @Assert(funcdecl_3.genericParams.size, 0)
    match (funcdecl_3.kind) {
        case Operator => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_3.name, "+")
    @Assert(funcdecl_3.params.params.size, 1)
    @Assert(funcdecl_3.params.params[0].toString(), "right: Point")
    @Assert(funcdecl_3.retTyAnnotation.isSome())
    @Assert(funcdecl_3.retTyAnnotation.getOrThrow() is CompositeType)
    @Assert(funcdecl_3.modifiers.toString(), "[public, operator]")
    @Assert(funcdecl_3.annotations.toString(), "[]")

    var funcdecl_4 = (_decl.body.memberDecls[3] as FuncDecl).getOrThrow()
    @Assert(funcdecl_4.toString(), ##"~init() {}"##)
    @Assert(funcdecl_4.body.isSome())
    @Assert(funcdecl_4.body.getOrThrow().toString(), ##"{}"##)
    @Assert(funcdecl_4.genericConstraints.isNone())
    @Assert(funcdecl_4.genericParams.size, 0)
    match (funcdecl_4.kind) {
        case Finalizer => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_4.name, "~init")
    @Assert(funcdecl_4.params.params.size, 0)
    @Assert(funcdecl_4.retTyAnnotation.isNone())
    @Assert(funcdecl_4.modifiers.toString(), "[]")
    @Assert(funcdecl_4.annotations.toString(), "[]")
}
}