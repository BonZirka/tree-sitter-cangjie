/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: file
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.fs.*
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_filepath_005() {
    let path_str = "./仓�"
    Directory.create(path_str, recursive: true)
    rename("./file", to: path_str, overwrite: true)
    let res = parseFile(path_str + "/file001.cj")
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
    @Assert(sourcefile.toString().contains(str))
}
}