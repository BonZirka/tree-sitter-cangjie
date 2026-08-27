/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: Equatable_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import stdx.syntax.*

// 节点和从属的父节点各不相�
@Test
class test_01{
    @TestCase
func test_file_001() {
    let res = parseFile("./Equatable_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    let classdecl = sourcefile.topLevelDecls[0]
    let maindecl = sourcefile.topLevelDecls[1]
    let _package = sourcefile.pkgHeader.getOrThrow()
    let _imports = sourcefile.importLists[0]
    @Assert(sourcefile != classdecl)
    @Assert(sourcefile != maindecl)
    @Assert(sourcefile != _package)
    @Assert(sourcefile != _imports)

    @Assert(maindecl != classdecl)
    @Assert(_package != classdecl)
    @Assert(_imports != _package)

    @Assert(classdecl == classdecl)
    @Assert(maindecl == maindecl)
    @Assert(_package == _package)
    @Assert(_imports == _imports)
}
}