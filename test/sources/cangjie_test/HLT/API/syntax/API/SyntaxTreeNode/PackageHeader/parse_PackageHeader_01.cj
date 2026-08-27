/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: PackageHeader_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_PackageHeader_01() {
    let res = parseFile("./PackageHeader_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    let pkgHeader = sourcefile.pkgHeader.getOrThrow()
    @Assert(pkgHeader.toString(), "public macro package a.b.c.d.e.f.g.h.i.j.k")
    @Assert(pkgHeader.accessModifier.getOrThrow().toString(), "public")
    @Assert(pkgHeader.isMacroPkg)
    @Assert(pkgHeader.packageNameIdentifiers.toString(), "[a, b, c, d, e, f, g, h, i, j, k]")

    var posList = pkgHeader.getDotsPos()
    @Assert(posList.size == 10, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 23i32, 9i32, 24i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [9i32, 25i32, 9i32, 26i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [9i32, 27i32, 9i32, 28i32])
    @Assert([posList[3].beginLine, posList[3].beginColumn, posList[3].endLine, posList[3].endColumn], [9i32, 29i32, 9i32, 30i32])
    @Assert([posList[4].beginLine, posList[4].beginColumn, posList[4].endLine, posList[4].endColumn], [9i32, 31i32, 9i32, 32i32])
    @Assert([posList[5].beginLine, posList[5].beginColumn, posList[5].endLine, posList[5].endColumn], [9i32, 33i32, 9i32, 34i32])
    @Assert([posList[6].beginLine, posList[6].beginColumn, posList[6].endLine, posList[6].endColumn], [9i32, 35i32, 9i32, 36i32])
    @Assert([posList[7].beginLine, posList[7].beginColumn, posList[7].endLine, posList[7].endColumn], [9i32, 37i32, 9i32, 38i32])
    @Assert([posList[8].beginLine, posList[8].beginColumn, posList[8].endLine, posList[8].endColumn], [9i32, 39i32, 9i32, 40i32])
    @Assert([posList[9].beginLine, posList[9].beginColumn, posList[9].endLine, posList[9].endColumn], [9i32, 41i32, 9i32, 42i32])
    var pos = pkgHeader.getMacroKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [9i32, 8i32, 9i32, 13i32])
    posList = pkgHeader.getPackageIdentifiersPos()
    @Assert(posList.size, 11)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [9i32, 22i32, 9i32, 23i32])
    @Assert([posList[1].beginLine, posList[1].beginColumn, posList[1].endLine, posList[1].endColumn], [9i32, 24i32, 9i32, 25i32])
    @Assert([posList[2].beginLine, posList[2].beginColumn, posList[2].endLine, posList[2].endColumn], [9i32, 26i32, 9i32, 27i32])
    @Assert([posList[3].beginLine, posList[3].beginColumn, posList[3].endLine, posList[3].endColumn], [9i32, 28i32, 9i32, 29i32])
    @Assert([posList[4].beginLine, posList[4].beginColumn, posList[4].endLine, posList[4].endColumn], [9i32, 30i32, 9i32, 31i32])
    @Assert([posList[5].beginLine, posList[5].beginColumn, posList[5].endLine, posList[5].endColumn], [9i32, 32i32, 9i32, 33i32])
    @Assert([posList[6].beginLine, posList[6].beginColumn, posList[6].endLine, posList[6].endColumn], [9i32, 34i32, 9i32, 35i32])
    @Assert([posList[7].beginLine, posList[7].beginColumn, posList[7].endLine, posList[7].endColumn], [9i32, 36i32, 9i32, 37i32])
    @Assert([posList[8].beginLine, posList[8].beginColumn, posList[8].endLine, posList[8].endColumn], [9i32, 38i32, 9i32, 39i32])
    @Assert([posList[9].beginLine, posList[9].beginColumn, posList[9].endLine, posList[9].endColumn], [9i32, 40i32, 9i32, 41i32])
    @Assert([posList[10].beginLine, posList[10].beginColumn, posList[10].endLine, posList[10].endColumn], [9i32, 42i32, 9i32, 43i32])
    @Assert(pkgHeader.getPackageName(), "k")
    @Assert(pkgHeader.getParentPackageName(), "a.b.c.d.e.f.g.h.i.j")
}
}