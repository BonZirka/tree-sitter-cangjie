/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: sourceFile/class_decl.cj
// (not Windows) EXEC: dos2unix class_decl.cj
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args

import stdx.syntax.*
import std.fs.*
import std.collection.ArrayList

@Test
class Test {
    var decls: Array<Decl> = []

    @BeforeAll
    func readDecls(): Unit {
        let node = parseFile("class_decl.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        decls = file.topLevelDecls
    }

    @TestCase
    func testDecl01() {
        let decl = (decls[0] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 0)
        @Expect(decl.name, "A")
        @Expect(decl.superTyAnnotations.size, 0)
        @Expect(decl.genericParams.size, 0)
        @Expect(decl.genericConstraints.isNone())
        @Expect(decl.body.toString().replace("\r\n", "\n"), "{}")
        @Expect(decl.toString().replace("\r\n", "\n"), "class A {}")
        var pos = decl.getClassKeyWordPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 6]).toArray())
        pos = decl.getIdentifierPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 7, 1, 8]).toArray())
        @Expect(decl.getGenericParamsLAnglePos().isNone())
        @Expect(decl.getGenericParamsCommasPos().size, 0)
        @Expect(decl.getGenericParamsRAnglePos().isNone())
        @Expect(decl.getUpperBoundPos().isNone())
        @Expect(decl.getSuperTyAnnotationsBitAndsPos().size, 0)
        pos = decl.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 11]).toArray())
        @Expect(decl.toTokens().toString().replace("\r\n", "\n"), "class A { }")
        @Expect(parseTokens(decl.toTokens(), refreshPos: false).node.getOrThrow().toString().replace("\r\n", "\n"), decl.toString().replace("\r\n", "\n"))
    }

    @TestCase
    func testDecl02() {
        let decl = (decls[1] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 2)
        @Expect(decl.name, "B")
        @Expect(decl.superTyAnnotations.size, 0)
        @Expect(decl.genericParams.size, 0)
        @Expect(decl.genericConstraints.isNone())
        @Expect(decl.body.toString().replace("\r\n", "\n"), """
{
    var a = 1
}""")
        @Expect(decl.toString().replace("\r\n", "\n"), """
public abstract class B {
    var a = 1
}""")
        @Expect(decl.toTokens().toString().replace("\r\n", "\n"), decl.toString().replace("\r\n", "\n"))
    }

    @TestCase
    func testDecl03() {
        let decl = (decls[2] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 1)
        @Expect(decl.name, "C")
        @Expect(decl.superTyAnnotations.size, 1)
        @Expect(decl.superTyAnnotations[0].toString().replace("\r\n", "\n"), "B")
        @Expect(decl.genericParams.size, 0)
        @Expect(decl.genericConstraints.isNone())
        @Expect(decl.body.toString().replace("\r\n", "\n"), "{}")
        @Expect(decl.toString().replace("\r\n", "\n"), "open class C <: B {}")
    }

    @TestCase
    func testDecl04() {
        let decl = (decls[3] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 0)
        @Expect(decl.name, "D")
        @Expect(decl.superTyAnnotations.size, 0)
        @Expect(decl.genericParams.size, 1)
        @Expect(decl.genericParams[0].name, "T")
        let genericConstraints = decl.genericConstraints.getOrThrow()
        @Expect(genericConstraints.constraints.size, 1)
        @Expect(genericConstraints.constraints[0].toString().replace("\r\n", "\n"), "T <: B")
        @Expect(decl.body.toString().replace("\r\n", "\n"), "{}")
        @Expect(decl.toString().replace("\r\n", "\n"), "class D<T> where T <: B {}")
    }

    @TestCase
    func testDecl05() {
        let decl = (decls[4] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 1)
        @Expect(decl.name, "E")
        @Expect(decl.superTyAnnotations.size, 2)
        @Expect(decl.superTyAnnotations[0].toString().replace("\r\n", "\n"), "ToString")
        @Expect(decl.superTyAnnotations[1].toString().replace("\r\n", "\n"), "Inter<S, V>")
        @Expect(decl.genericParams.size, 2)
        @Expect(decl.genericParams[0].name, "S")
        @Expect(decl.genericParams[1].name, "V")
        let genericConstraints = decl.genericConstraints.getOrThrow()
        @Expect(genericConstraints.constraints.size, 2)
        @Expect(genericConstraints.constraints[0].toString().replace("\r\n", "\n"), "S <: B")
        @Expect(genericConstraints.constraints[1].toString().replace("\r\n", "\n"), "V <: ToString")
        @Expect(decl.body.toString().replace("\r\n", "\n"), "{}")
        @Expect(decl.toString().replace("\r\n", "\n"), "abstract class E<S, V> <: ToString & Inter<S, V> where S <: B, V <: ToString {}")

        var pos = decl.getClassKeyWordPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 10, 11, 15]).toArray())
        pos = decl.getIdentifierPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 16, 11, 17]).toArray())
        pos = decl.getGenericParamsLAnglePos().getOrThrow()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 17, 11, 18]).toArray())
        @Expect(decl.getGenericParamsCommasPos().size, 1)
        pos = decl.getGenericParamsCommasPos()[0]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 19, 11, 20]).toArray())
        pos = decl.getGenericParamsRAnglePos().getOrThrow()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 22, 11, 23]).toArray())
        pos = decl.getUpperBoundPos().getOrThrow()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 24, 11, 26]).toArray())
        @Expect(decl.getSuperTyAnnotationsBitAndsPos().size, 1)
        pos = decl.getSuperTyAnnotationsBitAndsPos()[0]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 36, 11, 37]).toArray())
        pos = decl.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([11, 1, 11, 80]).toArray())
    }

    @TestCase
    func testDecl06() {
        let decl = (decls[5] as ClassDecl).getOrThrow()
        @Expect(decl.modifiers.size, 0)
        @Expect(decl.name, "F")
        @Expect(decl.superTyAnnotations.size, 0)
        @Expect(decl.genericParams.size, 0)
        @Expect(decl.genericConstraints.isNone())
        @Expect(decl.body.toString().replace("\r\n", "\n"), """
{
    let a = 1
    var b: Int64

    init() {
        b = 4
    }

    func testFunc(c: Int64, d: UInt32) {}

    prop e: String {
        get() { return "hello" }
    }
}""")
        @Expect(decl.toString().replace("\r\n", "\n"), """
class F {
    let a = 1
    var b: Int64

    init() {
        b = 4
    }

    func testFunc(c: Int64, d: UInt32) {}

    prop e: String {
        get() { return "hello" }
    }
}""")
    }

    @TestCase
    func testClassDeclInit() {
        let decl = (decls[3] as ClassDecl).getOrThrow()
        let classDecl = ClassDecl(decl.body, decl.genericConstraints, decl.genericParams, decl.name, decl.superTyAnnotations, annotations: decl.annotations, modifiers: decl.modifiers)
        @Expect(classDecl.modifiers.size, 0)
        @Expect(classDecl.name, "D")
        @Expect(classDecl.superTyAnnotations.size, 0)
        @Expect(classDecl.genericParams.size, 1)
        @Expect(classDecl.genericParams[0].name, "T")
        let genericConstraints = classDecl.genericConstraints.getOrThrow()
        @Expect(genericConstraints.constraints.size, 1)
        @Expect(genericConstraints.constraints[0].toString().replace("\r\n", "\n"), "T <: B")
        @Expect(classDecl.body.toString().replace("\r\n", "\n"), "{}")
        @Expect(classDecl.toString().replace("\r\n", "\n"), "class D<T> where T <: B {}")
    }

    @TestCase
    func testBodyInit() {
        let decl = (decls[1] as ClassDecl).getOrThrow()
        let classDecl = ClassDecl(decl.body, decl.genericConstraints, decl.genericParams, decl.name, decl.superTyAnnotations, annotations: decl.annotations, modifiers: decl.modifiers)
        @Expect(classDecl.modifiers.size, 2)
        @Expect(classDecl.name, "B")
        @Expect(classDecl.superTyAnnotations.size, 0)
        @Expect(classDecl.genericParams.size, 0)
        @Expect(classDecl.genericConstraints.isNone())
        let body = Body(classDecl.body.memberDecls)
        @Expect(body.toString().replace("\r\n", "\n"), """
{
    var a = 1
}""")
        @Expect(classDecl.toString().replace("\r\n", "\n"), """
public abstract class B {
    var a = 1
}""")
    }

    @TestCase
    func testFileToString() {
        let node = parseFile("class_decl.cj")
        let input = String.fromUtf8(File.readFrom("class_decl.cj"))
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        @Expect(file.toString(), input)
    }
}

