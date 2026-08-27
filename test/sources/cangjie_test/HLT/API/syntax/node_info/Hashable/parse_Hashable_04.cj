/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Hashable_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_hashable_004() {
    let res = parseFile("./Hashable_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    let classdecl = sourcefile.topLevelDecls[0]
    let maindecl = sourcefile.topLevelDecls[1]
    let _package = sourcefile.pkgHeader.getOrThrow()
    let _imports = sourcefile.importLists[0]
    @Assert(sourcefile.hashCode() != classdecl.hashCode())
    @Assert(sourcefile.hashCode() != maindecl.hashCode())
    @Assert(sourcefile.hashCode() != _package.hashCode())
    @Assert(sourcefile.hashCode() != _imports.hashCode())

    @Assert(maindecl.hashCode() != classdecl.hashCode())
    @Assert(_package.hashCode() != classdecl.hashCode())
    @Assert(_imports.hashCode() != _package.hashCode())

    @Assert(classdecl.hashCode() == classdecl.hashCode())
    @Assert(maindecl.hashCode() == maindecl.hashCode())
    @Assert(_package.hashCode() == _package.hashCode())
    @Assert(_imports.hashCode() == _imports.hashCode())
}
}