/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Illegal_Comment_01.cj, Illegal_Comment_02.cj, Illegal_Comment_03.cj, Illegal_Comment_04.cj, Illegal_Comment_05.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase[
    path in [
        "./Illegal_Comment_01.cj",
        "./Illegal_Comment_02.cj",
        "./Illegal_Comment_03.cj",
        "./Illegal_Comment_04.cj",
        "./Illegal_Comment_05.cj"
    ]
]
func test_Comment_Illegal(path: String) {
    var res = parseFile(path)
    var diags = res.diags
    @Assert(diags.size, 1)
    match(diags[0].diagInfo) {
        case Error(a, b) => println(a); println(b)
        case _ => ()
    }
}
}