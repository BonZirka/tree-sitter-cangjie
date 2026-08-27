/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %mkdir dir003
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_dirpath_006() {
    let res = parsePackage("./dir003")
    var diags = res.diags
    @Assert(diags.size, 0)

    let _package: Package = res.node.getOrThrow()
    @Assert(_package.toString(), "")
    @Assert(_package.isMacroPkg, false)
    @Assert(_package.name, "")
    @Assert(_package.srcFile.size, 0)
}
}