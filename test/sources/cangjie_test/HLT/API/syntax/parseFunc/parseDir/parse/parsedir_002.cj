/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: dir002
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_dir_002() {
    let res = parsePackage("./dir002")
    var diags = res.diags
    @Assert(diags.size, 0)

    let _package: Package = res.node.getOrThrow()
    @Assert(_package.toString().contains("file_001.cj"))
    @Assert(_package.toString().contains("public macro package a.b.ccc"))
    @Assert(_package.toString().contains("file_002.cj"))
    @Assert(_package.toString().contains("public macro package a.b.ccc"))
    @Assert(_package.isMacroPkg, true)
    @Assert(_package.name, "a.b.ccc")
    @Assert(_package.srcFile.size, 2)
    let file1 = _package.srcFile[0]
    let file2 = _package.srcFile[1]

    let str1 = ##"public macro package a.b.ccc"##
    @Assert(file1.toString().contains(str1))
    @Assert(file1.importLists.size, 0)
    @Assert(file1.name, "file_001.cj")
    println(file1.path)
    @Assert(file1.path.contains("file_001.cj"))
    @Assert(file1.pkgHeader.isSome())
    let pkgHeader = file1.pkgHeader.getOrThrow()
    @Assert(pkgHeader.accessModifier.isSome())
    @Assert(pkgHeader.isMacroPkg, true)
    @Assert(pkgHeader.packageNameIdentifiers, ["a", "b", "ccc"])
    @Assert(file1.topLevelDecls.size, 0)

    let str2 = ##"public macro package a.b.ccc"##
    @Assert(file1.toString().contains(str2))
    @Assert(file2.importLists.size, 0)
    @Assert(file2.name, "file_002.cj")
    println(file2.path)
    @Assert(file2.path.contains("file_002.cj"))
    @Assert(file2.pkgHeader.isSome())
    let _pkgHeader = file2.pkgHeader.getOrThrow()
    @Assert(_pkgHeader.accessModifier.isSome())
    @Assert(_pkgHeader.isMacroPkg, true)
    @Assert(_pkgHeader.packageNameIdentifiers, ["a", "b", "ccc"])
    @Assert(file2.topLevelDecls.size, 0)
}
}