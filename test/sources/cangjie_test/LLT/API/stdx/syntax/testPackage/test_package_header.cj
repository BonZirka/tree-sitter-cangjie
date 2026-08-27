/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: sourceFile/packageHeader
// (not Windows) EXEC: find packageHeader -type f -exec dos2unix {} \;
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f %cmp_utest_opt
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args

import stdx.syntax.*
import std.fs.*
import std.collection.ArrayList

@Test
class Test {
    @TestCase
    func test_modifier_01() {
        let node = parseFile("packageHeader/access_modifier_01.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.accessModifier.isNone())
        @Expect(header.toString().replace("\r\n", "\n"), "package testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/access_modifier_01.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_modifier_02() {
        let node = parseFile("packageHeader/access_modifier_02.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let modifier = header.accessModifier.getOrThrow()
        match (modifier.kind) {
            case ModifierKind.Public => ()
            case _ => @FailExpect("The kind is wrong.")
        }
        @Expect(header.toString().replace("\r\n", "\n"), "public package testPackage")
        @Expect(header.toTokens().toString().replace("\r\n", "\n"), "public package testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/access_modifier_02.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_modifier_03() {
        let node = parseFile("packageHeader/access_modifier_03.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let modifier = header.accessModifier.getOrThrow()
        match (modifier.kind) {
            case ModifierKind.Internal => ()
            case _ => @FailExpect("The kind is wrong.")
        }
        @Expect(header.toString().replace("\r\n", "\n"), "internal package testPackage.childPackage")

        var pos = header.nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 42]).toArray())
        pos = header.accessModifier.getOrThrow().nodePos
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 9]).toArray())
        pos = header.getPackageKeyWordPos()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 10, 1, 17]).toArray())
        pos = header.getPackageIdentifiersPos()[0]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 18, 1, 29]).toArray())
        pos = header.getDotsPos()[0]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 29, 1, 30]).toArray())
        pos = header.getPackageIdentifiersPos()[1]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 30, 1, 42]).toArray())
        let input = String.fromUtf8(File.readFrom("packageHeader/access_modifier_03.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_modifier_04() {
        let node = parseFile("packageHeader/access_modifier_04.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let modifier = header.accessModifier.getOrThrow()
        match (modifier.kind) {
            case ModifierKind.Protected => ()
            case _ => @FailExpect("The kind is wrong.")
        }
        @Expect(header.toString().replace("\r\n", "\n"), "protected package testPackage.childPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/access_modifier_04.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_is_macro_01() {
        let node = parseFile("packageHeader/is_macro_01.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.isMacroPkg, false)
        @Expect(header.toString().replace("\r\n", "\n"), "package testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/is_macro_01.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_is_macro_02() {
        let node = parseFile("packageHeader/is_macro_02.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.isMacroPkg, true)
        @Expect(header.toString().replace("\r\n", "\n"), "macro package testPackage")

        var pos = header.getMacroKeyWordPos().getOrThrow()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 6]).toArray())
        let input = String.fromUtf8(File.readFrom("packageHeader/is_macro_02.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_identifiers_01() {
        let node = parseFile("packageHeader/identifiers_01.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.packageNameIdentifiers.size, 1)
        @Expect(header.packageNameIdentifiers[0], "testPackage")
        @Expect(header.getPackageName(), "testPackage")
        @Expect(header.toString().replace("\r\n", "\n"), "package testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/identifiers_01.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_identifiers_02() {
        let node = parseFile("packageHeader/identifiers_02.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.packageNameIdentifiers.size, 2)
        @Expect(header.packageNameIdentifiers[0], "A")
        @Expect(header.packageNameIdentifiers[1], "testPackage")
        @Expect(header.getParentPackageName(), "A")
        @Expect(header.getPackageName(), "testPackage")
        @Expect(header.toString().replace("\r\n", "\n"), "package A.testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/identifiers_02.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func test_identifiers_03() {
        let node = parseFile("packageHeader/identifiers_03.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        @Expect(header.packageNameIdentifiers.size, 3)
        @Expect(header.packageNameIdentifiers[0], "A")
        @Expect(header.packageNameIdentifiers[1], "B")
        @Expect(header.packageNameIdentifiers[2], "testPackage")
        @Expect(header.getParentPackageName(), "A.B")
        @Expect(header.getPackageName(), "testPackage")
        @Expect(header.toString().replace("\r\n", "\n"), "package A.B.testPackage")

        let input = String.fromUtf8(File.readFrom("packageHeader/identifiers_03.cj"))
        @Expect(file.toString(), input)
    }

    @TestCase
    func testPackageHeaderInit01() {
        let node = parseFile("packageHeader/identifiers_03.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let packageHeader = PackageHeader(header.accessModifier, header.isMacroPkg, header.packageNameIdentifiers)
        @Expect(packageHeader.packageNameIdentifiers.size, 3)
        @Expect(packageHeader.packageNameIdentifiers[0], "A")
        @Expect(packageHeader.packageNameIdentifiers[1], "B")
        @Expect(packageHeader.packageNameIdentifiers[2], "testPackage")
        @Expect(packageHeader.getParentPackageName(), "A.B")
        @Expect(packageHeader.getPackageName(), "testPackage")
        @Expect(packageHeader.toString().replace("\r\n", "\n"), "package A.B.testPackage")
    }

    @TestCase
    func testPackageHeaderInit02() {
        let node = parseFile("packageHeader/access_modifier_04.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let packageHeader = PackageHeader(header.accessModifier, header.isMacroPkg, header.packageNameIdentifiers)
        let modifier = packageHeader.accessModifier.getOrThrow()
        match (modifier.kind) {
            case ModifierKind.Protected => ()
            case _ => @FailExpect("The kind is wrong.")
        }
        @Expect(packageHeader.toString().replace("\r\n", "\n"), "protected package testPackage.childPackage")
    }

    @TestCase
    func testPackageHeaderInit03() {
        let node = parseFile("packageHeader/is_macro_02.cj")
        let file = (node.node.getOrThrow() as SourceFile).getOrThrow()
        let header = file.pkgHeader.getOrThrow()
        let packageHeader = PackageHeader(header.accessModifier, header.isMacroPkg, header.packageNameIdentifiers)
        @Expect(packageHeader.isMacroPkg, true)
        @Expect(packageHeader.toString().replace("\r\n", "\n"), "macro package testPackage")

        var pos = packageHeader.getMacroKeyWordPos().getOrThrow()
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 1, 1, 6]).toArray())
    }

    @TestCase
    func testPackageHeaderInit04() {
        let packageHeader = PackageHeader(Modifier(ModifierKind.Public), false, ["stdx", "syntax"])
        @Expect(packageHeader.isMacroPkg, false)
        @Expect(packageHeader.toString().replace("\r\n", "\n"), "public package stdx.syntax")

        var pos = packageHeader.getDotsPos()[0]
        @Expect([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], ArrayList<Int32>([1, 20, 1, 21]).toArray())
    }
}