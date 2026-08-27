/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: file001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.fs.*
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_filepath_002() {
    let path_str = canonicalize("./file001.cj").toString()
    println(path_str)
    let res = parseFile(path_str)
    var diags = res.diags
    @Assert(diags.size, 0)

    let sourcefile: SourceFile = res.node.getOrThrow()
    let str = ##"package a.b.c

func foo<T>(a: T) {
    a
}

main() {
    let a = foo<Int64>(0)
    return a
}"##
   // @Assert(sourcefile.toString().replace("\n",""), str.replace("\n",""))
}
}