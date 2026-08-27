/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: Error_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 

import std.fs.*
import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_errorinfo_002() {
    @AssertThrows[Exception](parseText(String.fromUtf8(File.readFrom("./Error_01.cj"))))
}
}