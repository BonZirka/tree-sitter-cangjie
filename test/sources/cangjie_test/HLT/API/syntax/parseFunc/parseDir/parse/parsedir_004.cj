/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: dir003
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args | compare %f
// ASSERT: scan possibly confusing line terminator

import std.fs.*
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_dir_004() {
    let res = parsePackage("./dir003")
    var diags = res.diags
    @Assert(diags.size, 1)
    match (diags[0].diagInfo) {
        case DiagnosticInfo.Warning(a, b) =>
            println(a);
            println(b)
        case _ => ()
    }
    let _package: Package = res.node.getOrThrow()

    let str = ##"// file_001.cj

let a1 = 1
+ 1
// file_002.cj

let a2 = a1 + 1 + 1234"##
    @Assert(_package.toString().contains("file_001.cj"))
    @Assert(_package.toString().replace("\r","").contains(##"let a1 = 1
+ 1"##))
    @Assert(_package.toString().contains("file_002.cj"))
    @Assert(_package.toString().contains("let a2 = a1 + 1 + 1234"))
    @Assert(_package.isMacroPkg, false)
    @Assert(_package.name, "default")
    @Assert(_package.srcFile.size, 2)
    let file1 = _package.srcFile[0]
    let file2 = _package.srcFile[1]

    let str1 = ##"
let a1 = 1
+ 1"##
    @Assert(file1.toString().replace("\r","").contains(str1))
    @Assert(file1.importLists.size, 0)
    @Assert(file1.name, "file_001.cj")
    println(file1.path)
    @Assert(file1.path.contains("file_001.cj"))
    @Assert(file1.pkgHeader.isNone())
    @Assert(file1.topLevelDecls.size, 1)

    let str2 = ##"
let a2 = a1 + 1 + 1234"##
    @Assert(file2.toString().replace("\r","").contains(str2))
    @Assert(file2.importLists.size, 0)
    @Assert(file2.name, "file_002.cj")
    println(file2.path)
    @Assert(file2.path.contains("file_002.cj"))
    @Assert(file2.pkgHeader.isNone())
    @Assert(file2.topLevelDecls.size, 1)
}
}