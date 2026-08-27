/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: dir001
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.fs.*
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_dirpath_004() {
    let path_str = "./aaaaa/bbbbb/cccccc/dddddd/eeee/ffffff/ddddddd/ffffff/dddddd/ffffff/ddddd/仓�/aaaa/dddd/"
    Directory.create(path_str, recursive: true)
    rename("./dir001", to: path_str, overwrite: true)
    let res = parsePackage(path_str)
    var diags = res.diags
    @Assert(diags.size, 0)

    let _package: Package = res.node.getOrThrow()
    let str = ##"// a1.cj
package dir001

public func foo1() {
    return a1
}
// b1.cj
package dir001

public let b1 = a2

public func foo2() {
    return foo1()
}"##
    @Assert(_package.toString().contains("a1.cj"))
    @Assert(_package.toString().contains(##"package dir001

public func foo1() {
    return a1
}"##))
    @Assert(_package.toString().contains("b1.cj"))
    @Assert(_package.toString().contains(##"package dir001

public let b1 = a2

public func foo2() {
    return foo1()
}"##))
    @Assert(_package.isMacroPkg, false)
    @Assert(_package.name, "dir001")
    @Assert(_package.srcFile.size, 2)
}
}