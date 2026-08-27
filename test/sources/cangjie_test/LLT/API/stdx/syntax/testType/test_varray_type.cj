/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: sourceFile/varray_type.cj
// (not Windows) EXEC: dos2unix varray_type.cj
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args

import stdx.syntax.*
import std.fs.*
import std.collection.ArrayList

@Test
class Test {
    var decls: Array<Decl> = []

    @BeforeAll
    func readTypes(): Unit {
        let node = parseFile("varray_type.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        decls = file.topLevelDecls
    }

    @TestCase
    func testType01() {
        let varDecl = (decls[1] as VarDecl).getOrThrow()
        let ty = (varDecl.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()

        @Expect(ty.elementType is AtomicType)
        @Expect(ty.elementType.toString().replace("\r\n", "\n"), "Int32")
        @Expect(ty.size, 0)
        @Expect(ty.toString().replace("\r\n", "\n"), "VArray<Int32 , $0>")
        @Expect(ty.toTokens().toString().replace("\r\n", "\n"), "VArray < Int32, $0 >")

        var pos = ty.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 8, 2, 26]).toArray())
        pos = ty.getVArrayPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 8, 2, 14]).toArray())
        pos = ty.getLAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 14, 2, 15]).toArray())
        pos = ty.getRAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 25, 2, 26]).toArray())
        pos = ty.getDollarPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 23, 2, 24]).toArray())
        pos = ty.getCommaPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([2, 21, 2, 22]).toArray())
    }

    @TestCase
    func testType02() {
        let varDecl = (decls[2] as VarDecl).getOrThrow()
        let ty = (varDecl.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()

        @Expect(ty.elementType is TupleType)
        @Expect(ty.elementType.toString().replace("\r\n", "\n"), "(Int32, Int32)")
        @Expect(ty.size, 5)
        @Expect(ty.toString().replace("\r\n", "\n"), "VArray<(Int32, Int32), $5>")

        var pos = ty.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 8, 3, 34]).toArray())
        pos = ty.getVArrayPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 8, 3, 14]).toArray())
        pos = ty.getLAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 14, 3, 15]).toArray())
        pos = ty.getRAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 33, 3, 34]).toArray())
        pos = ty.getDollarPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 31, 3, 32]).toArray())
        pos = ty.getCommaPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([3, 29, 3, 30]).toArray())
    }

    @TestCase
    func testType03() {
        let funcDecl = (decls[0] as FuncDecl).getOrThrow()
        let ty = (funcDecl.retTyAnnotation.getOrThrow() as VArrayType).getOrThrow()

        @Expect(ty.toString().replace("\r\n", "\n"), "VArray<Int32, $0>")

        var pos = ty.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 18, 1, 35]).toArray())
        pos = ty.getVArrayPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 18, 1, 24]).toArray())
        pos = ty.getLAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 24, 1, 25]).toArray())
        pos = ty.getRAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 34, 1, 35]).toArray())
        pos = ty.getDollarPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 32, 1, 33]).toArray())
        pos = ty.getCommaPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 30, 1, 31]).toArray())
    }

    @TestCase
    func testFileToString() {
        let node = parseFile("varray_type.cj")
        let input = String.fromUtf8(File.readFrom("varray_type.cj"))
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        @Expect(file.toString(), input)
    }

    @TestCase
    func testInit01() {
        let varDecl = (decls[1] as VarDecl).getOrThrow()
        let ty = (varDecl.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()
        let vArrayType = VArrayType(ty.elementType, ty.size)

        @Expect(vArrayType.elementType is AtomicType)
        @Expect(vArrayType.elementType.toString().replace("\r\n", "\n"), "Int32")
        @Expect(vArrayType.size, 0)
        @Expect(vArrayType.toString().replace("\r\n", "\n"), "VArray<Int32, $0>")

        var pos = vArrayType.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 18]).toArray())
        pos = vArrayType.getVArrayPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 7]).toArray())
        pos = vArrayType.getLAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 7, 1, 8]).toArray())
        pos = vArrayType.getRAnglePos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 17, 1, 18]).toArray())
        pos = vArrayType.getDollarPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 15, 1, 16]).toArray())
        pos = vArrayType.getCommaPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 13, 1, 14]).toArray())
    }

    @TestCase
    func testInit02() {
        let varDecl = (decls[1] as VarDecl).getOrThrow()
        let ty = (varDecl.tyAnnotation.getOrThrow() as VArrayType).getOrThrow()
        @AssertThrows[Exception](VArrayType(ty.elementType, -1))
    }
}
